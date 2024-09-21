import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/core/services/message_queue_manager.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import '../model/chat.dart';
import '../model/chat_message.dart';

class FirebaseService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MessageQueueManager messageQueueManager = MessageQueueManager();

  static loginWithPhoneNumber(
    String phoneNumber,
    Function(PhoneAuthCredential credential) verificationCompleted,
    Function(FirebaseAuthException e) verificationFailed,
    Function(String verificationId, int? resendToken) codeSent,
    Function(String verificationId) codeAutoRetrievalTimeout,
  ) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  static getUserData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await fireStore.collection(AppKeys.users).doc(uid).get().then(
      (value) {
        return value;
      },
    );
    return userDoc;
  }

  static Future<bool> doesAccountExist(String phoneNumber) async {
    try {
      // Reference to the collection where your accounts are stored
      CollectionReference users = fireStore.collection('users');

      // Query the collection for the specific phone number
      QuerySnapshot querySnapshot =
          await users.where('phone_number', isEqualTo: phoneNumber).get();

      // Check if any documents were returned
      if (querySnapshot.docs.isNotEmpty) {
        // Account exists
        return true;
      } else {
        // Account does not exist
        return false;
      }
    } catch (e) {
      debugPrint("Error checking if account exists: $e");
      return false;
    }
  }

  static void createUserWithFireStore(user) async {
    await fireStore.collection(AppKeys.users).add(user).then(
      (value) {
        debugPrint(user);
      },
    );
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUsersData() async {
    QuerySnapshot<Map<String, dynamic>> response =
        await fireStore.collection(AppKeys.users).get().then(
      (event) {
        for (var doc in event.docs) {
          print("${doc.id} => ${doc.data()}");
        }
        return event;
      },
    );

    return response;
  }

  static String generateChatId(String userId1, String userId2) {
    List<String> sortedIds = [userId1, userId2]..sort();
    String chatId = '${sortedIds[0]}_${sortedIds[1]}';

    return chatId;
  }

  static Future<void> createChat(
    String chatId,
    Map<String, dynamic> chatData,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppKeys.chats)
          .doc(chatId)
          .set(chatData);
    } catch (e) {
      debugPrint('Error creating chat: $e');
    }
  }

  static Future<DocumentSnapshot> getChat(String chatId) async {
    try {
      DocumentSnapshot chatSnapshot = await FirebaseFirestore.instance
          .collection(AppKeys.chats)
          .doc(chatId)
          .get();
      return chatSnapshot;
    } catch (e) {
      debugPrint('Error getting chat: $e');
      rethrow; // Propagate the error
    }
  }

  static Future<void> createOrGetChat(
      String userId1, String userId2, Map<String, dynamic> chatData) async {
    String chatId = generateChatId(userId1, userId2);
    DocumentSnapshot chatSnapshot = await getChat(chatId);
    if (!chatSnapshot.exists) {
      await createChat(chatId, chatData);
    }
  }

  static Future<void> sendMessage(String chatId, ChatMessage message) async {
    debugPrint("Chat Id $chatId");
    debugPrint(chatId);
    await fireStore.collection(AppKeys.chats).doc(chatId).update(
      {
        AppKeys.chatMessages: FieldValue.arrayUnion([message.toJson()]),
        AppKeys.lastMessage: message.toJson(),
      },
    );

    await fireStore.collection(AppKeys.chats).doc(chatId).update({
      AppKeys.lastMessage: message.toJson(),
    });

    debugPrint("FireStore send message done ");
  }

  static Future<void> updateMessageFiled({
    required String chatId,
    required String messageId,
    required String fieldName,
    required dynamic newValue,
  }) async {
    debugPrint("Chat id $chatId");

    DocumentReference chatDocRef = fireStore.collection('chats').doc(chatId);

    try {
      // Get the chat document
      DocumentSnapshot chatDoc = await chatDocRef.get();

      List<dynamic> chatMessages = chatDoc.get('chat_messages');

      // Find the message object that needs to be updated
      Map<String, dynamic>? messageToUpdate;

      for (var message in chatMessages) {
        if (message['message_id'] == messageId) {
          messageToUpdate = message;
          break;
        }
      }

      if (messageToUpdate != null) {
        // Remove the old message object
        await chatDocRef.update({
          'chat_messages': FieldValue.arrayRemove([messageToUpdate]),
        });

        // Update the isPlayed field
        messageToUpdate[fieldName] = newValue;

        // Add the updated message object back to the array
        await chatDocRef.update({
          'chat_messages': FieldValue.arrayUnion([messageToUpdate]),
        });

        debugPrint(' $fieldName updated successfully');
      } else {
        debugPrint('Message not found');
      }
    } catch (e) {
      debugPrint('Failed to update $fieldName field: $e');
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> listenToMessages(
      String chatId) {
    return fireStore.collection(AppKeys.chats).doc(chatId).snapshots();
  }

  static updateUnreadMessage(chatId, currentUserId) async {
    var chatJson = await fireStore.collection(AppKeys.chats).doc(chatId).get();
    var chat = Chat.fromJson(chatJson.data()!);
    if (chat.fromUserId == currentUserId) {
      // update from user unread message
      int fromUserNo = chat.fromUserMessagesNum! + 1;

      await fireStore.collection(AppKeys.chats).doc(chatId).update({
        "from_user_messages_num": fromUserNo,
      });
    } else {
      // update to user unread message
      int fromUserNo = chat.toUserMessagesNum! + 1;

      await fireStore.collection(AppKeys.chats).doc(chatId).update({
        "to_user_messages_num": fromUserNo,
      });
    }
  }

  static Future<String> uploadFileToFirebase(File file) async {
    try {
      String fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      Reference storageRef = firebaseStorage.ref().child('voices/$fileName');

      UploadTask uploadTask = storageRef.putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl; // Return the download URL
    } catch (e) {
      debugPrint('Error uploading file to Firebase: $e');
      throw Exception('Failed to upload file'); // Handle or propagate the error
    }
  }

  static Future<List<String>> fetchUserChats() async {
    String userId =
        await _getSenderId(); // Assuming _getSenderId is already implemented
    List<String> chatIds = [];

    final snapshot = await FirebaseFirestore.instance
        .collection(AppKeys.chats)
        .where('users_id', arrayContains: userId)
        .get();

    for (var doc in snapshot.docs) {
      chatIds.add(doc.id);
    }

    return chatIds;
  }

  static listenToChats(
      currentUserId) {
    try{
      return fireStore
          .collection(AppKeys.chats)
          .where('users_id', arrayContains: currentUserId)
          .snapshots();
    }catch(e){
      debugPrint("Listen to chats error $e");
    }

  }

  void startListeningForAllChats() async {
    debugPrint("Start Listening to new messages ");
    List<String> chatIds = await fetchUserChats();

    for (String chatId in chatIds) {
      FirebaseService.listenToMessages(chatId).listen(
        (snapshot) {
          Chat chat = Chat.fromJson(snapshot.data()!);
          List<ChatMessage> newMessages = chat.chatMessages!.where((message) {
            // Filter messages that are new and haven't been played
            return messageQueueManager.isNewMessage(message) &&
                !message.isPlayed! &&
                message.senderId != _getSenderId();
          }).toList();

          if (newMessages.isNotEmpty) {
            messageQueueManager.lastProcessedMessageId =
                newMessages.last.messageId;
            messageQueueManager.messageQueue.addAll(newMessages);
            messageQueueManager.processMessageQueue(chatId);
            print("New messageId ${newMessages[0].messageId}");
          }

          messageQueueManager.isInitialLoad =
              false; // Mark initial load as completed
        },
      );
    }
  }

  static _getSenderId() async {
    SessionProvider sessionProvider = SessionProvider();
    await sessionProvider.loadSession();
    return sessionProvider.session!.userId;
  }

  static Future<void> clearUnreadMessages(String receiverId) async {
    debugPrint("Clear Messages $receiverId");

    try {
      String fromUserId = await _getSenderId();
      String chatId = FirebaseService.generateChatId(fromUserId, receiverId);

      debugPrint("Clear Messages $chatId");

      DocumentReference chatDoc = fireStore.collection('chats').doc(chatId);

      DocumentSnapshot chatSnapshot = await chatDoc.get();

      if (chatSnapshot.exists) {
        String currentFromUserId =
            chatSnapshot.get('from_user_id');

        if (currentFromUserId == fromUserId) {
          await chatDoc.update({
            'to_user_messages_num': 0,
          });
          debugPrint('to_user_messages_num updated successfully');
        } else {
          await chatDoc.update({
            'from_user_messages_num': 0,
          });

          debugPrint('User ID does not match the from_user_id');
        }
      } else {
        debugPrint('Chat not found');
      }
    } catch (e) {
      debugPrint('Error updating from_user_messages_num: $e');
    }
  }
}

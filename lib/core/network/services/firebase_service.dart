import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import '../model/chat.dart';
import '../model/chat_message.dart';

class FirebaseService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

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
      String chatId, Map<String, dynamic> chatData) async {
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
      // Handle error appropriately
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

  static Stream<DocumentSnapshot<Map<String, dynamic>>> listenToMessages(
      String chatId) {
    return fireStore.collection(AppKeys.chats).doc(chatId).snapshots();
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
 static void startListeningForAllChats() async {
    print("Start Listening to new messages ");
      List<String> chatIds = await fetchUserChats();
      for (String chatId in chatIds) {
          FirebaseService.listenToMessages(chatId).listen(
                  (snapshot) {
                  Chat chat = Chat.fromJson(snapshot.data()!);
                  List<ChatMessage> newMessages = chat.chatMessages!;

                  if (newMessages.isNotEmpty) {
                      print(newMessages[0].senderId);
                  }
                  },
          );
      }
  }
 static _getSenderId() async {
    SessionProvider sessionProvider = SessionProvider();
    await sessionProvider.loadSession();
    return sessionProvider.session!.userId;
  }
}

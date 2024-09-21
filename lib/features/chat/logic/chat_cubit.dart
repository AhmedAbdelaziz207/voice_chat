import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:voice_chat/core/network/model/chat.dart';
import 'package:voice_chat/core/network/model/chat_message.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/network/services/firebase_service.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/features/chat/logic/chat_state.dart';
import '../../../core/services/audio_manager.dart';

class ChatCubit extends Cubit<ChatState> {
    ChatCubit() : super(ChatInitial());
    Map<String, bool> isPlayingMap = {};

    String senderId = "";
    String receiverId = "";
    String chatId = "";
    bool _isRecording = false;
    String messageId = "";
    List<ChatMessage> messages = [];
   AudioManager audioManager = AudioManager();
    AudioRecorder audioRecorder = AudioRecorder();
    String path = "";

    Map<String, Duration> positionMap = {}; // Track position per message

    void updatePosition(String messageId, Duration position) {
        positionMap[messageId] = position;
        emit(PositionUpdated(positionMap: positionMap));
    }

    Duration getPosition(String messageId) {
        return positionMap[messageId] ?? Duration.zero;
    }

    Future<void> startRecord() async {
        try {
            if (await audioRecorder.hasPermission()) {
                var location = await getApplicationDocumentsDirectory();
                messageId = const Uuid().v1();
                path = "${location.path}$messageId.m4a";
                await audioRecorder.start(const RecordConfig(), path: path);

                changeRecordingState();
            } else {
                emit(AudioRecordingFailed(
                        failedMessage: "Recording permission not granted"));
                debugPrint("Recording permission not granted");
            }
        } catch (e) {
            debugPrint("Failed to start recording: $e");
        }
    }

    Future<void> stopRecording(String userId) async {
        try {
            receiverId = userId;
            changeRecordingState();
            String? recordPath =
            await audioRecorder.stop(); // this returns the record path

            if (recordPath != null) {
                emit(AudioRecordingStopped(recordPath: recordPath));
                uploadAudio(recordPath);
            } else {
                emit(AudioRecordingFailed(failedMessage: "Failed to stop recording"));
            }
        } catch (e) {
            emit(AudioRecordingFailed(failedMessage: e.toString()));
        }
    }

    Future<void> uploadAudio(String filePath) async {
        File file = File(filePath);
        try {
            // Upload audio file to Firebase
            String downloadUrl = await FirebaseService.uploadFileToFirebase(file);
            emit(AudioUploaded(downloadUrl: downloadUrl));

            // Get sender ID and chat ID
            String senderId = await _getSenderId();
            chatId = await _getChatId(receiverId);

            // Create chat message with a default duration
            ChatMessage chatMessage = ChatMessage(
                messageContent: downloadUrl,
                receiverId: receiverId,
                type: MessageType.voice,
                senderId: senderId,
                messageId: messageId,
                messageDuration: 0.0,
                // Initialize with a default value
                isPlayed: false,
                dateTime: DateTime.now(),
            );

            // Get message duration
            Duration duration;
            try {
                duration = await audioManager.getMessageDuration(chatMessage);
                chatMessage.messageDuration =
                duration.inSeconds.toDouble(); // Set duration as double
                print('Duration: ${duration.inSeconds} seconds');
            } catch (e) {
                print('Error retrieving message duration: $e');
                // Set a default duration if an error occurs
                chatMessage.messageDuration = 1.00; // Default value
                duration = Duration.zero;
            }

            // Send message
            await sendMessage(chatMessage);
        } catch (e) {
            emit(AudioUploadFailed(failedMessage: e.toString()));
            debugPrint('Error: $e');
        }
    }

    getChatMessages(receiverId) async {
        String chatId = await _getChatId(receiverId);
        this.chatId = chatId;

        FirebaseService.listenToMessages(chatId).listen(
            (snapshot) {
                Chat chat = Chat.fromJson(snapshot.data()!);
                messages = chat.chatMessages!;
                emit(ChatMessagesLoaded(messages: messages));
            },
        );
    }

    Future<void> getOrCreateChat(UserModel receiverUser) async {
        try {
            String chatId = await _getChatId(receiverUser.userId!);
            this.chatId = chatId;
            debugPrint("Create Chat userName ${receiverUser.name}");
            SessionProvider sessionProvider = SessionProvider();
            await sessionProvider.loadSession();
            String? fromUserName = sessionProvider.session!.userName ?? "No name";
            Chat chat = Chat(
                fromUserId: senderId,
                toUserId: receiverUser.userId!,
                chatMessages: [],
                toUserName: receiverUser.name ?? "No name",
                fromUserName: fromUserName,
                usersId: [senderId, receiverUser.userId!],
                chatId: chatId,
            );

            await FirebaseService.createOrGetChat(
                senderId, receiverUser.userId!, chat.toJson());
        } catch (e) {
            debugPrint("Failed to get or create chat: $e");
        }
    }

    Future<void> sendMessage(ChatMessage message) async {
        try {
            debugPrint("Start send successfully");

            String chatId = await _getChatId(receiverId);
            await FirebaseService.sendMessage(chatId, message);
            await FirebaseService.updateUnreadMessage(chatId, senderId);
            debugPrint("Message sent successfully");
        } catch (e) {
            debugPrint("Failed to send message: $e");
        }
    }

    updateMessageStatus(ChatMessage message, receiverId) async {
        debugPrint("Update Message ");

        SessionProvider sessionProvider = SessionProvider();
        await sessionProvider.loadSession();
        senderId = sessionProvider.session!.userId!;
        String chatId = FirebaseService.generateChatId(senderId, receiverId);
        await FirebaseService.updateMessageFiled(
            chatId: chatId,
            messageId: message.messageId!,
            fieldName: "is_played",
            newValue: true,
        );
    }

    void changeRecordingState() {
        _isRecording = !_isRecording;
        emit(ChatRecording(isRecording: _isRecording));
    }

    playAudio(message) async {
        await audioManager.playAudio(message);
        isPlayingMap[message.messageId] = true;
        emit(AudioStartPlaying(isPlaying: isPlayingMap));
    }

    stopAudio(message) async {
        await audioManager.stopAudio();
        isPlayingMap[message.messageId] = false;

        emit(AudioStopPlaying(isPlaying: isPlayingMap));
    }

    Future<String> _getSenderId() async {
        if (senderId.isEmpty) {
            SessionProvider sessionProvider = SessionProvider();
            await sessionProvider.loadSession();
            senderId = sessionProvider.session!.userId!;
        }
        return senderId;
    }

    Future<String> _getChatId(String receiverId) async {
        String senderId = await _getSenderId();
        return FirebaseService.generateChatId(senderId, receiverId);
    }

    clearUnreadMessages(String receiverId) async {
     //   String chatId = FirebaseService.generateChatId(senderId, receiverId);
        await FirebaseService.clearUnreadMessages(receiverId);
    }
}

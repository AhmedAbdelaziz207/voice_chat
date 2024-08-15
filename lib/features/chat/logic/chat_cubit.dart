import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:voice_chat/core/network/model/chat.dart';
import 'package:voice_chat/core/network/model/chat_message.dart';
import 'package:voice_chat/core/network/services/firebase_service.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/features/chat/logic/chat_state.dart';

import '../../../core/services/audio_manager.dart';

class ChatCubit extends Cubit<ChatState> {
    ChatCubit() : super(ChatInitial());
    bool isPlaying = false;
    late AudioPlayer? audioPlayer;

    String senderId = "";
    String receiverId = "";
    String chatId = "";
    bool _isRecording = false;
    String messageId = "";
    List<ChatMessage> messages = [];
    AudioManager audioManager = AudioManager();

    AudioRecorder audioRecorder = AudioRecorder();
    String path = "";

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

    Future<void> startRecord() async {
        try {
            if (await audioRecorder.hasPermission()) {
                var location = await getApplicationDocumentsDirectory();
                messageId = const Uuid().v1();
                path = "${location.path}$messageId.m4a";

                debugPrint("Recording to path: $path");
                await audioRecorder.start(const RecordConfig(), path: path);

                changeRecordingState();

                debugPrint("Recording started successfully");
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
                debugPrint("Recording stopped at path: $recordPath");
                uploadAudio(recordPath);
            } else {
                emit(AudioRecordingFailed(failedMessage: "Failed to stop recording"));
            }
        } catch (e) {
            debugPrint("Failed to stop recording: $e");
            emit(AudioRecordingFailed(failedMessage: e.toString()));
        }
    }

    Future<void> uploadAudio(String filePath) async {
        File file = File(filePath);
        try {
            String downloadUrl = await FirebaseService.uploadFileToFirebase(file);
            emit(AudioUploaded(downloadUrl: downloadUrl));

            // Send message
            String senderId = await _getSenderId();
            chatId = await _getChatId(receiverId);

            await sendMessage(
                ChatMessage(
                    messageContent: downloadUrl,
                    receiverId: receiverId,
                    type: MessageType.voice,
                    senderId: senderId,
                    messageId: messageId,
                    isRead: false,
                    dateTime: DateTime.now(),
                ),
            );
        } catch (e) {
            debugPrint("Failed to upload audio: $e");
            emit(AudioUploadFailed(failedMessage: e.toString()));
        }
    }

    getChatMessages(receiverId) async {
        print(senderId);
        print(receiverId);
        String chatId = await _getChatId(receiverId);
        this.chatId = chatId;

        FirebaseService.listenToMessages(chatId).listen(
            (snapshot) {
                Chat chat = Chat.fromJson(snapshot.data()!);
                messages = chat.chatMessages!;
                print(chat.chatMessages!.length);
                emit(ChatMessagesLoaded(messages: messages));
            },
        );
    }

    Future<void> getOrCreateChat(String receiverId) async {
        try {
            debugPrint("Creating or getting chat for receiverId: $receiverId");
            String chatId = await _getChatId(receiverId);
            this.chatId = chatId;

            Chat chat = Chat(
                chatMessages: [],
                usersId: [senderId, receiverId],
                chatId: chatId,
            );

            await FirebaseService.createOrGetChat(
                senderId, receiverId, chat.toJson());
        } catch (e) {
            debugPrint("Failed to get or create chat: $e");
        }
    }

    Future<void> sendMessage(ChatMessage message) async {
        try {
            String chatId = await _getChatId(receiverId);
            await FirebaseService.sendMessage(chatId, message);
            debugPrint("Message sent successfully");
        } catch (e) {
            debugPrint("Failed to send message: $e");
        }
    }

    void changeRecordingState() {
        _isRecording = !_isRecording;
        emit(ChatRecording(isRecording: _isRecording));
    }

    playAudio( message) async {
        await audioManager.playAudio(message );
        isPlaying = true ;
        emit(AudioStartPlaying(isPlaying: audioManager.isPlaying));
    }


    stopAudio() async {
        await audioManager.stopAudio();
        isPlaying = false ;

        emit(AudioStopPlaying(isPlaying: audioManager.isPlaying));
    }


}

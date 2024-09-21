
import 'dart:collection';

import 'package:voice_chat/core/network/model/chat.dart';

import '../../../core/network/model/chat_message.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {
    final Chat chat;

    ChatSuccess({required this.chat});
}

final class ChatCreatedSuccess extends ChatState {}

final class ChatFailed extends ChatState {
    final String failedMessage;

    ChatFailed({required this.failedMessage});
}

final class ChatLoading extends ChatState {}

final class ChatRecording extends ChatState {
    final bool isRecording;
    ChatRecording({required this.isRecording});
}

final class ChatMessagesLoaded extends ChatState {
    List<ChatMessage> messages = [];

    ChatMessagesLoaded({required this.messages});
}

final class AudioRecordingStart extends ChatState {}

final class AudioRecordingFailed extends ChatState {
    String failedMessage;
    AudioRecordingFailed({required this.failedMessage});
}

final class AudioRecordingStopped extends ChatState {
    String recordPath ;
    AudioRecordingStopped({required this.recordPath});
}

final class AudioUploaded extends ChatState {
    String downloadUrl ;
    AudioUploaded({required this.downloadUrl});
}

final class AudioUploadFailed extends ChatState {
    String failedMessage ;
    AudioUploadFailed({required this.failedMessage});
}
final class AudioStartPlaying extends ChatState{
    Map<String,bool> isPlaying ;
    AudioStartPlaying({required this.isPlaying});
}
final class AudioStopPlaying extends ChatState{
    Map<String,bool> isPlaying ;
    AudioStopPlaying({required this.isPlaying});
}
final class PositionUpdated extends ChatState{
    Map<String, Duration>  positionMap ;
    PositionUpdated({required this.positionMap});
}

final class MessageDurationLoaded extends ChatState {
   final  Duration? duration  ;
    MessageDurationLoaded({required this.duration});
}
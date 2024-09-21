import '../../../core/network/model/chat.dart';

sealed class HomeChatState {}

final class HomeChatsLoaded extends HomeChatState {
  final List<Chat>? chats;

  HomeChatsLoaded({this.chats});
}

final class HomeChatsLoading extends HomeChatState {}

final class HomeChatsFailed extends HomeChatState {
  final String failedMessage;

  HomeChatsFailed({required this.failedMessage});
}

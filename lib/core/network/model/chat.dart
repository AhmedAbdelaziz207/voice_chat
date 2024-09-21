import 'package:voice_chat/core/network/model/chat_message.dart';

class Chat {
    String? chatId;
    String? fromUserId;
    String? toUserId;
    String? fromUserName;
    String? toUserName;
    int? fromUserMessagesNum;
    int? toUserMessagesNum;
    int? totalMessages;
    List<String>? usersId;
    ChatMessage? lastMessage;
    List<ChatMessage>? chatMessages;

    Chat({
        this.chatId,
        this.usersId,
        this.lastMessage,
        this.chatMessages,
        this.fromUserId,
        this.toUserId,
        this.fromUserName,
        this.toUserName,
        this.fromUserMessagesNum = 0,
        this.toUserMessagesNum = 0,
        this.totalMessages = 0,
    });

    Chat.fromJson(Map<String, dynamic> json) {
        chatId = json['chat_id'] as String?;
        fromUserId = json['from_user_id'] as String?;
        toUserId = json['to_user_id'] as String?;
        fromUserName = json['from_user_name'] as String?;
        toUserName = json['to_user_name'] as String?;
        fromUserMessagesNum = json['from_user_messages_num'] as int? ?? 0;
        toUserMessagesNum = json['to_user_messages_num'] as int? ?? 0;
        totalMessages = json['total_messages'] as int? ?? 0;
        usersId = (json['users_id'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList();
        lastMessage = json['last_message'] != null
            ? ChatMessage.fromJson(json['last_message'] as Map<String, dynamic>)
            : null;
        chatMessages = (json['chat_messages'] as List<dynamic>?)
            ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
            .toList();
    }

    Map<String, dynamic> toJson() {
        return {
            'chat_id': chatId,
            'users_id': usersId,
            'last_message': lastMessage?.toJson(),
            'total_messages': totalMessages,
            'from_user_id': fromUserId,
            'to_user_id': toUserId,
            'from_user_name': fromUserName,
            'to_user_name': toUserName,
            'from_user_messages_num': fromUserMessagesNum,
            'to_user_messages_num': toUserMessagesNum,
            'chat_messages': chatMessages?.map((e) => e.toJson()).toList(),
        };
    }
}

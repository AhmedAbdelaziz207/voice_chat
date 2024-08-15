import 'package:voice_chat/core/network/model/chat_message.dart';

class Chat {
    String? chatId;
    List<String>? usersId;
    ChatMessage? lastMessage;
    List<ChatMessage>? chatMessages;

    Chat({
        this.chatId,
        this.usersId,
        this.lastMessage,
        this.chatMessages,
    });


    Chat.fromJson(Map<String, dynamic> json) {
        chatId = json['chat_id'];
        usersId = List<String>.from(json['users_id'] ?? []);
        lastMessage = json['last_message'] != null
            ? ChatMessage.fromJson(json['last_message'])
            : null;
        chatMessages = (json['chat_messages'] as List<dynamic>?)
            ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
            .toList();
    }

    toJson(){
        return {
          'chat_id': chatId,
          'users_id': usersId,
          'last_message': lastMessage?.toJson(),
          'chat_messages':  chatMessages?.map((e) => e.toJson()).toList() ,
        };
    }
}

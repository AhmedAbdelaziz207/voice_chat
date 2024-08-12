class ChatMessage {
    late final String? messageContent;
    late final String? chatId;
    late final String? senderId;
    late final String? receiverId;
    late final bool? isRead;
    late final DateTime? dateTime;

    ChatMessage({
        this.chatId,
        this.senderId,
        this.messageContent,
        this.isRead,
        this.receiverId,
        this.dateTime,
    });

    ChatMessage.fromJson(Map<String, dynamic> json) {
        messageContent = json['message_content'];
        chatId = json['chat_id'];
        senderId = json['sender_id'];
        receiverId = json['receiver_id'];
        isRead = json['is_read'];
        dateTime = json['date_time'];
    }

    Map<String, dynamic> toJson() {
        return {
            'message_content': messageContent,
            'chat_id': chatId,
            'sender_id': senderId,
            'receiver_id': receiverId,
            'is_read': isRead,
            'date_time': dateTime,
        };
    }
}

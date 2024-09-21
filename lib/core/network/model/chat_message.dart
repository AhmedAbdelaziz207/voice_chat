
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
    late final String? messageContent;
    late final String? messageId;
    late final String? senderId;
    late final String? receiverId;
    late final bool? isPlayed;
    late final DateTime? dateTime;
    late final MessageType? type ;
   late  double? messageDuration;

    ChatMessage({
        this.messageId,
        this.senderId,
        this.messageContent,
        this.isPlayed = false,
        this.receiverId,
        this.dateTime,
        this.type,
        this.messageDuration  ,

    });

    ChatMessage.fromJson(Map<String, dynamic> json) {
        messageContent = json['message_content'];
        messageId = json['message_id'];
        senderId = json['sender_id'];
        receiverId = json['receiver_id'];
        isPlayed = json['is_played'];
        messageDuration = json["message_duration"];
        dateTime = (json['date_time'] as Timestamp).toDate() ;
        type = MessageType.values.firstWhere(
                (e) => e.toString().split('.').last == json['type'],
        );

    }

    Map<String, dynamic> toJson() {
        return {
            'message_content': messageContent,
            'message_id': messageId,
            'sender_id': senderId,
            'message_duration': messageDuration,
            'receiver_id': receiverId,
            'is_played': isPlayed,
            'date_time': dateTime,
            "type" : type
                .toString()
                .split('.')
                .last,
        };
    }
}
enum MessageType {
    text,
    voice,
    image,
    video,
    file,
}
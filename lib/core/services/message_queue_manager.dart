import 'package:voice_chat/core/network/services/firebase_service.dart';

import '../network/model/chat_message.dart';
import 'audio_manager.dart';

class MessageQueueManager {
    List<ChatMessage> messageQueue = [];
    late AudioManager audioManager;
    String? lastProcessedMessageId;

    MessageQueueManager() {
        audioManager = AudioManager();
    }

    bool isInitialLoad = true;

    void processMessageQueue(chatId) async {
        if (messageQueue.isEmpty) return;

        while (messageQueue.isNotEmpty) {
            ChatMessage message = messageQueue.removeAt(0);
            await audioManager.playAudio(message);
            await FirebaseService.updateMessageFiled(
                chatId: chatId,
                messageId: message.messageId!,
                fieldName: "is_played",
                newValue: true,
            );
        }
    }

    bool isNewMessage(ChatMessage message) {
        if (isInitialLoad) return false; // Skip processing during initial load
        return lastProcessedMessageId == null ||
            message.messageId != lastProcessedMessageId;
    }
}

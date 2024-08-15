import 'package:voice_chat/core/services/audio_manager.dart';

import '../network/model/chat_message.dart';

class MessageQueueManager {
    List<ChatMessage> messageQueue = [];
    AudioManager audioManager = AudioManager();

    void processMessageQueue() async {
        if (messageQueue.isNotEmpty) {
            ChatMessage message = messageQueue.removeAt(0);
            await audioManager.playAudio(message);
            if (messageQueue.isNotEmpty) {
                processMessageQueue();
            }
        }
    }
}

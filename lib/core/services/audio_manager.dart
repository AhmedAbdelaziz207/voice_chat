import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:voice_chat/core/network/model/chat_message.dart';

class AudioManager {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  AudioManager() {
    audioPlayer = AudioPlayer();
  }

  Future<void> playAudio(ChatMessage message) async {
    try {
      // Stop any currently playing audio
      if (audioPlayer.playing) {
        await audioPlayer.stop();
      }

      // Set the new audio source
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(message.messageContent!),
          tag: MediaItem(
            id: message.messageId!,
            title: "Voice Chat",
            artist: message.senderId,
          ),
        ),
      );

      // Start playing the audio
      await audioPlayer.play();
      isPlaying = true;
      debugPrint('Audio is playing: $isPlaying');
    } catch (e) {
      debugPrint("Failed to play audio: $e");
    }
  }

  Future<void> stopAudio() async {
    try {
      if (audioPlayer.playing) {
        await audioPlayer.stop();
        isPlaying = false;
        debugPrint('Audio stopped.');
      } else {
        debugPrint("No audio is currently playing.");
      }
    } catch (e) {
      debugPrint("Failed to stop audio: $e");
    }
  }

  void dispose() {
    audioPlayer.dispose();
  }
}

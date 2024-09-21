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

    getMessageDuration(ChatMessage message) async {
        try {
            print("Get message duration ");
            // Set the audio source and load the audio
            await audioPlayer.setUrl(
                message.messageContent!
            );

            // Wait until the duration is known
            await audioPlayer.load();
            Duration? duration = await audioPlayer.durationStream.firstWhere((d) => d != null);
            debugPrint("Duration is $duration");
            return duration;
        } catch (e) {
            debugPrint("Cannot get audio duration $e");
            return null; // Ensure that null is returned if something goes wrong
        }
    }

    Stream<Duration> getMessagePosition() {
        return audioPlayer.positionStream;
    }

    Future<void> playAudio(ChatMessage message) async {
        try {
            if (audioPlayer.playing) {
                await audioPlayer.stop();
            }
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

    // static Future<Duration?> getAudioDuration(String url) async {
    //     try {
    //         final AudioPlayer audioPlayer = AudioPlayer();
    //         final duration = await audioPlayer.setUrl(url);
    //         await audioPlayer.dispose(); // Dispose of the player after getting the duration
    //         return duration;
    //     } catch (e) {
    //         print("Error getting audio duration: $e");
    //         return null;
    //     }
    // }
    //
}

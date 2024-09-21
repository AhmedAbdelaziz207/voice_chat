import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/features/chat/ui/widgets/voice_message_widget.dart';

class ReceivedVoiceMessageWidget extends StatelessWidget {
  final PlayerController playerController = PlayerController();

  ReceivedVoiceMessageWidget({
    super.key,
    required this.audioSource,
    required this.id,
  });

  final AudioSource audioSource;

  final String id;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Container(
          width: 300.w,
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColorDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              bottomLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
              bottomRight: Radius.circular(2.r),
            ),
          ),
          child: AudioPlayerMessage(
            source: audioSource,
            id: id,
          ),
        ),
      ),
    );
  }
}

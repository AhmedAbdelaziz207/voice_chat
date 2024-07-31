import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/utils/constants/assets_keys.dart';

class SentVoiceMessageWidget extends StatelessWidget {
  final PlayerController playerController = PlayerController();

  SentVoiceMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          bottomLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
          bottomRight: Radius.circular(2.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AudioFileWaveforms(
                        size: Size(180.w, 20.h),
                        playerController: playerController,
                        playerWaveStyle: const PlayerWaveStyle(
                          fixedWaveColor: Colors.grey,
                          liveWaveColor: Colors.purple,
                          waveThickness: 2.0,
                          scaleFactor: 50.0,
                          showBottom: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                      child: IconButton(
                        icon: Icon(
                          playerController.playerState == PlayerState.playing
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: AppColors.grey,
                        ),
                        onPressed: () {
                          if (playerController.playerState ==
                              PlayerState.playing) {
                            playerController.pausePlayer();
                          } else {
                            playerController.startPlayer();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "2:48 PM",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0.sp,
                      ),
                    ),
                    Text(
                      "0:02",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0.sp,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          const CircleAvatar(
            backgroundImage: AssetImage(AssetsKeys.contactImage),
            radius: 20.0,
          ),
        ],
      ),
    );
  }
}

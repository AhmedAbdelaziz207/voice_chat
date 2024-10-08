import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard(
      {super.key, required this.userContact, this.onTap, this.showMic});

  final UserModel userContact;

  final Function()? onTap;

  final bool? showMic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80.w,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userContact.profileImageUrl!),
                radius: 25.0,
              ),
              if (showMic == true)
                const Positioned(
                  bottom: -3,
                  right: -4,
                  child: Icon(
                    Icons.mic,
                    color: AppColors.white200,
                    size: 24.0,
                  ),
                ),
            ]),
            const SizedBox(height: 8.0),
            Expanded(
              child: Text(
                userContact.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.contactLabelStyle.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

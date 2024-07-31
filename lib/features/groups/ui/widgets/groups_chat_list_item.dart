import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/assets_keys.dart';

class GroupsChatListItem extends StatelessWidget {
  const GroupsChatListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundImage: const AssetImage(AssetsKeys.contactImage),
        radius: 25.0.r,
      ),
      title: Text(
        "Android Developer",
        style: AppTextStyles.contactLabelStyle
            .copyWith(color: AppColors.white),
      ),
      subtitle: const Row(
        children: [
          Icon(
            Icons.check,
            color: AppColors.lightGrey,
          ),
          Icon(
            Icons.mic,
            color: AppColors.lightGrey,
          ),
          Text(
            "0.03",
            style: TextStyle(color: AppColors.lightGrey),
          )
        ],
      ),
      trailing: const Text(
        '12.00 am',
        style: TextStyle(color: AppColors.lightGrey),
      ),
    );
  }
}

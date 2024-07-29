import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/constants/app_keys.dart';

class HomeGroupsTitle extends StatelessWidget {
  const HomeGroupsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppKeys.contacts , style: AppTextStyles.homeTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 22.sp
        ),),
        Icon(Icons.groups_rounded,color: AppColors.primaryColor,size: 30.sp )
      ],
    );
  }
}

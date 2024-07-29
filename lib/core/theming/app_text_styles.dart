import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';

class AppTextStyles {
  static TextStyle loginScreenTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );

  static const TextStyle otpPhoneNumber = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.lightDark,
  );

  static  TextStyle otpInstruction = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.lightDark,
  );

  static final TextStyle otpInput = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.lightDark,
  );
  static final TextStyle otpAppbar = TextStyle(
    fontSize: 21.sp,
    color: AppColors.white,
  );

  static final TextStyle otpButton = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static final TextStyle homeTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w900,
    color: AppColors.primaryColor,
  );

  static final TextStyle contactLabelStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
}

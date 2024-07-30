import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';

class OTPFormWidget extends StatelessWidget {
  const OTPFormWidget(
      {super.key,
      this.onCompleted,
      this.onSubmitted,
      this.validator, this.onChanged});

  final Function(String)? onCompleted;

  final Function(String)? onSubmitted;

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    PinTheme pinTheme = PinTheme(
        height: 70.h,
        width: 60.w,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.white200,
            border: Border.all(color: AppColors.primaryColor)),
        textStyle: AppTextStyles.otpInput);


    return Pinput(
      length: 5,
      submittedPinTheme: pinTheme,
      focusedPinTheme: pinTheme,
      defaultPinTheme: PinTheme(
          height: 70.h,
          width: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.white200,
          ),
          textStyle: AppTextStyles.otpInput),
      validator: validator,
      onSubmitted: onSubmitted,
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}

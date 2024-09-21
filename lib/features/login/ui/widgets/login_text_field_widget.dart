import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/features/login/logic/login_cubit.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/constants/app_keys.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({super.key, this.controller, this.hintText, this.keyboardInput});
 final TextEditingController? controller ;
 final String? hintText ;
 final TextInputType? keyboardInput ;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardInput,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 4.w),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none ,
        ),
        hintText: hintText,
        hintStyle: AppTextStyles.loginScreenTextStyle.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

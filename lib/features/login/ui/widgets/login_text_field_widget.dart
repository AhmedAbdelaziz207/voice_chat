import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/features/login/logic/login_cubit.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/constants/app_keys.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: context.read<LoginCubit>().loginController,
      keyboardType:TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 4.h),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none ,
        ),
        hintText: AppKeys.enterYourPhoneNumber,
        hintStyle: AppTextStyles.loginScreenTextStyle.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

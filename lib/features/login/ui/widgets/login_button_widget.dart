import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/features/login/logic/login_cubit.dart';
import 'package:voice_chat/features/login/logic/login_state.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/constants/app_keys.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(4.r)),
        minWidth: 216.w,
        color: AppColors.primaryColor,
        onPressed: () {
          context.read<LoginCubit>().login();
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return SizedBox(
                height: 20.h,
                width: 20.w,
                child: const CircularProgressIndicator(color: AppColors.white,),
              );
            }
            return Text(
              AppKeys.login,
              style: AppTextStyles.loginScreenTextStyle
                  .copyWith(color: AppColors.white),
            );
          },
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/core/utils/constants/assets_keys.dart';
import 'package:voice_chat/core/utils/extensions/alert_dialog.dart';
import 'package:voice_chat/core/widgets/app_background.dart';
import 'package:voice_chat/features/login/logic/login_cubit.dart';
import 'package:voice_chat/features/login/logic/login_state.dart';
import 'package:voice_chat/features/login/ui/widgets/login_button_widget.dart';
import 'package:voice_chat/features/login/ui/widgets/login_countries_dropdown_widget.dart';
import 'package:voice_chat/features/login/ui/widgets/login_screen_form.dart';
import 'package:voice_chat/features/login/ui/widgets/login_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            handleLoginStates(context, state);
          },
          child: Column(
            children: [
              SizedBox(
                height: 210.h,
              ),
              Image.asset(AssetsKeys.appLogo),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 40.h),
                child: const LoginScreenForm(),
              ),
              SizedBox(
                height: 70.h,
              ),
              const LoginButtonWidget()
            ],
          ),
        ),
      ),
    );
  }

  void handleLoginStates(BuildContext context, LoginState state) {
    if (state is LoginFailed) {
      context.showAlertDialog(
        title: "Failed Login ",
        contentMessage: state.failedMessage,
      );
    } else if (state is LoginSuccess) {
      Navigator.pushNamed(
        context,
        Routes.otp,
        arguments: {
          "phoneNumber": state.phoneNumber,
          "userName": state.userName
        },
      );
    }
  }
}

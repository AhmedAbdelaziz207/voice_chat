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
import 'package:voice_chat/features/login/ui/widgets/login_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDark: false,
      child: SingleChildScrollView(
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
                padding: EdgeInsets.symmetric(
                    horizontal: 21.0.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppKeys.phoneNumber,
                      style: AppTextStyles.loginScreenTextStyle,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: AppColors.white.withOpacity(.8)),
                      ),
                      child: const Row(
                        children: [
                          LoginCountriesDropdownWidget(),
                          VerticalDivider(
                            color: AppColors.primaryColor,
                            thickness: 1,
                          ),
                          Expanded(
                            child: LoginTextFieldWidget(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
        arguments: state.phoneNumber,
      );
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/core/widgets/app_background.dart';
import 'package:voice_chat/features/login/ui/widgets/login_button_widget.dart';
import 'package:voice_chat/features/login/ui/widgets/login_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _selectedIndex = 0;

  static const List<String> codes = ['+62', '+82', '+1'];

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          SizedBox(
            height: 210.h,
          ),
          Image.asset('assets/images/app_logo.png'),
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
                Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.white.withOpacity(.8)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: DropdownButton(
                            value: _selectedIndex,
                            items: codes
                                .map((e) => DropdownMenuItem(
                                      value: codes.indexOf(e),
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (v) {
                              _selectedIndex = v ?? 0;
                              setState(() {});
                            }),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(2),
                        child: VerticalDivider(
                          color: AppColors.primaryColor,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
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
    );
  }
}

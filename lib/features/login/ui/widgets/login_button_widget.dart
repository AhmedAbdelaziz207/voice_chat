import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/constants/app_keys.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(4.r)
        ),
        minWidth:216.w ,
        color: AppColors.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.otp);
        },
        child: Text(
          AppKeys.login,
          style: AppTextStyles.loginScreenTextStyle
              .copyWith(color: AppColors.white),
        ));
  }
}

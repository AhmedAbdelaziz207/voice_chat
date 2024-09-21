import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/utils/constants/app_keys.dart';
import '../../logic/login_cubit.dart';
import 'login_countries_dropdown_widget.dart';
import 'login_text_field_widget.dart';

class LoginScreenForm extends StatelessWidget {
  const LoginScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppKeys.phoneNumber,
          style: AppTextStyles.loginScreenTextStyle,
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: AppColors.white.withOpacity(.8)),
          ),
          child:  Row(
            children: [
              const LoginCountriesDropdownWidget(),
              const VerticalDivider(
                color: AppColors.white200,
                thickness: .6,
              ),
              Expanded(
                child: LoginTextFieldWidget(
                  keyboardInput: TextInputType.number,
                  hintText: AppKeys.enterYourPhoneNumber,
                  controller: context.read<LoginCubit>().phoneNumberController,
                ),
              ),
            ],
          ),
        ),
         SizedBox(
          height: 30.h,
        ),
        Text(
          AppKeys.userName,
          style: AppTextStyles.loginScreenTextStyle,
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: AppColors.white.withOpacity(.8)),
          ),
          child:  Row(
            children: [
              Expanded(
                child: LoginTextFieldWidget(
                  keyboardInput: TextInputType.name,
                  hintText: AppKeys.enterYourUserName,
                  controller: context
                      .read<LoginCubit>()
                      .userNameController,
                ),
              ),
            ],
          ),
        )


      ],
    );
  }
}

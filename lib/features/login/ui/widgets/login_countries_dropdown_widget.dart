import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/features/login/logic/login_cubit.dart';

import '../../../../core/utils/constants/app_keys.dart';

class LoginCountriesDropdownWidget extends StatefulWidget {
  const LoginCountriesDropdownWidget({super.key});

  static const List<String> codes = ['+20', '+44', '+82', '+1',"+22"];

  @override
  State<LoginCountriesDropdownWidget> createState() =>
      _LoginCountriesDropdownWidgetState();
}

class _LoginCountriesDropdownWidgetState
    extends State<LoginCountriesDropdownWidget> {

  @override
  Widget build(BuildContext context) {
    int? selectedIndex = context.read<LoginCubit>().selectedCountryCodeIndex ;


    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: DropdownButton(
          dropdownColor: AppColors.primaryColor,
          value: selectedIndex,
          iconSize: 20.r,
          items: AppKeys.countryCodes
              .map((code) => DropdownMenuItem(
                    value: LoginCountriesDropdownWidget.codes
                        .indexOf(code),
                    child: Text(
                      code,
                      style: const TextStyle(
                        color: AppColors.white200,
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (countryCode) {
            context.read<LoginCubit>().selectedCountryCodeIndex = ((countryCode ?? 0) as int?)!;
            setState(() {});
          }),
    );
  }
}

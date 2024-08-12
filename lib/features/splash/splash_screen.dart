import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/core/utils/preferences/preference_manager.dart';
import 'package:voice_chat/core/widgets/app_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token =  preferences.getString(AppKeys.token);
      if (token == null || token.isEmpty) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.login, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        isDark: false,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 250.h,
              ),
              Image.asset(
                'assets/images/app_logo.png',
              ),
              Image.asset(
                'assets/images/voice_chat.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

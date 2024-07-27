import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voice_chat/core/router/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushNamed(context, Routes.login);
    }) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash_background.png',
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
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

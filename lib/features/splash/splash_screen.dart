import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/core/router/routes.dart';
import '../../core/theming/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      SessionProvider sessionProvider = SessionProvider();
      await sessionProvider.loadSession();

      var token = sessionProvider.session?.token;
      if (token == null || token.isEmpty) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.login, (route) => false);
      } else {
        String? name = sessionProvider.session?.userName;
        String? userId = sessionProvider.session?.userId;

        // Debug statements
        debugPrint("Name: $name, UserId: $userId");

        // Assign the static user field
        SessionProvider.user = UserModel(name: name, userId: userId);

        // Debug print after assignment
        debugPrint(
            "Assigned User: ${SessionProvider.user.name}, ${SessionProvider.user
                .userId}");

        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      }

// Debug print on the home screen
      debugPrint("Home Screen UserId: ${SessionProvider.user.userId}");
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
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
    );
  }
}

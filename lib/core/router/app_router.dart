import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/features/chat/ui/chat_screen.dart';
import 'package:voice_chat/features/groups/ui/groups_screen.dart';
import 'package:voice_chat/features/home/ui/home_screen.dart';
import 'package:voice_chat/features/login/ui/login_screen.dart';
import 'package:voice_chat/features/splash/splash_screen.dart';

import '../../features/otp/ui/otp_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      case Routes.otp:
        return MaterialPageRoute(
          builder: (context) {
            return const OTPScreen();
          },
        );
      case Routes.chat:
        return MaterialPageRoute(
          builder: (context) {
            return const ChatScreen();
          },
        );
      case Routes.groups:
        return MaterialPageRoute(
          builder: (context) {
            return const GroupsScreen();
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Page Not Found ",
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
            );
          },
        );
    }
  }
}

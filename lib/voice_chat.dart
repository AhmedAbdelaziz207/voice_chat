import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/router/app_router.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/features/notifications/notifications_screen.dart';
import 'features/splash/splash_screen.dart';

class VoiceChat extends StatelessWidget {
  const VoiceChat({super.key, required this.appRouter});
  final AppRouter appRouter ;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          onGenerateRoute: appRouter.onGenerateRoute ,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
        );
      },
      child: const SplashScreen(),
    );
  }
}

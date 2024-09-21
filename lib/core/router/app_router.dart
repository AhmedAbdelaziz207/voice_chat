import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/features/chat/logic/chat_cubit.dart';
import 'package:voice_chat/features/chat/ui/chat_screen.dart';
import 'package:voice_chat/features/groups/ui/groups_screen.dart';
import 'package:voice_chat/features/home/logic/home_chat_cubit.dart';
import 'package:voice_chat/features/home/logic/home_users_cubit.dart';
import 'package:voice_chat/features/home/ui/home_screen.dart';
import 'package:voice_chat/features/login/ui/login_screen.dart';
import 'package:voice_chat/features/notifications/notifications_screen.dart';
import 'package:voice_chat/features/otp/logic/otp_cubit.dart';
import 'package:voice_chat/features/profile/ui/user_profile_screen.dart';
import 'package:voice_chat/features/splash/splash_screen.dart';
import '../../features/login/logic/login_cubit.dart';
import '../../features/otp/ui/otp_screen.dart';
import '../network/model/chat.dart';
import '../network/services/session_provider.dart';

class AppRouter {
  // String? currentUserId;
  //
  // getCurrentUser() async {
  //   SessionProvider sessionProvider = SessionProvider();
  //   await sessionProvider.loadSession().then((value) {
  //     currentUserId = sessionProvider.session!.userId;
  //   });
  // }

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case Routes.home:
       // getCurrentUser();
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HomeChatCubit(),
                ),
                BlocProvider(
                  create: (context) => HomeUsersCubit(),
                ),
              ],
              child: const HomeScreen(),
            );
          },
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoginCubit>(
              create: (BuildContext context) {
                return LoginCubit();
              },
              child: const LoginScreen(),
            );
          },
        );
      case Routes.otp:
        return MaterialPageRoute(
          builder: (context) {
            var arguments = routeSettings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => OtpCubit(),
              child: OTPScreen(
                phoneNumber: arguments['phoneNumber'],
                userName: arguments['userName'],
              ),
            );
          },
        );
      case Routes.chat:
        UserModel receiverUser = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<ChatCubit>(
              create: (BuildContext context) {
                return ChatCubit();
              },
              child: ChatScreen(
                userContact: receiverUser,
              ),
            );
          },
        );
      case Routes.groups:
        return MaterialPageRoute(
          builder: (context) {
            return const GroupsScreen();
          },
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (context) {
            return const UserProfileScreen();
          },
        );
      case Routes.notificationsScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const NotificationsScreen();
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

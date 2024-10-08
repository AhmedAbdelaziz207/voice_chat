import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:voice_chat/core/network/services/firebase_service.dart';
import 'package:voice_chat/core/router/app_router.dart';
import 'package:voice_chat/features/notifications/notifications_service.dart';
import 'package:voice_chat/voice_chat.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
 // FirebaseService firebaseService = FirebaseService();
  AppRouter appRouter = AppRouter();

  runApp(
    VoiceChat(
      appRouter: appRouter,
    ),
  );
}

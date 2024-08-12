 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voice_chat/core/router/app_router.dart';
import 'package:voice_chat/voice_chat.dart';

import 'firebase_options.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppRouter appRouter = AppRouter();

  runApp(
    VoiceChat(
      appRouter: appRouter,
    ),
  );
}

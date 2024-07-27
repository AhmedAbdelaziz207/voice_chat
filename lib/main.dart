import 'package:flutter/material.dart';
import 'package:voice_chat/core/router/app_router.dart';
import 'package:voice_chat/voice_chat.dart';

void main() {
  AppRouter appRouter = AppRouter();
  runApp(
    VoiceChat(
      appRouter: appRouter,
    ),
  );
}

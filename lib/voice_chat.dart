import 'package:flutter/material.dart';

import 'features/splash/splash_screen.dart';

class VoiceChat extends StatelessWidget {
  const VoiceChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

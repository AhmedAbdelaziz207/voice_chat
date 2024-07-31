import 'package:flutter/material.dart';
import 'package:voice_chat/core/utils/constants/assets_keys.dart';

class AppBackground extends StatelessWidget {
  final Widget? child;

  const AppBackground({super.key, this.child, this.isDark});

  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark!
                  ? AssetsKeys.appDarkBackground
                  : AssetsKeys.appLightBackground,
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}

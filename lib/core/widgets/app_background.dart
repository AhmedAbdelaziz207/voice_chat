import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget? child;

  const AppBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash_background.png',
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: child ,
      ),
    );
  }
}

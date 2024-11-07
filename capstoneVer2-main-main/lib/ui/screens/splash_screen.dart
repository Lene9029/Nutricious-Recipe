import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:recipe_page_new/welcomepage/welcome_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const CircleAvatar(
        radius: 500,
        backgroundColor: Colors.blue,
        child: CircleAvatar(
          backgroundImage: AssetImage('images/logo.png'),
          radius: 50,
        ),
      ),
      nextScreen: WelcomePage(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.lightGreen,
    );
  }
}

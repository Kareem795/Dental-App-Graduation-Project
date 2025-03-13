import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Onboarding_Screen1.dart';

class Splash extends StatefulWidget {
  static const String route_name = "Splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, OnboardingScreen1.route_name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
          children: [  
            Image.asset("assets/bg.png"),
            Center(child: Image.asset("assets/Logo.png")),
      ]),
    );
  }
}

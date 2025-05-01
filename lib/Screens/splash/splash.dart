import 'package:dental_app_graduation_project/Screens/Onboarding/OnboardingScreen.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/Background/BackgroundWrapper.dart';
import 'package:flutter/material.dart';

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
      Navigator.pushReplacementNamed(context, OnboardingScreen.route_name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Center(child: Image.asset(AppAssets.Logo)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;

  const BackgroundWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // ✅ هنا بناخد ال theme

    return Container(
      color: theme.scaffoldBackgroundColor, // ✅ استخدم لون الخلفية من الـ theme
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.Background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

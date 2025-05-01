import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:flutter/material.dart';

class GradientScaffoldWrapper extends StatelessWidget {
  final Widget child;

  const GradientScaffoldWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: [
        // خلفية تتأثر بالـ Theme
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.background.withOpacity(0.05), // أو اللون الثانوي الفاتح
                colorScheme.background,
                AppColors.primary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // محتوى الشاشة
        child,
      ],
    );
  }
}

// lib/utils/Widgets/OnboardingTemplate.dart
import 'package:dental_app_graduation_project/Screens/Auth/Sign%20up/Sign_up_Screen_Patient.dart';
import 'package:flutter/material.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_style.dart';

class OnboardingTemplate extends StatefulWidget {
  final List<Map<String, String>> pages;

  const OnboardingTemplate({
    super.key,
    required this.pages,
  });

  @override
  State<OnboardingTemplate> createState() => _OnboardingTemplateState();
}

class _OnboardingTemplateState extends State<OnboardingTemplate> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, SignUpScreenPatient.route_name);
    }
  }

  void _skip() {
    Navigator.pushNamed(context, SignUpScreenPatient.route_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        // الخلفية الدائرية
        Positioned(
          top: -10,
          left: -80,
          child: Container(
            width: 240,
            height: 240,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),

        Column(children: [
          const SizedBox(height: 150),

          // الـ PageView
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.pages.length,
              onPageChanged: (idx) => setState(() => _currentPage = idx),
              itemBuilder: (context, index) {
                final data = widget.pages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        data['image']!,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      data['title']!,
                      style: AppStyle.googleStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        data['desc']!,
                        textAlign: TextAlign.center,
                        style: AppStyle.googleStyle(
                            fontSize: 14, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // الدوائر (Indicators)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.pages.length, (idx) {
              final bool isActive = _currentPage == idx;

              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    idx,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isActive ? 18 : 12,
                    height: isActive ? 18 : 12,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : Colors.grey[400],
                      shape: BoxShape.circle,
                      border: isActive
                          ? Border.all(color: AppColors.primary, width: 3)
                          : null,
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 30),

          // زر Next / Get Started
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                _currentPage == widget.pages.length - 1
                    ? "Get Started"
                    : "Next",
                style: AppStyle.googleStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // زر Skip
          TextButton(
            onPressed: _skip,
            child: Text(
              "Skip",
              style:
                  AppStyle.googleStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),

          const SizedBox(height: 30),
        ]),
      ]),
    );
  }
}

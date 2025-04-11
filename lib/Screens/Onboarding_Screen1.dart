import 'package:dental_app_graduation_project/Screens/Onboarding_Screen2.dart';
import 'package:dental_app_graduation_project/Screens/Sign_up_Screen_Patient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class OnboardingScreen1 extends StatelessWidget {
  static const String route_name = "Onboarding Screen 1";
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(14, 189, 126, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/OnboardingScreen1_imge.png', // استبدلي بالصورة الصحيحة
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Find Trusted Doctors",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, OnboardingScreen2.route_name);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(14, 189, 126, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.route_name);
                },
                child: Text(
                  "Skip",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

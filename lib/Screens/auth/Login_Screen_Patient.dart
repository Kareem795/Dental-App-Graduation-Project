import 'package:dental_app_graduation_project/Screens/auth/Sign_up_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/patient/Home_Patient_Screen.dart';
import 'package:dental_app_graduation_project/utils/app_colors.dart';
import 'package:dental_app_graduation_project/utils/app_style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String route_name = "Login Screen";

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Text(
                "Welcome back",
                style: AppStyle.googleStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),

                // GoogleFonts.poppins(
                //   fontSize: 22,
                //   fontWeight: FontWeight.bold,
                //   color: Colors.black87,
                // ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "You can search a course, apply course and find\nscholarship for abroad studies",
                textAlign: TextAlign.center,
                style: AppStyle.googleStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/google.jpeg',
                        width: 20,
                        height: 20,
                      ),
                      label: const Text("Google"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/facebook.png',
                        width: 20,
                        height: 20,
                      ),
                      label: const Text("Facebook"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildTextField(label: "Email"),
              const SizedBox(height: 15),
              _buildTextField(label: "Password", isPassword: true),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomePatientScreen.route_name);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  "Login",
                  style: AppStyle.googleStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),

                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  ForgetPasswordDialog.showForgetPasswordDialog(context);
                },
                child: Text(
                  "Forgot password",
                  style: AppStyle.googleStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),

                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.route_name);
                },
                child: Text(
                  "Don't have an account? Join us",
                  style: AppStyle.googleStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword ? !_isPasswordVisible : false,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }
}

class ForgetPasswordDialog {
  static void showForgetPasswordDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Forgot Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  )),
              const SizedBox(height: 15),
              const Text(
                "Enter your email for verification. We will send a 4-digit code to your email.",
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, HomePatientScreen.route_name);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  "Continue",
                  style: AppStyle.googleStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),

                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}

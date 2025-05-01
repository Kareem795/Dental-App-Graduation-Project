import 'package:dental_app_graduation_project/Screens/Auth/Sign%20up/Sign_up_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/Auth/login/Login_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_constants.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/Background/BackgroundWrapper.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:dental_app_graduation_project/Screens/patient/Home_Patient_Screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ✅ SignUpScreenPatient Widget
class SignUpScreenPatient extends StatefulWidget {
  static const String route_name = "Sign Up Screen";
  const SignUpScreenPatient({super.key});

  @override
  _SignUpScreenPatientState createState() => _SignUpScreenPatientState();
}

class _SignUpScreenPatientState extends State<SignUpScreenPatient> {
  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  Future<void> _signUp() async {
    final url = Uri.parse('${AppConstants.URL}/api/authen/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // خزن الـ ID في SharedPreferences
        await saveUserId(data['user']['id']);

        // مثلاً تروحي بعدها للهوم أو تظهر رسالة نجاح
        Navigator.pushReplacementNamed(context, HomePatientScreen.route_name);
      } else {
        final body = jsonDecode(response.body);
        final errorMessage = body['message'] ?? 'فشل في عملية التسجيل.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $errorMessage')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ غير متوقع.')),
      );
      print('Sign up error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme; //! Very very Important

    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Text(
                  "Join us to start searching",
                  style: textTheme.headlineLarge?.copyWith(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                    "You can search a course, apply course and find\nscholarship for abroad studies",
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall
                        ?.copyWith(color: Colors.grey[600], fontSize: 14)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          AppAssets.Google,
                          width: 24,
                          height: 24,
                        ),
                        label: const Text(
                          "Google",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(fontSize: 14),
                        ),
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
                          AppAssets.Facebook,
                          width: 24,
                          height: 24,
                        ),
                        label: const Text(
                          "Facebook",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(fontSize: 14),
                        ),
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

                /// Name Field
                CustomTextField(
                  label: "Name",
                  controller: _nameController,
                ),
                const SizedBox(height: 30),

                /// Email Field
                CustomTextField(
                  label: "Email",
                  controller: _emailController,
                ),
                const SizedBox(height: 30),

                /// Password Field
                CustomTextField(
                  label: "Password",
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 15),
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeToTerms = value!;
                        });
                      },
                      activeColor: AppColors.primary,
                    ),
                    Text(
                      "I agree with the Terms of Service & \nPrivacy Policy",
                      style: textTheme.headlineSmall?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text("Sign up", style: textTheme.headlineMedium),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreenPatient.route_name);
                  },
                  child: Text("Have an account? Log in",
                      style: textTheme.headlineSmall
                          ?.copyWith(color: AppColors.primary)),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreenDoctor.route_name);
                  },
                  child: Text("I am a Doctor",
                      style: textTheme.headlineSmall
                          ?.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:dental_app_graduation_project/Screens/Auth/Sign%20up/Sign_up_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Home_Doctor_Screen.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_constants.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_style.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/Background/BackgroundWrapper.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenDoctor extends StatefulWidget {
  static const String route_name = "Login Screen Doctor";
  const LoginScreenDoctor({super.key});

  @override
  State<LoginScreenDoctor> createState() => _LoginScreenDoctorState();
}

class _LoginScreenDoctorState extends State<LoginScreenDoctor> {
  bool _isPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> saveDoctorId(int doctorId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('doctor_id', doctorId);
  }

  Future<void> loginDoctor() async {
    final url = Uri.parse("${AppConstants.URL}/api/doctor/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Email": _emailController.text.trim(),
          "Password": _passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final doctorId = responseData['data']['id'];

        await saveDoctorId(doctorId);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
        );

        Navigator.pushNamed(context, HomeDoctorScreen.route_name);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("فشل تسجيل الدخول. تحقق من البيانات")),
        );
      }
    } catch (e) {
      print("Login Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ أثناء الاتصال بالخادم: $e")),
      );
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Welcome back",
                  style: textTheme.headlineLarge?.copyWith(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                    "You can upload X-ray, make medical report, search a course, apply course and find\nscholarship for abroad studies",
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
                CustomTextField(
                  label: "Email",
                  controller: _emailController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Password",
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: _isPasswordVisible ? Colors.green : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: loginDoctor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text("Login", style: textTheme.headlineMedium),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    ForgetPasswordDialog.showForgetPasswordDialog(
                        context, _emailController);
                  },
                  child: Text("Forgot password",
                      style: textTheme.headlineSmall
                          ?.copyWith(color: AppColors.primary)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreenDoctor.route_name);
                  },
                  child: Text("Don't have an account? Join us",
                      style: textTheme.headlineSmall
                          ?.copyWith(color: AppColors.primary)),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, HomeDoctorScreen.route_name);
                    },
                    child: Text(
                      "Kemo Enter",
                      style: AppStyle.googleStyle(
                        fontSize: 24,
                        color: AppColors.primary,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordDialog {
  static void showForgetPasswordDialog(
      BuildContext context, TextEditingController controller) {
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
              CustomTextField(
                label: "Email",
                controller: controller, // استخدم الـ controller هنا
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  // تنفيذ إرسال رمز إعادة التعيين هنا
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

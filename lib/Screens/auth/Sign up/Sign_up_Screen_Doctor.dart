import 'package:dental_app_graduation_project/Screens/Auth/login/Login_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Home_Doctor_Screen.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_constants.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_style.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreenDoctor extends StatefulWidget {
  static const String route_name = "Sign Up Screen Doctor";
  const SignUpScreenDoctor({super.key});

  @override
  State<SignUpScreenDoctor> createState() => _SignUpScreenDoctorState();
}

class _SignUpScreenDoctorState extends State<SignUpScreenDoctor> {
  bool _isPasswordVisible = false;
  bool _isTermsAccepted = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _signUp() async {
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب الموافقة على الشروط أولاً')),
      );
      return;
    }

    final uri = Uri.parse('${AppConstants.URL}/api/doctors/');
    final request = http.MultipartRequest('POST', uri);

    request.fields['name'] = _nameController.text.trim();
    request.fields['Email'] = _emailController.text.trim();
    request.fields['Password'] = _passwordController.text.trim();
    request.fields['Clinic name'] = _clinicNameController.text.trim();
    request.fields['Phone Number'] = _phoneController.text.trim();

    try {
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التسجيل بنجاح!')),
        );
        Navigator.pushReplacementNamed(context, HomeDoctorScreen.route_name);
      } else {
        final responseData = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل التسجيل. رمز الحالة: ${response.statusCode}')),
        );
        print('Response body: $responseData');
      }
    } catch (e) {
      print('Sign up error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ، حاول مرة أخرى')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
          Scaffold(
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
                      style: AppStyle.googleStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You can upload X-ray, make medical report, search a course, apply course and find\nscholarship for abroad studies",
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
                            icon: Image.asset(AppAssets.Google, width: 40, height: 40),
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
                            icon: Image.asset(AppAssets.Facebook, width: 40, height: 40),
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

                    /// Custom TextFields
                    CustomTextField(
                      label: "Name",
                      controller: _nameController,
                    ),
                    const SizedBox(height: 15),

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
                        icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 15),

                    CustomTextField(
                      label: "Clinic name",
                      controller: _clinicNameController,
                    ),
                    const SizedBox(height: 15),

                    CustomTextField(
                      label: "Phone Number",
                      controller: _phoneController,
                    ),
                    const SizedBox(height: 10),

                    /// Terms Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _isTermsAccepted,
                          onChanged: (value) {
                            setState(() {
                              _isTermsAccepted = value!;
                            });
                          },
                          activeColor: AppColors.primary,
                        ),
                        Expanded(
                          child: Text(
                            "I agree with the Terms of Service & Privacy Policy",
                            style: AppStyle.googleStyle(fontSize: 12),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Sign Up Button
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Text(
                        "Sign up",
                        style: AppStyle.googleStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    /// Log in
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreenDoctor.route_name);
                      },
                      child: Text(
                        "Have an account? Log in",
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
          ),
        ],
      ),
    );
  }
}

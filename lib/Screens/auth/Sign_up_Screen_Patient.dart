import 'package:dental_app_graduation_project/Screens/auth/Login_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/auth/Sign_up_Screen_Doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dental_app_graduation_project/Screens/patient/Home_Patient_Screen.dart';
import 'package:dental_app_graduation_project/utils/app_colors.dart';
import 'package:dental_app_graduation_project/utils/app_style.dart';

class SignUpScreen extends StatefulWidget {
  static const String route_name = "Sign Up Screen";
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    try {
      // محاولة تسجيل المستخدم باستخدام Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // إذا تم التسجيل بنجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم التسجيل بنجاح!')),
      );

      if (userCredential.user != null) {
        // التحقق من وجود المستخدم بعد التسجيل بنجاح
        Navigator.pushReplacementNamed(context, HomePatientScreen.route_name);
      }
    } on FirebaseAuthException catch (e) {
      // معالجة الأخطاء التي قد تحدث أثناء التسجيل
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'هذا البريد الإلكتروني مستخدم بالفعل.';
          break;
        case 'invalid-email':
          errorMessage = 'صيغة البريد الإلكتروني غير صحيحة.';
          break;
        case 'weak-password':
          errorMessage = 'كلمة المرور ضعيفة، يجب أن تكون 6 أحرف أو أكثر.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'تم تعطيل إنشاء الحسابات بهذا الأسلوب.';
          break;
        case 'network-request-failed':
          errorMessage = 'تحقق من اتصال الإنترنت وحاول مرة أخرى.';
          break;
        default:
          errorMessage = 'حدث خطأ غير متوقع: ${e.message}';
      }

      // عرض رسالة الخطأ للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      // في حالة حدوث خطأ غير متوقع
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ ما. الرجاء المحاولة لاحقاً.')),
      );
      print("Error during sign-up: $e"); // طباعة الخطأ في الكونسول لمساعدتك في debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  Text(
                    "I agree with the Terms of Service & Privacy Policy",
                    style: AppStyle.googleStyle(fontSize: 12),
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
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.route_name);
                },
                child: Text(
                  "Have an account? Log in",
                  style: AppStyle.googleStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreenDoctor.route_name);
                },
                child: Text(
                  "I am a Doctor",
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
}

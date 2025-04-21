import 'package:dental_app_graduation_project/Screens/Screen_Test.dart';
import 'package:dental_app_graduation_project/Screens/auth/login/Login_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/auth/login/Login_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/auth/signup/Sign_up_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/auth/signup/Sign_up_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Add_Available_Appointments_Screen.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Home_Doctor_Screen.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Medical_Report_Screen.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Xray_Upload_Screen.dart';
import 'package:dental_app_graduation_project/Screens/onboarding/Onboarding_Screen1.dart';
import 'package:dental_app_graduation_project/Screens/onboarding/Onboarding_Screen2.dart';
import 'package:dental_app_graduation_project/Screens/onboarding/Onboarding_Screen3.dart';
import 'package:dental_app_graduation_project/Screens/patient/Show_Doctor_details_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Select_Doctor_Available_Time_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Home_Patient_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Patiant_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/settings/Setting_Screen.dart';
import 'package:dental_app_graduation_project/Screens/splash/Splash.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Home_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Massege_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Search_Tab.dart';
import 'package:dental_app_graduation_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Screens/tabs/Favourite_Tab.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );


  //! Supabase
  await Supabase.initialize(
    url: 'https://lczxandridtaayuhkxpe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxjenhhbmRyaWR0YWF5dWhreHBlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ5OTgzNjEsImV4cCI6MjA2MDU3NDM2MX0.Bb7OfELOFrwUP_4pcM6G7KEYGLJN3aTFTbS57er8bPM',
  );

  // التحقق من حالة تسجيل الدخول في Firebase
  // User? user = FirebaseAuth.instance.currentUser;

  // تحديد الصفحة التي سيتم عرضها بناءً على حالة المستخدم
  // String initialRoute = user != null ? HomePatientScreen.route_name : OnboardingScreen1.route_name;

  // runApp(MyApp(initialRoute: initialRoute));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final String initialRoute;

  // const MyApp({super.key, required this.initialRoute});

  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: initialRoute,  // استخدام المتغير المحدد للصفحة الابتدائية
      initialRoute: Splash.route_name,  // استخدام المتغير المحدد للصفحة الابتدائية
      routes: {
        OnboardingScreen1.route_name: (context) => const OnboardingScreen1(),
        OnboardingScreen2.route_name: (context) => const OnboardingScreen2(),
        OnboardingScreen3.route_name: (context) => const OnboardingScreen3(),
        SignUpScreen.route_name: (context) => const SignUpScreen(),
        LoginScreen.route_name: (context) => const LoginScreen(),
        HomePatientScreen.route_name: (context) => const HomePatientScreen(),
        HaertTab.route_name: (context) => const HaertTab(),
        Splash.route_name: (context) => const Splash(),
        DoctorDetailsScreen.route_name: (context) => const DoctorDetailsScreen(),
        HomeTab.route_name: (context) => const HomeTab(),
        MassegeTab.route_name: (context) => const MassegeTab(),
        SearchTab.route_name: (context) => const SearchTab(),
        SelectTimeScreen.route_name: (context) => const SelectTimeScreen(),
        SettingsScreen.route_name: (context) => const SettingsScreen(),
        ProfileSetupScreen.route_name: (context) => const ProfileSetupScreen(),
        SignUpScreenDoctor.route_name: (context) => const SignUpScreenDoctor(),
        LoginScreenDoctor.route_name: (context) => const LoginScreenDoctor(),
        HomeDoctorScreen.route_name: (context) => const HomeDoctorScreen(),
        MedicalReportScreen.route_name: (context) => const MedicalReportScreen(),
        AddAvailableAppointmentsScreen.route_name: (context) => const AddAvailableAppointmentsScreen(),
        XrayUploadScreen.route_name: (context) => XrayUploadScreen(),
        // ScreenTest.route_name: (context) => const ScreenTest(),
      },
    );
  }
}

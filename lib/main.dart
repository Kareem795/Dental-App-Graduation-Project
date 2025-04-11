import 'package:dental_app_graduation_project/Screens/Doctor_selete_time_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Home_Doctor_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Login_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/Login_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/Medical_Report_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Onboarding_Screen1.dart';
import 'package:dental_app_graduation_project/Screens/Onboarding_Screen2.dart';
import 'package:dental_app_graduation_project/Screens/Onboarding_Screen3.dart';
import 'package:dental_app_graduation_project/Screens/Patiant_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Screen_Test.dart';
import 'package:dental_app_graduation_project/Screens/Setting_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Sign_up_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/Sign_up_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/Home_Patient_Screen.dart';
import 'package:dental_app_graduation_project/Screens/splash/splash.dart';
import 'package:dental_app_graduation_project/Screens/tabs/home_tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/massege_tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/search_tab.dart';
import 'package:flutter/material.dart';
import 'Screens/Doctor_details_Screen.dart';
import 'Screens/tabs/favourite_tab.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: "AIzaSyA4bKWP8vPdqLdirAMwht8w87VfxsZIB-k",
  //     appId: "1:652989689693:android:339245ab21811c021b42b4",
  //     messagingSenderId: "dental-app-graduation-project",
  //     projectId: "dental-app-graduation-project"
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.route_name,
      routes: {
        OnboardingScreen1.route_name:(context)=>const OnboardingScreen1(),
        OnboardingScreen2.route_name:(context)=>const OnboardingScreen2(),
        OnboardingScreen3.route_name:(context)=>const OnboardingScreen3(),
        SignUpScreen.route_name: (context) => const SignUpScreen(),
        LoginScreen.route_name: (context) => const LoginScreen(),
        HomePatientScreen.route_name: (context)=> const HomePatientScreen(),
        HaertTab.route_name:(context)=>const HaertTab(),
        Splash.route_name:(context)=>const Splash(),
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
        // ScreenTest.route_name: (context) => const ScreenTest(),
      },
    );
  }
  }

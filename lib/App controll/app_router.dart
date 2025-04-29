import 'package:flutter/material.dart';
import 'package:dental_app_graduation_project/Screens/Auth/Sign%20up/Sign_up_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/Auth/Sign%20up/Sign_up_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/Doctor/Doctor_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Splash/Splash.dart';
import 'package:dental_app_graduation_project/Screens/Onboarding/OnboardingScreen.dart';
import 'package:dental_app_graduation_project/Screens/Auth/Login/Login_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/Auth/Login/Login_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/patient/Home_Patient_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Doctor/Home_Doctor_Screen.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant Tabs/Favourite_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant Tabs/home_tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant Tabs/Massege_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant Tabs/Search_Tab.dart';
import 'package:dental_app_graduation_project/Screens/patient/Show_Doctor_details_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Select_Doctor_Available_Time_Screen.dart';
import 'package:dental_app_graduation_project/Screens/settings/Setting_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Patiant_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Doctor/Medical_Report_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Doctor/Add_Available_Appointments_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Doctor/Xray_Upload_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Screen_Test.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Splash.route_name:
        return MaterialPageRoute(builder: (_) => const Splash());
      case OnboardingScreen.route_name:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case SignUpScreenPatient.route_name:
        return MaterialPageRoute(builder: (_) => const SignUpScreenPatient());
      case SignUpScreenDoctor.route_name:
        return MaterialPageRoute(builder: (_) => const SignUpScreenDoctor());
      case LoginScreenPatient.route_name:
        return MaterialPageRoute(builder: (_) => const LoginScreenPatient());
      case LoginScreenDoctor.route_name:
        return MaterialPageRoute(builder: (_) => const LoginScreenDoctor());
      case HomePatientScreen.route_name:
        return MaterialPageRoute(builder: (_) => const HomePatientScreen());
      case HomeDoctorScreen.route_name:
        return MaterialPageRoute(builder: (_) => const HomeDoctorScreen());
      case FavouriteTab.route_name:
        return MaterialPageRoute(builder: (_) => const FavouriteTab());
      case HomeTab.route_name:
        return MaterialPageRoute(builder: (_) => const HomeTab());
      case MassegeTab.route_name:
        return MaterialPageRoute(builder: (_) => const MassegeTab());
      case SearchTab.route_name:
        return MaterialPageRoute(builder: (_) => const SearchTab());
      case DoctorDetailsScreen.route_name:
        return MaterialPageRoute(builder: (_) => const DoctorDetailsScreen());
      case SelectTimeScreen.route_name:
        return MaterialPageRoute(
          builder: (_) => const SelectTimeScreen(
            doctorName: "Dr. Unknown",
            clinicName: "Dental Clinic",
            imageUrl: "https://cdn-icons-png.flaticon.com/512/3774/3774299.png",
            doctorId: 1,
          ),
        );
      case SettingsScreen.route_name:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case PatiantProfileScreen.route_name:
        return MaterialPageRoute(builder: (_) => const PatiantProfileScreen());
      case DoctorProfileScreen.route_name:
        return MaterialPageRoute(builder: (_) => const DoctorProfileScreen());
      case MedicalReportScreen.route_name:
        return MaterialPageRoute(builder: (_) => const MedicalReportScreen());
      case AddAvailableAppointmentsScreen.route_name:
        return MaterialPageRoute(builder: (_) => const AddAvailableAppointmentsScreen());
      case XrayUploadScreen.route_name:
        return MaterialPageRoute(builder: (_) => XrayUploadScreen());
      // case ScreenTest.route_name:
      //   return MaterialPageRoute(builder: (_) => const ScreenTest());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

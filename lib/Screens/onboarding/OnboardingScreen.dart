import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/OnboardingTemplate.dart';

class OnboardingScreen extends StatelessWidget {
  static const String route_name = "Onboarding";

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      {
        //! Page 1
        "image": AppAssets.Onboarding_Screen_1_imge,
        "title": "Find Trusted Doctors",
        "desc":
            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.",
      },
      {
        //! Page 2
        "image": AppAssets.Onboarding_Screen_2_imge,
        "title": "Xray Analysis",
        "desc": "Reading and analyzing pictures of xray in few seconds",
      },
      {
        //! Page 3
        "image": AppAssets.Onboarding_Screen_3_imge,
        "title": "Easy Appointments",
        "desc": "choose your suitable appointment",
      },
      
    ];

    return OnboardingTemplate(pages: pages);
  }
}

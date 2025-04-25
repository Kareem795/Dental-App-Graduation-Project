import 'package:dental_app_graduation_project/Screens/Screen_Test.dart';
import 'package:dental_app_graduation_project/Screens/Splash/Splash.dart';
import 'package:flutter/material.dart';
import 'App controll/app_router.dart';
import 'App controll/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DentalApp());
}

class DentalApp extends StatelessWidget {
  const DentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental Graduation',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: Splash.route_name,
      // initialRoute: ScreenTest.route_name,
      onGenerateRoute: AppRouter.onGenerateRoute,
      // يمكنك دعم اللغات هنا:
      // supportedLocales: const [Locale('en'), Locale('ar')],
      // localizationsDelegates: [...],
    );
  }
}

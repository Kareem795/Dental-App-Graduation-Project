import 'package:dental_app_graduation_project/Screens/Patient/Home_Patient_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dental_app_graduation_project/Provider/my_provider.dart';
import 'package:dental_app_graduation_project/App controll/app_router.dart';
import 'package:dental_app_graduation_project/App controll/app_theme.dart';
import 'package:dental_app_graduation_project/Screens/Splash/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MyProvider appProvider = MyProvider();
  await appProvider.getThemeLang(); 

  runApp(
    ChangeNotifierProvider<MyProvider>.value(
      value: appProvider,
      child: const DentalApp(),
    ),
  );
}

class DentalApp extends StatelessWidget {
  const DentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);

    return MaterialApp(
      title: 'Dental Graduation',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,                // الثيم الفاتح
      darkTheme: darkTheme,            // الثيم الداكن
      themeMode: provider.appTheme,    // الوضع الحالي (فاتح/داكن)
      initialRoute: Splash.route_name, // أول شاشة

      // initialRoute: HomePatientScreen.route_name, // أول شاشة

      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

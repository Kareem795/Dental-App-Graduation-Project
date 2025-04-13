import 'package:dental_app_graduation_project/Screens/doctor/Add_Available_Appointments_Screen.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Medical_Report_Screen.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Xray_Upload_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Patiant_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/settings/Setting_Screen.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Favourite_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Home_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Massege_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Search_Tab.dart';
import 'package:dental_app_graduation_project/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomeDoctorScreen extends StatefulWidget {
  static const String route_name = "Home Doctor Screen";
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  int sellectedTabIndex = 0;
  List<Widget> tabs = const [HomeTab(), HaertTab(), SearchTab(), MassegeTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/kareem.jpg"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Menu",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                // اضف هنا التنقل أو الإجراء المطلوب
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.route_name);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, ProfileSetupScreen.route_name);
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.fileMedical),
              title: const Text("Medical Report"),
              onTap: () {
                Navigator.pushNamed(context, MedicalReportScreen.route_name);
              },
            ),

            ListTile(
              leading: const Icon(FontAwesomeIcons.xRay),
              title: const Text("Upload X-ray"),
              onTap: () {
                Navigator.pushNamed(context, XrayUploadScreen.route_name);
              },
            ),

            ListTile(
              // leading: const Icon(FontAwesomeIcons.xRay),
              leading: Icon(FontAwesomeIcons.calendarCheck),
              title: const Text("Add Appointment"),
              onTap: () {
                Navigator.pushNamed(context, AddAvailableAppointmentsScreen.route_name);              },
            ),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),
            
            
          ],
        ),
      ),

      body: tabs[sellectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: sellectedTabIndex,
        onTap: (index) {
          sellectedTabIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: AppColors.primary,
        //selectedFontSize: 25,
        iconSize: 25,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
        ],
      ),
    );
  }
}
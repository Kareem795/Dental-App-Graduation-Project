import 'package:dental_app_graduation_project/Screens/Auth/Sign%20up/Sign_up_Screen_Doctor.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Doctor_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant%20Tabs/home_tab.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/CustomTabBar.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Add_Available_Appointments_Screen.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Medical_Report_Screen.dart';
import 'package:dental_app_graduation_project/Screens/doctor/Xray_Upload_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Patiant_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/settings/Setting_Screen.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant%20Tabs/Favourite_Tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeDoctorScreen extends StatefulWidget {
  static const String route_name = "Home Doctor Screen";
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  int selectedTabIndex = 0;
  List<Widget> tabs = const [
    HomeTab(),
    FavouriteTab(),
  ];

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
            drawer: Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)
                          ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppAssets.Kemo),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Menu",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
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
                      Navigator.pushNamed(
                          context, DoctorProfileScreen.route_name);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.fileMedical),
                    title: const Text("Medical Report"),
                    onTap: () {
                      Navigator.pushNamed(
                          context, MedicalReportScreen.route_name);
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
                    leading: const Icon(FontAwesomeIcons.calendarCheck),
                    title: const Text("Add Appointment"),
                    onTap: () {
                      Navigator.pushNamed(
                          context, AddAvailableAppointmentsScreen.route_name);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Logout",
                        style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SignUpScreenDoctor.route_name);
                    },
                  ),
                ],
              ),
            ),
            body: tabs[selectedTabIndex],
            bottomNavigationBar: CustomTabBar(
              selectedIndex: selectedTabIndex,
              onTabChanged: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: "Favorite",
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.arrow_back),
                //   label: "Search",
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.chat_bubble_outline),
                //   label: "Chat",
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

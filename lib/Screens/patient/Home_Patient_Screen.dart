import 'package:dental_app_graduation_project/Screens/Auth/Sign%20up/Sign_up_Screen_Patient.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant%20Tabs/home_tab.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/CustomTabBar.dart';
import 'package:dental_app_graduation_project/Screens/patient/Patiant_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/settings/Setting_Screen.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant%20Tabs/Favourite_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant%20Tabs/Massege_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Patiant%20Tabs/Search_Tab.dart';
import 'package:flutter/material.dart';

class HomePatientScreen extends StatefulWidget {
  static const String route_name = "Home Patient Screen";
  const HomePatientScreen({super.key});

  @override
  State<HomePatientScreen> createState() => _HomePatientScreenState();
}

class _HomePatientScreenState extends State<HomePatientScreen> {
  int selectedTabIndex = 0;
  List<Widget> tabs = const [HomeTab(), FavouriteTab(), SearchTab(), MassegeTab()];

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
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                          context, PatiantProfileScreen.route_name);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Logout",
                        style: TextStyle(color: Colors.red)),
                    onTap: () {
                      
                      Navigator.pushReplacementNamed(
                          context, SignUpScreenPatient.route_name);
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
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: "Chat",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

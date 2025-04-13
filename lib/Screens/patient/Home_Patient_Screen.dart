import 'package:dental_app_graduation_project/Screens/patient/Patiant_Profile_Screen.dart';
import 'package:dental_app_graduation_project/Screens/settings/Setting_Screen.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Favourite_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Home_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Massege_Tab.dart';
import 'package:dental_app_graduation_project/Screens/tabs/Search_Tab.dart';
import 'package:dental_app_graduation_project/utils/app_colors.dart';
import 'package:flutter/material.dart';


class HomePatientScreen extends StatefulWidget {
  static const String route_name = "Home Patient Screen";
  const HomePatientScreen({super.key});

  @override
  State<HomePatientScreen> createState() => _HomePatientScreenState();
}

class _HomePatientScreenState extends State<HomePatientScreen> {
  int sellectedTabIndex = 0;
  List<Widget> tabs = const [HomeTab(), HaertTab(), SearchTab(), MassegeTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.tealAccent,
      //   title: Text("Doctor",style: TextStyle(fontSize: 20,color: Colors.black),),
      // ),

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

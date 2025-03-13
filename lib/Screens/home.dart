import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Patiant_Profile_Screen.dart';
import 'package:graduation_project/Screens/Setting_Screen.dart';
import 'package:graduation_project/Screens/tabs/search_tab.dart';

import 'tabs/favourite_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/massege_tab.dart';

class Home extends StatefulWidget {
  static const String route_name = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(14, 189, 126, 1),
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
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                // اضف هنا التنقل أو الإجراء المطلوب
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.route_name);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, ProfileSetupScreen.route_name);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
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
        backgroundColor: Color.fromRGBO(14, 189, 126, 1),
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

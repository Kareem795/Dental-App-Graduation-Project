import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/Background/BackgroundWrapper.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String route_name = "SettingsScreen";

  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool textMessages = true;
  bool phoneCalls = true;

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Account settings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildListTile(Icons.lock, "Change Password"),
            buildListTile(Icons.notifications, "Notifications"),
            buildListTile(Icons.bar_chart, "Statistics"),
            buildListTile(Icons.info, "About us"),
            const SizedBox(height: 20),
            const Text(
              "More options",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildSwitchTile("Text messages", textMessages, (value) {
              setState(() => textMessages = value);
            }),
            buildSwitchTile("Phone calls", phoneCalls, (value) {
              setState(() => phoneCalls = value);
            }),
            buildListTile(Icons.language, "Languages", trailingText: "English"),
            buildListTile(Icons.attach_money, "Currency", trailingText: "\$-USD"),
            buildListTile(Icons.link, "Linked accounts", trailingText: "Facebook, Google"),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, {String? trailingText}) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16), // حجم أصغر
      ),
      trailing: trailingText != null
          ? Text(
              trailingText,
              style: const TextStyle(color: Colors.grey, fontSize: 14), // حجم أصغر
            )
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16), // حجم أصغر
      ),
      value: value,
      activeColor: AppColors.primary,
      onChanged: onChanged,
    );
  }
}

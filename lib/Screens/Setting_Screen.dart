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
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset("assets/bg.png"),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text("Settings"),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                buildListTile(Icons.language, "Languages",
                    trailingText: "English"),
                buildListTile(Icons.attach_money, "Currency",
                    trailingText: "\$-USD"),
                buildListTile(Icons.link, "Linked accounts",
                    trailingText: "Facebook, Google"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, {String? trailingText}) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color.fromRGBO(14, 189, 126, 1),
      ),
      title: Text(title),
      trailing: trailingText != null
          ? Text(trailingText, style: const TextStyle(color: Colors.grey))
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      activeColor: const Color.fromRGBO(14, 189, 126, 1),
      onChanged: onChanged,
    );
  }
}

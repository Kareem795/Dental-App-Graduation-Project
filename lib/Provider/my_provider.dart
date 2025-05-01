import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  Locale langCode = const Locale("ar");

  late SharedPreferences sharedPreferences;

  Future<void> getThemeLang() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // استرجاع اللغة المحفوظة
    langCode = sharedPreferences.getBool("isArabic") ?? false
        ? const Locale("ar")
        : const Locale("en");

    // استرجاع الثيم المحفوظ
    appTheme = sharedPreferences.getBool("isDark") ?? false
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners(); // لتحديث أي مستمعين بعد التغيير
  }

  void changeTheme(ThemeMode mode) {
    appTheme = mode;
    notifyListeners();
    _saveTheme(mode == ThemeMode.dark);
  }

  void toggleTheme() {
    if (appTheme == ThemeMode.dark) {
      changeTheme(ThemeMode.light);
    } else {
      changeTheme(ThemeMode.dark);
    }
  }

  void _saveLang(bool isArabic) {
    sharedPreferences.setBool("isArabic", isArabic);
  }

  void _saveTheme(bool isDark) {
    sharedPreferences.setBool("isDark", isDark);
  }

  void changeLanguage(Locale local) {
    langCode = local;
    notifyListeners();
    _saveLang(local == const Locale("ar"));
  }
}

import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final List<BottomNavigationBarItem> items;

  const CustomTabBar({
    required this.selectedIndex,
    required this.onTabChanged,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTabChanged,

      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      backgroundColor: AppColors.primary,
      iconSize: 25,
      
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: items,
    );
  }
}

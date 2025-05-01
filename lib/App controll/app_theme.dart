import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_style.dart';
import 'package:flutter/material.dart';

//! Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  primaryColor: AppColors.primary,

  scaffoldBackgroundColor: AppColors.white,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.black,
    elevation: 0,
    titleTextStyle: AppStyle.googleStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
  ),







  textTheme: TextTheme(

    //! headlineLarge   (26 => 30)   =========================>>>>        style: textTheme.headlineLarge
    headlineLarge: AppStyle.googleStyle(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: AppColors.black,
      ),

    //! headlineMedium   (20 => 23)   =========================>>>>        style: textTheme.headlineMedium
    headlineMedium: AppStyle.googleStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: AppColors.black,
      ),

      //! headlineSmall  (14 => 18)      =========================>>>>        style: textTheme.headlineSmall
      headlineSmall: AppStyle.googleStyle(
        fontSize: 16,
        color: AppColors.black,
      ),



      //! bodyLarge   (26 => 30)   =========================>>>>        style: textTheme.bodyLarge?.copyWith()
      bodyLarge: AppStyle.googleStyle(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),

      //! bodyMedium   (20 => 23)   =========================>>>>        style: textTheme.bodyMedium?.copyWith()
      bodyMedium: AppStyle.googleStyle(
        fontSize: 20,
        color: Colors.black87,
      ),

      //! bodySmall   (14 => 18)   =========================>>>>        style: textTheme.bodySmall?.copyWith()
      bodySmall: AppStyle.googleStyle(
        fontSize: 16,
        // fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      
      
    ),













  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white, // لون النص الافتراضي للأزرار
      textStyle: AppStyle.googleStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
    ),
  ),

  iconTheme: const IconThemeData(color: Colors.black54),
  
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF6F6F6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    hintStyle: AppStyle.googleStyle(
      fontSize: 14,
      color: AppColors.grey,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.primary,
    selectedItemColor: AppColors.black,
    unselectedItemColor: AppColors.white,
    showSelectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
  
);





//!==================================================================

//! Dark Theme King
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  primaryColor: AppColors.primary,

  scaffoldBackgroundColor: AppColors.black,
  
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.white,
    elevation: 0,
    titleTextStyle: AppStyle.googleStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
  ),
  
  
  
  
  textTheme: TextTheme(

    //! headlineLarge   (26 => 30)   =========================>>>>        style: textTheme.headlineLarge
    headlineLarge: AppStyle.googleStyle(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: AppColors.white,
      ),

    //! headlineMedium   (20 => 23)   =========================>>>>        style: textTheme.headlineMedium
    headlineMedium: AppStyle.googleStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: AppColors.white,
      ),

      //! headlineSmall  (14 => 18)      =========================>>>>        style: textTheme.headlineSmall
      headlineSmall: AppStyle.googleStyle(
        fontSize: 16,
        color: AppColors.white,
      ),



      //! bodyLarge   (26 => 30)   =========================>>>>        style: textTheme.bodyLarge?.copyWith()
      bodyLarge: AppStyle.googleStyle(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),

      //! bodyMedium   (20 => 23)   =========================>>>>        style: textTheme.bodyMedium?.copyWith()
      bodyMedium: AppStyle.googleStyle(
        fontSize: 20,
        color: Colors.white70,
      ),

      //! bodySmall   (14 => 18)   =========================>>>>        style: textTheme.bodySmall?.copyWith()
      bodySmall: AppStyle.googleStyle(
        fontSize: 16,
        // fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      
      
    ),








  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      textStyle: AppStyle.googleStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
    ),
  ),

  iconTheme: const IconThemeData(color: Colors.white70),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1F1F1F),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    hintStyle: AppStyle.googleStyle(
      fontSize: 14,
      color: Colors.white38,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.primary,
    selectedItemColor: AppColors.white,
    unselectedItemColor: AppColors.black,
    showSelectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyle {

  static TextStyle googleStyle({
    double? fontSize = 22,
    FontWeight? fontWeight,
    Color? color = Colors.black87,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight, // حتى لو null، مش مشكلة
    );
  }
  
}

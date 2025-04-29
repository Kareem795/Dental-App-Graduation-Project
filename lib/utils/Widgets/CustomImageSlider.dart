import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';

class CustomImageSlider extends StatelessWidget {
  final double? height; // جعلها اختياريه
  final double? width;  // إضافة العرض كخاصية اختيارية
  final double borderRadius;
  final EdgeInsets margin;

  static const String route_name = "Custom_Image_Slider";

  const CustomImageSlider({
    super.key,
    this.height = 300, // القيمة الافتراضية 300
    this.width, // العرض سيكون اختياري
    this.borderRadius = 20,
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  });

  static final List<String> _defaultImages = [
    AppAssets.Dental_doctors_announcement_1,
    AppAssets.Dental_doctors_announcement_2,
    AppAssets.Dental_doctors_announcement_3,
    AppAssets.Dental_doctors_announcement_4,
    AppAssets.Dental_doctors_announcement_5,
    AppAssets.Dental_doctors_announcement_6,
    AppAssets.Dental_doctors_announcement_7,
    AppAssets.Dental_doctors_announcement_8,
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: _defaultImages.map((imagePath) {
        return Container(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4), // اتجاه الظل لتحت شوية
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.asset(
              imagePath,
              width: width ?? MediaQuery.of(context).size.width * 0.9, // استخدم القيمة المحددة أو العرض الافتراضي
              height: height ?? 300, // استخدم القيمة المحددة أو الارتفاع الافتراضي
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: height ?? 300, // قيمة الارتفاع
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        viewportFraction: 0.85,
        scrollPhysics: const BouncingScrollPhysics(),
        enableInfiniteScroll: true,
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}

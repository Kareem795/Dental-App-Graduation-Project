import 'package:dental_app_graduation_project/Screens/Patient/Home_Patient_Screen.dart';
import 'package:dental_app_graduation_project/Screens/Screen_Test.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_constants.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_style.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/CustomImageSlider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeTab extends StatelessWidget {
  static const String route_name = "Home_Tab";
  const HomeTab({super.key});

  Future<List<Map<String, dynamic>>> fetchDoctors() async {
    final url = Uri.parse('${AppConstants.URL}/api/doctors/');

    try {
      final response = await http.get(url);
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List data = decoded['data'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception("Failed to load doctors");
      }
    } catch (e) {
      print("Fetch error: $e");
      throw Exception("Error fetching doctors");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [buildHeader(context), buildSearchBar(context)],
          ),
          const SizedBox(height: 20,),
          // في مكان الاستدعاء
          const CustomImageSlider (height: 230, borderRadius: 25,),

          const SizedBox(height: 20,),
          // buildCommunitySection(),
          buildPopularDoctors(),
          buildFeatureDoctors(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme; //! Very very Important

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi User!",
                style: textTheme.headlineSmall?.copyWith(fontSize: 18 , fontWeight: FontWeight.bold,)
              ),
              const SizedBox(height: 5),
              Text(
                "Dr dentist application",
                style: textTheme.headlineMedium?.copyWith(fontSize: 22)
              ),
            ],
          ),
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                ScaffoldState? scaffoldState =
                    context.findAncestorStateOfType<ScaffoldState>();
                scaffoldState?.openDrawer();
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.Kemo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
  final theme = Theme.of(context); //! very important

  return Padding(
    padding: const EdgeInsets.only(top: 135, left: 20, right: 20),
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
        prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
        hintText: "Search...",
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.hintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: theme.textTheme.bodySmall,
    ),
  );
}


  Widget buildCommunitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Community",
            style:
                AppStyle.googleStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(3, (index) {
              return Expanded(
                child: Container(
                  height: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.Community_image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  // ✅ قسم الأطباء المشهورين
  Widget buildPopularDoctors() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDoctors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primary,
          ));
        } else if (snapshot.hasError) {
          return const Center(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Error loading doctors\n",
                style: TextStyle(color: AppColors.primary, fontSize: 25),
              ),
            ],
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            "No doctors found\n",
            style: TextStyle(color: AppColors.primary, fontSize: 25),
          ));
        }

        final doctors = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Doctor",
                    style: AppStyle.googleStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "See all >",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 225,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: doctors.map((doctor) {
                    return buildDoctorCard(
                      doctor['name'] ?? 'Unknown',
                      'Dentist Specialist', // تقدر تجيب التخصص لو موجود في الـ API
                      AppAssets
                          .Popular_image, // أو doctor['photo'] لو الصورة من API
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ✅ قسم الأطباء المميزين
  Widget buildFeatureDoctors() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDoctors(), // نفس دالة الفيتش اللي استخدمناها قبل كده
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primary,
          ));
        } else if (snapshot.hasError) {
          return const Center(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Error loading doctors",
                style: TextStyle(color: AppColors.primary, fontSize: 25),
              ),
            ],
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No doctors found"));
        }

        final doctors = snapshot.data!;
        final topDoctors = doctors.take(3).toList(); // أول 3 دكاترة بس

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Feature Doctor",
                    style: AppStyle.googleStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "See all >",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  buildSmallDoctorCard(
                    topDoctors[0]['name'] ?? 'Doctor 1',
                    AppAssets.Feature1_image,
                    "⭐ 3.7",
                  ),
                  buildSmallDoctorCard(
                    topDoctors[1]['name'] ?? 'Doctor 2',
                    AppAssets.Feature2_image,
                    "⭐ 3.6",
                  ),
                  buildSmallDoctorCard(
                    topDoctors[2]['name'] ?? 'Doctor 3',
                    AppAssets.Feature3_image,
                    "⭐ 2.9",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDoctorCard(String name, String specialty, String image) {
    return Container(
      width: 175,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(image, height: 90),
          const SizedBox(height: 10),
          Text(name,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),

              // AppStyle.googleStyle(fontWeight: FontWeight.bold),
              // softWrap: true,
              // overflow: TextOverflow.ellipsis,
              //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Help

              textAlign: TextAlign.center),
          Text(specialty,
              style: GoogleFonts.poppins(color: Colors.grey),

              // AppStyle.googleStyle(color: Colors.grey),
              // softWrap: true,
              // overflow: TextOverflow.ellipsis,
              //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Help

              textAlign: TextAlign.center),
          const SizedBox(height: 5),
          const Icon(Icons.star, color: Colors.orange, size: 20),
        ],
      ),
    );
  }

  // ✅ بطاقة طبيب صغيرة
  Widget buildSmallDoctorCard(String name, String image, String rating) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(image, height: 50),
            const SizedBox(height: 5),
            Text(
              name,
              style: AppStyle.googleStyle(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              rating,
              style: AppStyle.googleStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

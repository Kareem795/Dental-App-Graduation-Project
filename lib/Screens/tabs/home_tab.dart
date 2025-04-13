import 'package:dental_app_graduation_project/utils/app_colors.dart';
import 'package:dental_app_graduation_project/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  static const String route_name = "bhjdfbjv";
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [buildHeader(context), buildSearchBar()],
          ),
          const SizedBox(
            height: 20,
          ),
          buildCommunitySection(),
          buildPopularDoctors(),
          buildFeatureDoctors(),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
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
                "Hi user!",
                style: AppStyle.googleStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),

                // GoogleFonts.poppins(
                //   fontSize: 18,
                //   color: Colors.white,
                // ),
              ),
              const SizedBox(height: 5),
              Text(
                "Dr dentist application",
                style: AppStyle.googleStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/kareem.jpg'),
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

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 135, left: 20, right: 20),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          hintText: "Search...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/Community_image_home.png'),
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
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See all >",
                    style: TextStyle(color: AppColors.primary),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildDoctorCard("Dr. Fillerup Grab", "Dentist Specialist",
                    'assets/Community_image_home.png'),
                buildDoctorCard("Dr. Blessing", "Dentist Specialist",
                    'assets/Popular_image_home.png'),
                buildDoctorCard("Dr. Blessing", "Dentist Specialist",
                    'assets/Community_image_home.png'),
                buildDoctorCard("Dr. Blessing", "Dentist Specialist",
                    'assets/Popular_image_home.png'),
                buildDoctorCard("Dr. Blessing", "Dentist Specialist",
                    'assets/Popular_image_home.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ قسم الأطباء المميزين
  Widget buildFeatureDoctors() {
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
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              buildSmallDoctorCard(
                  "Dr. Crick", 'assets/Feature1_image_home.png', "⭐ 3.7"),
              buildSmallDoctorCard(
                  "Dr. Strain", 'assets/Feature2_image_home.png', "⭐ 3.6"),
              buildSmallDoctorCard(
                  "Dr. Lachinet", 'assets/Feature3_image_home.png', "⭐ 2.9"),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDoctorCard(String name, String specialty, String image) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
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
          color: Colors.white,
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

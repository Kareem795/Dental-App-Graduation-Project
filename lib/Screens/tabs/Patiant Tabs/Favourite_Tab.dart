import 'package:dental_app_graduation_project/Screens/Patient/Home_Patient_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Show_Doctor_details_Screen.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/Background/BackgroundWrapper.dart';
import 'package:flutter/material.dart';

class FavouriteTab extends StatelessWidget {
  static const String route_name = "Favourite Tab";
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> favouriteDoctors = [
      {
        "name": "Dr. Kemo",
        "specialty": "Specialist Cardiology",
        "image": AppAssets.Kemo,
        "isFavorite": true
      },
      {
        "name": "Dr. Shouey",
        "specialty": "Specialist Dentist",
        "image": AppAssets.Popular_image,
        "isFavorite": false
      },
      {
        "name": "Dr. Shouey",
        "specialty": "Specialist Medicine",
        "image": AppAssets.Feature1_image,
        "isFavorite": true
      },
      {
        "name": "Dr. Christenfeld N",
        "specialty": "Specialist Cancer",
        "image": AppAssets.Feature3_image,
        "isFavorite": true
      },
      {
        "name": "Dr. Shouey",
        "specialty": "Specialist Cardiology",
        "image": AppAssets.Feature4_image,
        "isFavorite": false
      },
    ];
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Favourite"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popAndPushNamed(context, HomePatientScreen.route_name);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: favouriteDoctors.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    var doctor = favouriteDoctors[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, DoctorDetailsScreen.route_name);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DoctorCard(
                          name: doctor["name"],
                          specialty: doctor["specialty"],
                          image: doctor["image"],
                          isFavorite: doctor["isFavorite"],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ تعديل DoctorCard ليكون StatefulWidget
class DoctorCard extends StatefulWidget {
  final String name;
  final String specialty;
  final String image;
  final bool isFavorite;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.image,
    required this.isFavorite,
  });

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme; //! Very very Important
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // ✅ لون أبيض خفيف شفاف
        borderRadius: BorderRadius.circular(15), // ✅ زوايا ناعمة متناسقة
        border: Border.all(
          color: Colors.grey.shade300, // ✅ خط خفيف حول الكارت
          width: 3,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CircleAvatar(
            backgroundImage: AssetImage(widget.image),
            radius: 35,
          ),
          const SizedBox(height: 8),
          Text(
            widget.name,
            style: textTheme.bodySmall?.copyWith(
              overflow: TextOverflow.ellipsis, // ✅ لو الاسم طويل
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            widget.specialty,
            style: textTheme.bodySmall?.copyWith(
              overflow: TextOverflow.ellipsis, // ✅ لو الاسم طويل
              color: AppColors.primary,
              fontSize: 14
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}




//! ======================================== Delete Soon =====================================

Widget FeatureDoctorCard(String name, String rating, String image) {
  return Container(
    width: 100,
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min, // ⬅️ مهم جدًا
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: Icon(Icons.star, color: Colors.orange, size: 18),
        ),
        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: 25,
        ),
        const SizedBox(height: 5),
        Flexible(
          // ⬅️ هنا عشان الاسم الطويل ما يعملش overflow
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Flexible(
          child: Text(
            "$rating ⭐",
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

//! ======================================== Delete Soon =====================================

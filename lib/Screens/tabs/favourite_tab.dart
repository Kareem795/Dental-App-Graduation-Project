import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Doctor_details_Screen.dart';

import 'home_tab.dart';

class HaertTab extends StatelessWidget {
  static const String route_name = "Haert Tab";
  const HaertTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> favouriteDoctors = [
      {
        "name": "Dr. Shouey",
        "specialty": "Specialist Cardiology",
        "image": "assets/Feature4_image_home.png",
        "isFavorite": false
      },
      {
        "name": "Dr. Christenfeld N",
        "specialty": "Specialist Cancer",
        "image": "assets/Feature3_image_home.png",
        "isFavorite": true
      },
      {
        "name": "Dr. Shouey",
        "specialty": "Specialist Medicine",
        "image": "assets/Feature1_image_home.png",
        "isFavorite": true
      },
      {
        "name": "Dr. Shouey",
        "specialty": "Specialist Dentist",
        "image": "assets/Popular_image_home.png",
        "isFavorite": false
      },
    ];
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset("assets/bg.png"),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text("Favourite"),
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  
                  // Search Bar,
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Grid of Favourite Doctors
                  Expanded(
                    child: GridView.builder(
                      itemCount: favouriteDoctors.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        var doctor = favouriteDoctors[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DoctorDetailsScreen.route_name);
                          },
                          child: DoctorCard(
                            name: doctor["name"],
                            specialty: doctor["specialty"],
                            image: doctor["image"],
                            isFavorite: doctor["isFavorite"],
                          ),
                        );
                      },
                    ),
                  ),

                  // Feature Doctors Section
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Feature Doctor",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: () {}, child: const Text("See all >")),
                    ],
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        FeatureDoctorCard("Dr. Crick", "3.7",
                            "assets/Community_image_home.png"),
                        FeatureDoctorCard(
                            "Dr. Strain", "3.0", "assets/Popular_image_home.png"),
                        FeatureDoctorCard("Dr. Lachinet", "2.9",
                            "assets/Feature1_image_home.png"),
                        FeatureDoctorCard("Dr. Lachinet", "2.9",
                            "assets/Feature2_image_home.png"),
                        FeatureDoctorCard("Dr. Lachinet", "2.9",
                            "assets/Feature4_image_home.png"),
                        FeatureDoctorCard("Dr. Lachinet", "2.9",
                            "assets/Community_image_home.png"),
                        FeatureDoctorCard("Dr. Lachinet", "2.9",
                            "assets/Popular_image_home.png"),
                        FeatureDoctorCard("Dr. Lachinet", "2.9",
                            "assets/Feature1_image_home.png"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
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
  late bool isFavorite; // متغير لتخزين حالة القلب

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite; // استلام القيمة الأولية من الـ widget
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite; // تغيير الحالة عند الضغط
                });
              },
            ),
          ),
          CircleAvatar(
            backgroundImage: AssetImage(widget.image),
            radius: 30,
          ),
          const SizedBox(height: 2),
          Text(
            widget.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            widget.specialty,
            style: const TextStyle(
              color: Color.fromRGBO(14, 189, 126, 1),
            ),
          ),
        ],
      ),
    );
  }
}

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
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Icon(Icons.star, color: Colors.orange, size: 18),
        ),
        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: 25,
        ),
        const SizedBox(height: 5),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text("$rating ⭐"),
      ],
    ),
  );
}

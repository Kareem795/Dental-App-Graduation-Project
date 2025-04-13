import 'package:dental_app_graduation_project/Screens/patient/Select_Doctor_Available_Time_Screen.dart';
import 'package:dental_app_graduation_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatefulWidget {
  static const String route_name ="Doctor Details Screen";

  const DoctorDetailsScreen({super.key});
  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade50,
                Colors.white,
                AppColors.primary,
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Doctor Details"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: const [Icon(Icons.search)],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/Popular_image_home.png",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr. Amira",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Dentist"),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.orange, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.orange, size: 18),
                                      Icon(Icons.star,
                                          color: Colors.orange, size: 18),
                                      Icon(Icons.star_half,
                                          color: Colors.orange, size: 18),
                                      Icon(Icons.star_border,
                                          color: Colors.orange, size: 18),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      "\$ ",
                                      style: TextStyle(
                                          color:
                                              AppColors.primary,
                                          fontSize: 20),
                                    ),
                                    Text("25.00/hr",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, SelectTimeScreen.route_name);
                            },
                            child: const Text("Book Now",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _infoCard("100", "Running"),
                    _infoCard("500", "Ongoing"),
                    _infoCard("700", "Patient"),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Services",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _serviceItem(
                    "1. Patient care should be the number one priority."),
                const Divider(),
                _serviceItem(
                    "2. If you run your practice you know how frustrating."),
                const Divider(),
                _serviceItem(
                    "3. That's why some of appointment reminder system."),
                const Divider(),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/map.png", fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoCard(String number, String label) {
    return Column(
      children: [
        Text(number,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _serviceItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle,
              color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

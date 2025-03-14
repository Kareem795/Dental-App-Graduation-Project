import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Doctor_selete_time_Screen.dart';

class DoctorDetailsScreen extends StatefulWidget {
  static const String route_name ="Doctor Details Screen";
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
                Color.fromRGBO(14, 189, 126, 1),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Doctor Details"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [Icon(Icons.search)],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
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
                            SizedBox(width: 16),
                            Expanded(
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
                                Row(
                                  children: [
                                    Text(
                                      "\$ ",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(14, 189, 126, 1),
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
                              backgroundColor: Color.fromRGBO(14, 189, 126, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, SelectTimeScreen.route_name);
                            },
                            child: Text("Book Now",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _infoCard("100", "Running"),
                    _infoCard("500", "Ongoing"),
                    _infoCard("700", "Patient"),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  "Services",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                _serviceItem(
                    "1. Patient care should be the number one priority."),
                Divider(),
                _serviceItem(
                    "2. If you run your practice you know how frustrating."),
                Divider(),
                _serviceItem(
                    "3. That's why some of appointment reminder system."),
                Divider(),
                SizedBox(height: 16),
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _serviceItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle,
              color: Color.fromRGBO(14, 189, 126, 1), size: 20),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/Doctor_details_Screen.dart';
import 'package:graduation_project/Screens/Doctor_selete_time_Screen.dart';

class SearchTab extends StatefulWidget {
  static const String route_name = "Search Tab";
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Map<String, dynamic>> doctors = List.generate(
      10,
      (index) => {
            "name": "Dr. Doctor ${index + 1}",
            "specialty":
                "Specialist ${index % 3 == 0 ? "Medicine" : index % 3 == 1 ? "Dentist" : "Cardiology"}",
            "experience": "${5 + index} Years experience",
            "rating": "${50 + (index * 5)}%",
            "reviews": "${50 + index} Patient Stories",
            "nextAvailable": "${10 + (index % 3)}:00 AM tomorrow",
            "image": "assets/Feature2_image_home",
            "favorite": false,
          });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset("assets/bg.png"),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text("My Doctors"),
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: doctors.length,
                      itemBuilder: (context, index) {
                        var doctor = doctors[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DoctorDetailsScreen.route_name);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            "assets/Feature4_image_home.png",
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                doctor["name"],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                              Text(
                                                doctor["specialty"],
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      14, 189, 126, 1),
                                                ),
                                              ),

                                              SizedBox(height: 10),

                                              Text(
                                                doctor["experience"],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),

                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Color.fromRGBO(14,
                                                                189, 126, 1),
                                                        minRadius: 6,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        "${doctor["rating"]}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Color.fromRGBO(14,
                                                                189, 126, 1),
                                                        minRadius: 6,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        "${doctor["reviews"]}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),

                                              // SizedBox(height: 4),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        IconButton(
                                          icon: Icon(
                                            doctor["favorite"]
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: doctor["favorite"]
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              doctor["favorite"] =
                                                  !doctor["favorite"];
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Next Available",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        14, 189, 126, 1),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${doctor["nextAvailable"]}",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromRGBO(14, 189, 126, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                SelectTimeScreen.route_name);
                                          },
                                          child: Text(
                                            "Book Now",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
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

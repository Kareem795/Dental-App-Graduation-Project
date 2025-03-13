import 'package:flutter/material.dart';

class SelectTimeScreen extends StatefulWidget {
  static const String route_name = "Select Time Screen";
  @override
  _SelectTimeScreenState createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {
  int selectedDateIndex = 1;
  bool isFavorite = false;
  List<Map<String, dynamic>> dates = [
    {"date": "Today, 23 Feb", "slots": 0},
    {"date": "Tomorrow, 24 Feb", "slots": 9},
    {"date": "Thursday, 25 Feb", "slots": 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage("assets/Ellipse 143.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage("assets/Ellipse 142.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text("Select Time"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
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
                      padding: EdgeInsets.all(20.0),
                      child: Row(
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
                                  "Dr. Shruti Kedia",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text("Upasana Dental Clinic, Salt Lake"),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(dates.length, (index) {
                        return ChoiceChip(
                          label: Text(
                            dates[index]["date"],
                            style: TextStyle(
                              color: selectedDateIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          selected: selectedDateIndex == index,
                          selectedColor: Color.fromRGBO(14, 189, 126, 1),
                          onSelected: (selected) {
                            setState(() {
                              selectedDateIndex = index;
                            });
                          },
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    dates[selectedDateIndex]["date"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    dates[selectedDateIndex]["slots"] > 0
                        ? "${dates[selectedDateIndex]["slots"]} slots available"
                        : "No slots available",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(14, 189, 126, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Next availability on Wed, 24 Feb",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text("OR"),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side:
                            BorderSide(color: Color.fromRGBO(14, 189, 126, 1)),
                      ),
                      onPressed: () {},
                      child: Text("Contact Clinic",
                          style: TextStyle(
                              color: Color.fromRGBO(14, 189, 126, 1))),
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

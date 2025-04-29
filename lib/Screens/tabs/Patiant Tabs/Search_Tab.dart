import 'package:dental_app_graduation_project/Screens/Patient/Home_Patient_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Show_Doctor_details_Screen.dart';
import 'package:dental_app_graduation_project/Screens/patient/Select_Doctor_Available_Time_Screen.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class SearchTab extends StatefulWidget {
  static const String route_name = "Search Tab";
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final dio = Dio(BaseOptions(baseUrl: "${AppConstants.URL}"));

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;

  Set<int> favoriteDoctors = {}; // 💥 مفضلة

  Future<List<dynamic>> searchDoctors(String query) async {
    try {
      final response = await dio.get('/api/doctors/search', queryParameters: {
        'query': query,
      });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      throw Exception('Error searching doctors: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchDoctors() async {
    final url = Uri.parse('${AppConstants.URL}/api/doctors/');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List data = decoded['data'];
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to fetch doctors");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.Background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text("Favourite"),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.popAndPushNamed(context , HomePatientScreen.route_name); // ✅ يرجع للشاشة اللي قبلها
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (query) async {
                      if (query.isNotEmpty) {
                        final results = await searchDoctors(query);
                        setState(() {
                          isSearching = true;
                          searchResults = results.cast<Map<String, dynamic>>();
                        });
                      } else {
                        setState(() {
                          isSearching = false;
                          searchResults = [];
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  buildDoctorsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDoctorsList() {
    return Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: isSearching ? Future.value(searchResults) : fetchDoctors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !isSearching) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
              "Error loading doctors",
              style: TextStyle(color: AppColors.primary, fontSize: 25),
            ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              "No doctors found",
              style: TextStyle(color: AppColors.primary, fontSize: 25),
            ));
          }

          final doctors = snapshot.data!;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              var doctor = doctors[index];
              return buildDoctorCard(index, doctor); // 🔥 نمرر الفهرس
            },
          );
        },
      ),
    );
  }

  Widget buildDoctorCard(int index, Map<String, dynamic> doctor) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DoctorDetailsScreen.route_name);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppAssets.Feature4_image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor["name"] ?? "Dr. Unknown",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          doctor["Clinic_name"] ?? "Clinic",
                          style: const TextStyle(color: AppColors.primary),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "📞 ${doctor["Phone_Number"] ?? "No phone"}",
                          style: const TextStyle(color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "7 Years experience",
                          style: TextStyle(color: Colors.black),
                        ),
                        const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              minRadius: 6,
                            ),
                            SizedBox(width: 3),
                            Text(
                              "⭐ 90%",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              minRadius: 6,
                            ),
                            SizedBox(width: 3),
                            Flexible(
                              child: Text(
                                "67 Patient Stories",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    icon: Icon(
                      favoriteDoctors.contains(index)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteDoctors.contains(index)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        if (favoriteDoctors.contains(index)) {
                          favoriteDoctors.remove(index);
                        } else {
                          favoriteDoctors.add(index);
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Available",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "11:00 AM tomorrow",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectTimeScreen(
                            doctorName: doctor["name"] ?? "Dr. Unknown",
                            clinicName: doctor["Clinic_name"] ?? "Clinic",
                            imageUrl:
                                "https://cdn-icons-png.flaticon.com/512/3774/3774299.png",
                            doctorId:
                                doctor["id"], // ✅ أضفنا هنا تمرير id الدكتور
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
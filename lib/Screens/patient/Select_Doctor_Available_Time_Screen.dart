import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_constants.dart';

class SelectTimeScreen extends StatefulWidget {
  static const String route_name = "Select Time Screen";

  final String doctorName;
  final String clinicName;
  final String imageUrl;
  final int doctorId;

  const SelectTimeScreen({
    super.key,
    required this.doctorName,
    required this.clinicName,
    required this.imageUrl,
    required this.doctorId,
  });

  @override
  _SelectTimeScreenState createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {
  int selectedDateIndex = 0;
  bool isFavorite = false;
  bool isLoading = true;

  List<Map<String, dynamic>> dates = [];

  @override
  void initState() {
    super.initState();
    fetchDoctorAppointments(widget.doctorId);
  }

  Future<void> fetchDoctorAppointments(int doctorId) async {
    try {
      final response = await Dio().get(
        "${AppConstants.URL}/api/appointments/$doctorId",
      );

      if (response.statusCode == 200) {
        final List appointments = response.data;

        setState(() {
          dates = appointments.map<Map<String, dynamic>>((appointment) {
            return {
              "id": appointment['id'], 
              "date": "${appointment['day_of_week']}, ${appointment['day_of_month']} - Month ${appointment['month']}",
              "time": appointment['time'],
              "slots": 1,
            };
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load appointments");
      }
    } catch (e) {
      print("Error fetching appointments: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<void> bookAppointment() async {
    if (dates.isEmpty) return;

    final selectedAppointment = dates[selectedDateIndex];
    final int appointmentId = selectedAppointment["id"];
    final int? userId = await getUserId();

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in. Please login first.')),
      );
      return;
    }

    try {
      final response = await Dio().post(
        "${AppConstants.URL}/api/appointments/book",
        data: {
          "appointment_id": appointmentId,
          "user_id": userId,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          dates.removeAt(selectedDateIndex);

          if (dates.isNotEmpty) {
            selectedDateIndex = 0;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment booked successfully!')),
        );
      } else {
        throw Exception('Failed to book appointment');
      }
    } catch (e) {
      print("Booking Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to book appointment.')),
      );
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
              backgroundColor: Colors.transparent,
              title: const Text("Select Time"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : dates.isEmpty
                    ? const Center(
                        child: Text(
                          "No appointments available",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : Padding(
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
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        widget.imageUrl,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.person, size: 100),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.doctorName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(widget.clinicName),
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
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(dates.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ChoiceChip(
                                      label: Text(
                                        dates[index]["date"],
                                        style: TextStyle(
                                          color: selectedDateIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      selected: selectedDateIndex == index,
                                      selectedColor: AppColors.primary,
                                      onSelected: (selected) {
                                        setState(() {
                                          selectedDateIndex = index;
                                        });
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "${dates[selectedDateIndex]["date"]} at ${dates[selectedDateIndex]["time"]}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              dates[selectedDateIndex]["slots"] > 0
                                  ? "${dates[selectedDateIndex]["slots"]} slots available"
                                  : "No slots available",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: bookAppointment,
                                child: const Text(
                                  "Book Now",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // const Center(child: Text("OR")),
                            const SizedBox(height: 8),
                            // Center(
                            //   child: OutlinedButton(
                            //     style: OutlinedButton.styleFrom(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //       side: const BorderSide(color: AppColors.primary),
                            //     ),
                            //     onPressed: () {},
                            //     child: const Text(
                            //       "Contact Clinic",
                            //       style: TextStyle(color: AppColors.primary),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_constants.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/Background/Gradient_Background_Wrapper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddAvailableAppointmentsScreen extends StatefulWidget {
  const AddAvailableAppointmentsScreen({super.key});

  static const String route_name = "Add_Available_Appointments_Screen";

  @override
  State<AddAvailableAppointmentsScreen> createState() =>
      _AddAvailableAppointmentsScreenState();
}

class _AddAvailableAppointmentsScreenState
    extends State<AddAvailableAppointmentsScreen> {
  String? selectedDayOfWeek;
  int? selectedDayNumber;
  String? selectedMonth;
  TimeOfDay? selectedTime;

  final List<Map<String, String>> availableAppointments = [];

  final List<String> daysOfWeek = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  final Map<String, int> monthDays = {
    'January': 31,
    'February': 28,
    'March': 31,
    'April': 30,
    'May': 31,
    'June': 30,
    'July': 31,
    'August': 31,
    'September': 30,
    'October': 31,
    'November': 30,
    'December': 31,
  };

  List<int> getDaysForSelectedMonth() {
    if (selectedMonth == null) return [];
    int daysCount = monthDays[selectedMonth]!;
    return List.generate(daysCount, (index) => index + 1);
  }

  Future<int?> _getDoctorId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('doctor_id');
  }

  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _addAppointment() async {
    if (selectedDayOfWeek == null ||
        selectedMonth == null ||
        selectedDayNumber == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('الرجاء اختيار اليوم، الشهر، التاريخ والوقت')),
      );
      return;
    }

    try {
      final timeString =
          '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';

      final doctorId = await _getDoctorId();
      if (doctorId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في استرجاع معرف الطبيب')),
        );
        return;
      }

      final url = Uri.parse('${AppConstants.URL}/api/appointments');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "doctor_id": doctorId,
          "day_of_week": selectedDayOfWeek!.toLowerCase(),
          "month": monthDays.keys.toList().indexOf(selectedMonth!) + 1,
          "day_of_month": selectedDayNumber!,
          "time": timeString
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          availableAppointments.add({
            'day': selectedDayOfWeek!,
            'month': selectedMonth!,
            'date': selectedDayNumber.toString(),
            'time': selectedTime!.format(context),
          });

          selectedDayOfWeek = null;
          selectedMonth = null;
          selectedDayNumber = null;
          selectedTime = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إضافة الموعد: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme; //! Very very Important

    return GradientScaffoldWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Add Doctor Schedule",
                    style: textTheme.headlineLarge
                    // ?.copyWith(
                    //   // fontWeight: FontWeight.bold,
                    //   // fontSize: 26,
                    // )
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Select available days and times to add doctor appointments",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 30),

                  _styledDropdown<String>(
                    label: "Select Day of Week",
                    value: selectedDayOfWeek,
                    items: daysOfWeek,
                    onChanged: (value) {
                      setState(() {
                        selectedDayOfWeek = value;
                      });
                    },
                  ),

                  _styledDropdown<String>(
                    label: "Select Month",
                    value: selectedMonth,
                    items: monthDays.keys.toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value;
                        selectedDayNumber = null;
                      });
                    },
                  ),

                  if (selectedMonth != null)
                    _styledDropdown<int>(
                      label: "Select Day of Month",
                      value: selectedDayNumber,
                      items: getDaysForSelectedMonth(),
                      onChanged: (value) {
                        setState(() {
                          selectedDayNumber = value;
                        });
                      },
                    ),

                  const SizedBox(height: 16),

                  GestureDetector(
                    onTap: _pickTime,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 14),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4)
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedTime == null
                                ? 'Select Time'
                                : 'Time: ${selectedTime!.format(context)}',
                            style: textTheme.bodySmall?.copyWith(fontSize: 18),
                          ),
                          const Icon(Icons.access_time,
                              color: AppColors.primary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addAppointment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Add Appointment',
                        style: TextStyle(fontSize: 20,),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (availableAppointments.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📅 Added Appointments:',
                          style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        ...availableAppointments.map(
                          (appt) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 3)
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    size: 22, color: AppColors.primary),
                                const SizedBox(width: 10),
                                Text(
                                  '${appt['day']} - ${appt['date']} ${appt['month']} - ${appt['time']}',
                                  style:
                                      textTheme.bodyMedium?.copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      'No appointments added yet',
                      style: textTheme.bodyMedium?.copyWith(fontSize: 16),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _styledDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
          border: InputBorder.none,
        ),
        value: value,
        items: items
            .map((item) =>
                DropdownMenuItem(value: item, child: Text(item.toString())))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
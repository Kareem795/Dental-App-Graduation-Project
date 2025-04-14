import 'package:dental_app_graduation_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AddAvailableAppointmentsScreen extends StatefulWidget {
  const AddAvailableAppointmentsScreen({super.key});

  static const String route_name = "Add_Available_Appointments_Screen";

  @override
  State<AddAvailableAppointmentsScreen> createState() => _AddAvailableAppointmentsScreenState();
}

class _AddAvailableAppointmentsScreenState extends State<AddAvailableAppointmentsScreen> {
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

  void _addAppointment() {
    if (selectedDayOfWeek != null &&
        selectedMonth != null &&
        selectedDayNumber != null &&
        selectedTime != null) {
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
        const SnackBar(
            content: Text('Please select day, month, date, and time')),
      );
    }
  }

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
            // title: const Text("Select Time"),
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
                    const Text(
                      "Add Doctor Schedule",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold ,),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Select available days and times to add doctor appointments",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    // Day of the week
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

                    // Month
                    _styledDropdown<String>(
                      label: "Select Month",
                      value: selectedMonth,
                      items: monthDays.keys.toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value;
                          selectedDayNumber = null; // Reset date
                        });
                      },
                    ),

                    // Day number
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

                    // Time picker
                    GestureDetector(
                      onTap: _pickTime,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                              style: TextStyle(
                                  color: selectedTime == null
                                      ? Colors.grey[600]
                                      : Colors.black),
                            ),
                            const Icon(Icons.access_time , color: AppColors.primary,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Add button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _addAppointment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Add Appointment',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Appointments list
                    if (availableAppointments.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '📅 Added Appointments:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          ...availableAppointments.map(
                            (appt) => Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 3)
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      size: 20, color: AppColors.primary),
                                  const SizedBox(width: 10),
                                  Text(
                                      '${appt['day']} - ${appt['date']} ${appt['month']} - ${appt['time']}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      const Text(
                        'No appointments added yet',
                        style: TextStyle(color: Colors.black),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
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

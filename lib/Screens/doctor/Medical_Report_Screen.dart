import 'package:dental_app_graduation_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MedicalReportScreen extends StatelessWidget {
  static const String route_name = "Medical Report Screen";
  const MedicalReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
                Colors.blue.shade50,
                Colors.white,
                AppColors.primary,
              ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/illustration.png',
                  height: 170), // Medical icon
              const SizedBox(height: 20),
              const Text(
                "Add a medical record.",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "A detailed health history helps a doctor diagnose you better.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddRecordScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Add a record",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  String name = "Fares Ahmed";
  String selectedRecordType = "Prescription";
  DateTime selectedDate = DateTime.now();

  void _editName() {
    TextEditingController controller = TextEditingController(text: name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter Name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                name = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
                Colors.blue.shade50,
                Colors.white,
                AppColors.primary,
              ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Add Records", style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/kareem.jpg")),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary,
                      ),
                      child: const Icon(Icons.add, size: 40, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text("Record for"),
                        subtitle: Text(name,
                            style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold)),
                        trailing: IconButton(
                            icon: const Icon(Icons.edit), onPressed: _editName),
                      ),
                      const Divider(),
                      const Text("Type of record"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //!
                          _buildRecordTypeOption(
                              "Report", Icons.insert_drive_file),
                          _buildRecordTypeOption(
                              "Prescription", Icons.local_hospital),
                          _buildRecordTypeOption("Invoice", Icons.receipt),
                        ],
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text("Record created on"),
                        subtitle: Text(
                            "${selectedDate.day} ${_monthName(selectedDate.month)}, ${selectedDate.year}",
                            style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold)),
                        trailing: IconButton(
                            icon: const Icon(Icons.edit), onPressed: _selectDate),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
      
              //! Botton
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Upload record",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //!   Icons
  Widget _buildRecordTypeOption(String type, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRecordType = type;
        });
      },
      child: Column(
        //! Icon on the top the word in the bottom
        children: [
          Icon(icon,
              color: selectedRecordType == type ? AppColors.primary : Colors.grey,
              size: 30),
          const SizedBox(height: 5),
          Text(type,
              style: TextStyle(
                  color:
                      selectedRecordType == type ? AppColors.primary : Colors.grey)),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }
}

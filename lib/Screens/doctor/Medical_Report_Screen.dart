import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Widgets/Background/Gradient_Background_Wrapper.dart';
import 'package:flutter/material.dart';

class MedicalReportScreen extends StatelessWidget {
  static const String route_name = "Medical Report Screen";
  const MedicalReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffoldWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppAssets.Illustration, height: 170),
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
                      builder: (context) => const AddRecordScreen(),
                    ),
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
                child: Text(
                  "Add a record",
                  style: const TextStyle(fontSize: 16).copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
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
  return GradientScaffoldWrapper(
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add Records", style: TextStyle(fontSize: 20)),
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
                  backgroundImage: AssetImage(AppAssets.Kemo),
                ),
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
                    child: const Icon(Icons.add, size: 32), // أصغر من 40
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text("Record for", style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                        name,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: _editName,
                      ),
                    ),
                    const Divider(),
                    const Text("Type of record", style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildRecordTypeOption("Report", Icons.insert_drive_file),
                        _buildRecordTypeOption("Prescription", Icons.local_hospital),
                        _buildRecordTypeOption("Invoice", Icons.receipt),
                      ],
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Record created on", style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                        "${selectedDate.day} ${_monthName(selectedDate.month)}, ${selectedDate.year}",
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: _selectDate,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Upload record",
                style: const TextStyle(fontSize: 20, color: Colors.white).copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
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
              color:
                  selectedRecordType == type ? AppColors.primary : Colors.grey,
              size: 30),
          const SizedBox(height: 5),
          Text(type,
              style: TextStyle(
                  color: selectedRecordType == type
                      ? AppColors.primary
                      : Colors.grey)),
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

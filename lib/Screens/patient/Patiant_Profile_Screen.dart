import 'package:dental_app_graduation_project/Utils/Constants/app_assets.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:dental_app_graduation_project/Utils/Constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatiantProfileScreen extends StatefulWidget {
  static const String route_name = "Patiant Profile Screen";

  const PatiantProfileScreen({super.key});

  @override
  _PatiantProfileScreenState createState() => _PatiantProfileScreenState();
}

class _PatiantProfileScreenState extends State<PatiantProfileScreen> {
  String name = "Kareem Yasser Atef";
  String phone = "+8801800000000";
  String dob = "DD MM YYYY";
  String location = "Add Details";

  Future<void> updateProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('User ID not found. Please log in again.')),
        );
        return;
      }

      final dio = Dio();
      final response = await dio.post(
        '${AppConstants.URL}/api/profile/update',
        data: {
          'user_id': userId,
          'name': name,
          'contact_number': phone,
          'date_of_birth': dob,
          'location': location,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } else if (response.statusCode == 302) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Redirect detected. Are you logged in?')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
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
              backgroundColor: AppColors.primary,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: const Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(AppAssets.Kemo),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Icon(
                                Icons.camera_alt,
                                size: 25,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Set up your profile',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Update your profile to connect your doctor with better impression.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        buildTextField('Name', name,
                            (value) => setState(() => name = value), context),
                        buildTextField('Contact Number', phone,
                            (value) => setState(() => phone = value), context),
                        buildTextField('Date of Birth', dob,
                            (value) => setState(() => dob = value), context),
                        buildTextField(
                            'Location',
                            location,
                            (value) => setState(() => location = value),
                            context),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Continue',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ],
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

  Widget buildTextField(String label, String value, Function(String) onUpdate,
      BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                value.isNotEmpty ? value : ' ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (label == 'Date of Birth') {
                  _pickDate(context, onUpdate);
                } else {
                  _navigateAndUpdateField(context, label, value, onUpdate);
                }
              },
              icon: const Icon(Icons.edit, size: 16, color: AppColors.primary),
              label: const Text(
                'EDIT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context, Function(String) onUpdate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // التاريخ المبدئي
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year, // 🔥 يخلي اختيار السنة أولا
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.year}-${_twoDigits(pickedDate.month)}-${_twoDigits(pickedDate.day)}";
      onUpdate(formattedDate);
    }
  }

// Helper function to ensure two digits (e.g., 01, 02)
  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  void _navigateAndUpdateField(BuildContext context, String fieldName,
      String initialValue, Function(String) onUpdate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFieldScreen(
          fieldName: fieldName,
          initialValue: initialValue,
          onSaved: onUpdate,
        ),
      ),
    );
  }
}

//--------------------- EditFieldScreen تبعك زي ما هو بالظبط -------------------------

class EditFieldScreen extends StatefulWidget {
  final String fieldName;
  final String initialValue;
  final Function(String) onSaved;

  const EditFieldScreen({
    super.key,
    required this.fieldName,
    required this.initialValue,
    required this.onSaved,
  });

  @override
  _EditFieldScreenState createState() => _EditFieldScreenState();
}

class _EditFieldScreenState extends State<EditFieldScreen> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
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
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What is your ${widget.fieldName.toLowerCase()}?",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: true,
                    style: const TextStyle(color: Colors.black),
                    cursorColor: AppColors.primary,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      widget.onSaved(_controller.text);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
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

import 'package:flutter/material.dart';

class ProfileSetupScreen extends StatefulWidget {
  static const String route_name = "Profile Setup Screen";

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String name = "Kareem Yasser Atef";
  String phone = "+8801800000000";
  String dob = "DD MM YYYY";
  String location = "Add Details";

  //! Profile Screen 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(14, 189, 126, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //! All in this Column
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(14, 189, 126, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70, //! Control size Image
                    backgroundImage: AssetImage(
                        "assets/kareem.jpg"), // Profile Image
                    child: Align(
                      alignment: Alignment
                          .bottomRight, //! Control position camera icon
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20, //! Control size camera icon
                        child: Icon(
                          Icons.camera_alt,
                          size: 25,
                          color: Color.fromRGBO(14, 189, 126, 1),
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
                  buildTextField('Location', location,
                      (value) => setState(() => location = value), context),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(14, 189, 126, 1),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Continue',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String value, Function(String) onUpdate,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          _navigateAndUpdateField(context, label, value, onUpdate);
        },
        child: TextField(
          enabled: false, //! Disable direct editing
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: Icon(
              Icons.edit,
              color: Color.fromRGBO(14, 189, 126, 1),
            ),
          ),
          controller: TextEditingController(text: value),
        ),
      ),
    );
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

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

class EditFieldScreen extends StatefulWidget {
  final String fieldName;
  final String initialValue;
  final Function(String) onSaved;

  const EditFieldScreen({
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

  //! Profile Screen 2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4A6572),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              focusNode: _focusNode, // 🔥 Ensures the keyboard opens
              autofocus: true, // Ensures it gains focus
              style: TextStyle(color: Colors.white),
              cursorColor: Color.fromRGBO(14, 189, 126, 1),
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSaved(_controller.text);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(14, 189, 126, 1),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:dental_app_graduation_project/Utils/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class XrayUploadScreen extends StatefulWidget {
  static const String route_name = "Xray_Upload_Screen";

  @override
  _XrayUploadScreenState createState() => _XrayUploadScreenState();
}

class _XrayUploadScreenState extends State<XrayUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        height: double.infinity,
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
          title: const Text(
            "Xray uploading",
            style: TextStyle(
              // color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // centerTitle: true,
        ),
      
        // خلفية بتدرج لوني
        body: Column(
          children: [
            const SizedBox(height: 30),
        
            // Card أبيض فيه الصورة والأزرار
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // عرض الصورة أو الأيقونة
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 160,
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.image,
                              size: 80,
                              color: AppColors.primary,
                            ),
                          ),
                  ),
        
                  const SizedBox(height: 25),
        
                  // زرار Upload
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,    //! تفير لون الكلمة الى الون الابيض
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Upload", style: TextStyle(fontSize: 16)),
                  ),
        
                  const SizedBox(height: 15),
        
                  // زرار Remove
                  ElevatedButton(
                    onPressed: _image != null ? _removeImage : null,
                    style: ElevatedButton.styleFrom(
                      
                      //! تغير لون زر remove
                      backgroundColor: _image != null ? Colors.red : Colors.grey[300],
                      foregroundColor: _image != null ? Colors.white : Colors.black54,

                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Remove", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

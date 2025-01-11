import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_appd106d1/app_colors.dart';
import 'package:flutter_appd106d1/app_url.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _newImage;

  final imgPicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = sp.getString("USER_NAME") ?? '';
      _fullnameController.text = sp.getString("USER_FULLNAME") ?? '';
      _phoneController.text = sp.getString("USER_PHONE") ?? '';
      _emailController.text = sp.getString("USER_EMAIL") ?? '';
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final sp = await SharedPreferences.getInstance();
    String userId = sp.getInt("USER_ID")!.toString();

    String? imageBase64;
    if (_newImage != null) {
      final bytes = await _newImage!.readAsBytes();
      imageBase64 = base64Encode(bytes);
    }

    var url = Uri.parse("${AppUrl.url}edit_profile.php");
    final response = await http.post(url, body: {
      "UserID": userId,
      "UserName": _usernameController.text,
      "FullName": _fullnameController.text,
      "PhoneNumber": _phoneController.text,
      "UserEmail": _emailController.text,
      if (imageBase64 != null) "NewImageProfile": imageBase64,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        EasyLoading.showSuccess("Profile updated successfully!");
        sp.setString("USER_NAME", _usernameController.text);
        sp.setString("USER_FULLNAME", _fullnameController.text);
        sp.setString("USER_PHONE", _phoneController.text);
        sp.setString("USER_EMAIL", _emailController.text);
        if (data.containsKey("UpdatedFields") &&
            data["UpdatedFields"].contains("UserImage")) {
          sp.setString("USER_IMAGE", data["UpdatedFields"]["UserImage"]);
        }
        Navigator.pop(context);
      } else {
        EasyLoading.showError(data['msg_error'] ?? "Failed to update profile");
      }
    } else {
      EasyLoading.showError("Failed to connect to server");
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _newImage != null
                      ? FileImage(_newImage!)
                      : NetworkImage(
                              '${AppUrl.url}images/${SharedPreferences.getInstance().then((sp) => sp.getString("USER_IMAGE") ?? '')}')
                          as ImageProvider,
                  child: const Icon(Icons.camera_alt, size: 30),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => value == null || value.isEmpty
                    ? "Enter your username"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fullnameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value == null || value.isEmpty
                    ? "Enter your full name"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? "Enter your phone number"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter your email" : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor),
                child: const Text(
                  'Save',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

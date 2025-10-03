import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/api/auth_api.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/util/snackbar_util.dart';
import 'package:mobile_app/util/storage_util.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load user data from backend
    nameController.text = currentUser['name'];
    emailController.text = currentUser['email'];
    phoneController.text = currentUser['phone'];
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  Future<void> saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final result = await AuthApi.updateUserDetails(
        token: currentUserToken,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        profileImage: profileImage,
      );

      print('saveProfile result');
      print(result);

      SnackBarUtil.show(context, result['message']);

      if (result['status'] == 'success') {
        currentUser = result['data'];
        await StorageUtil.saveUser(currentUser);
        NavigationUtil.pushReplacement(context, HomeScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade100,
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : NetworkImage(
                                    '$baseUrl${currentUser['profile_picture']}',
                                  )
                                  as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: pickImage,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: primaryColor,
                            child: Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Name cannot be empty" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) return "Email cannot be empty";
                      if (!value.contains("@")) return "Enter valid email";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      prefixIcon: const Icon(Icons.phone_android_outlined),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.isEmpty ? "Phone cannot be empty" : null,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

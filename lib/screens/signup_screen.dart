import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/screens/login_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';

import '../db/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // or ImageSource.camera
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor = Colors.white;
    final Color lightYellow = Colors.yellow.shade50;

    return Scaffold(
      backgroundColor: _primaryColor,
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Image
                  SizedBox(
                    height: 100,
                    child: Image.asset("assets/logo.webp", fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Profile Picture
                  InkWell(
                    onTap: _pickImage,
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: lightYellow,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? const Icon(
                                Icons.camera_alt,
                                size: 35,
                                color: Colors.black54,
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name
                  _buildTextField("Full Name", Icons.person, lightYellow),
                  const SizedBox(height: 16),

                  // Email
                  _buildTextField("Email", Icons.email, lightYellow),
                  const SizedBox(height: 16),

                  // Password
                  _buildTextField(
                    "Password",
                    Icons.lock,
                    lightYellow,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  _buildTextField(
                    "Confirm Password",
                    Icons.lock_outline,
                    lightYellow,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  _buildTextField(
                    "Phone Number",
                    Icons.phone,
                    lightYellow,
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // handle signup
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to login
                          NavigationUtil.pushReplacement(
                            context,
                            LoginScreen(),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: primaryColorHover2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    IconData icon,
    Color fillColor, {
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      obscureText: isPassword,
      keyboardType: inputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(icon, color: Colors.black54),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

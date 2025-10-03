import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/api/auth_api.dart';
import 'package:mobile_app/screens/login_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/util/snackbar_util.dart';
import 'package:mobile_app/widgets/loading_button.dart';

import '../db/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

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

  void signup() async {
    String? nameError = validateName(nameController.text);
    String? emailError = validateEmail(emailController.text);
    String? passwordError = validatePassword(passwordController.text);
    String? phoneError = validatePhone(phoneController.text);

    if (nameError != null) {
      SnackBarUtil.show(context, nameError);
      return;
    }
    if (emailError != null) {
      SnackBarUtil.show(context, emailError);
      return;
    }
    if (passwordError != null) {
      SnackBarUtil.show(context, passwordError);
      return;
    }
    if (phoneError != null) {
      SnackBarUtil.show(context, phoneError);
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await AuthApi.signupUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        profileImage: _profileImage, // from image picker
      );

      print("Signup response: $response");

      SnackBarUtil.show(context, response["message"]);
      if (response["status"] == 'success') {
        NavigationUtil.pushReplacement(context, LoginScreen());
      }
    } catch (e) {
      SnackBarUtil.show(context, "Signup error: $e");
    } finally {
      setState(() => isLoading = false);
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
                  _buildTextField(
                    "Full Name",
                    Icons.person,
                    nameController,
                    lightYellow,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _buildTextField(
                    "Email",
                    Icons.email,
                    emailController,
                    lightYellow,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  _buildTextField(
                    "Password",
                    Icons.lock,
                    passwordController,
                    lightYellow,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  _buildTextField(
                    "Confirm Password",
                    Icons.lock_outline,
                    passwordController,
                    lightYellow,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  _buildTextField(
                    "Phone Number",
                    Icons.phone,
                    phoneController,
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
                      onPressed: signup,
                      child: isLoading
                          ? LoadingInButton()
                          : const Text(
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
    controller,
    Color fillColor, {
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
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

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return "Name cannot be empty";
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email cannot be empty";
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value.trim())) return "Enter a valid email";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty)
      return "Password cannot be empty";
    if (value.trim().length < 6)
      return "Password must be at least 6 characters";
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return "Phone cannot be empty";
    return null;
  }
}

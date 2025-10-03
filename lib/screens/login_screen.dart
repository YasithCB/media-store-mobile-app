import 'package:flutter/material.dart';
import 'package:mobile_app/screens/forgot_password.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/signup_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/util/snackbar_util.dart';
import 'package:mobile_app/util/storage_util.dart';
import 'package:mobile_app/widgets/loading_button.dart';

import '../api/auth_api.dart';
import '../db/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static Widget _socialButton(String text, Color color, IconData icon) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    String pattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // email regex
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  void login() async {
    String? emailError = validateEmail(emailController.text);
    String? passwordError = validatePassword(passwordController.text);

    if (emailError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(emailError)));
      return;
    }

    if (passwordError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(passwordError)));
      return;
    }

    setState(() => isLoading = true);

    try {
      final res = await AuthApi.loginUser(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (res["status"] == 'success' && res["data"]['token'] != null) {
        currentUserToken = res["data"]['token'];
        currentUser = res["data"]['user'];
        print(currentUser);
        print('currentUser');
        await StorageUtil.saveUser(currentUser);
        await StorageUtil.saveToken(currentUserToken);

        NavigationUtil.pushReplacement(context, HomeScreen());
        SnackBarUtil.show(context, "Login successful");
      } else {
        SnackBarUtil.show(
          context,
          res["message"] ?? "Login failed, check credentials",
        );
      }
    } catch (e) {
      SnackBarUtil.show(context, "Login error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor = Colors.white; // replace with your primary color
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
                    height: 150,
                    child: Image.asset(
                      "assets/images/view/robot-with-logo.webp",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightYellow,
                      prefixIcon: const Icon(
                        Icons.alternate_email,
                        color: Colors.black54,
                        size: 20,
                      ),
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.black54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black54,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightYellow,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black54,
                        size: 20,
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.black54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black54,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        NavigationUtil.push(context, ForgotPasswordScreen());
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
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
                      onPressed: login,
                      child: isLoading
                          ? LoadingInButton()
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Divider with text
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.black)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "- or continue with -",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.all(3), // space for border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black12, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              "assets/images/icons/google.webp",
                              height: 25,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Facebook
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black12, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.facebook,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Are you new to MediaStore? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to signup
                          NavigationUtil.pushReplacement(
                            context,
                            SignupScreen(),
                          );
                        },
                        child: Text(
                          "Sign Up",
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
}

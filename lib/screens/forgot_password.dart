import 'package:flutter/material.dart';
import 'package:mobile_app/api/auth_api.dart';
import 'package:mobile_app/screens/login_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/util/snackbar_util.dart';
import 'package:mobile_app/widgets/loading_button.dart';

import '../db/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final Color lightYellow = Colors.yellow.shade50;
  bool isOtpSent = false;
  bool isOtpVerified = false;
  bool isLoading = false;
  String resetToken = '';

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _otpTextController = TextEditingController();
  final TextEditingController _newPasswordTextController =
      TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  forgotPasswordFlow() async {
    setState(() {
      isLoading = true;
    });

    if (isOtpVerified) {
      // Step 3: Reset Password
      final resetResponse = await AuthApi.resetPassword(
        resetToken,
        _newPasswordTextController.text.trim(),
      );
      if (resetResponse["status"] == "success") {
        SnackBarUtil.show(context, resetResponse["message"]);
        NavigationUtil.pushReplacement(context, LoginScreen());
      } else {
        SnackBarUtil.show(context, resetResponse["message"]);
      }
      print("Reset Password Response: $resetResponse");
    } else if (!isOtpSent) {
      // Step 1: Request OTP
      final otpResponse = await AuthApi.forgotPassword(
        _emailTextController.text.trim(),
      );
      print("OTP Response: $otpResponse");

      if (otpResponse["status"] == "success") {
        SnackBarUtil.show(context, otpResponse["message"]);
        setState(() {
          isOtpSent = true;
        });
      } else {
        SnackBarUtil.show(context, otpResponse["message"]);
        setState(() {
          isLoading = false;
        });
        return;
      }
    } else {
      // Step 2: Verify OTP
      final verifyResponse = await AuthApi.verifyOtp(
        _emailTextController.text.trim(),
        _otpTextController.text.trim(),
      );
      print("Verify OTP Response: $verifyResponse");

      if (verifyResponse["status"] == "success") {
        setState(() {
          isOtpVerified = true;
        });
        SnackBarUtil.show(context, verifyResponse["message"]);
      } else {
        SnackBarUtil.show(context, verifyResponse["message"]);
        setState(() {
          isLoading = false;
        });
        return;
      }

      resetToken = verifyResponse["data"]["resetToken"];
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              SizedBox(
                height: 150,
                child: Image.asset(
                  "assets/images/view/password-vector.webp",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Email
              _buildTextField(
                "Email",
                Icons.alternate_email,
                lightYellow,
                controller: _emailTextController,
              ),
              const SizedBox(height: 16),

              // OTP
              isOtpSent
                  ? _buildTextField(
                      "Enter OTP",
                      Icons.security,
                      lightYellow,
                      controller: _otpTextController,
                    )
                  : SizedBox(),
              const SizedBox(height: 16),

              // New Password
              isOtpVerified
                  ? _buildTextField(
                      "New Password",
                      Icons.lock_outline,
                      lightYellow,
                      isPassword: true,
                      controller: _newPasswordTextController,
                    )
                  : SizedBox(),
              const SizedBox(height: 16),

              // Req Reset Password
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
                  onPressed: forgotPasswordFlow,
                  child: isLoading
                      ? LoadingInButton()
                      : Text(
                          isOtpVerified
                              ? 'Change Password'
                              : isOtpSent
                              ? "Submit"
                              : "Send OTP",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
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
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(icon, color: Colors.black54, size: 20),
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

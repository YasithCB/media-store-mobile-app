import 'package:flutter/material.dart';
import 'package:mobile_app/screens/forgot_password.dart';
import 'package:mobile_app/util/navigation_util.dart';

import '../../db/constants.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  void editPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Password"),
        content: const Text("Password change functionality goes here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Add password change logic
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Security",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(height: 1, color: Colors.black12),

            // Email row
            ListTile(
              leading: const Icon(Icons.alternate_email),
              title: const Text("Email"),
              subtitle: Text(currentUser['email']),
            ),

            const Divider(height: 1, color: Colors.black12),

            // Password row with Edit button
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text("Password"),
              subtitle: Text("••••••••"),
              trailing: InkWell(
                onTap: () {
                  NavigationUtil.pushReplacement(
                    context,
                    ForgotPasswordScreen(),
                  );
                },
                child: const Icon(Icons.edit),
              ),
            ),
            const Divider(height: 1, color: Colors.black12),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../db/constants.dart';

class Tab3 extends StatelessWidget {
  const Tab3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tab 3"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 80, color: primaryColor),
            SizedBox(height: 16),
            Text(
              "Welcome to Tab 3",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "This is just a placeholder screen.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

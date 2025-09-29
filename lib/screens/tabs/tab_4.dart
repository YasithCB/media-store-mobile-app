import 'package:flutter/material.dart';

class Tab4 extends StatelessWidget {
  const Tab4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tab 4"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.home, size: 80, color: Colors.pink),
            SizedBox(height: 16),
            Text(
              "Welcome to Tab 4",
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

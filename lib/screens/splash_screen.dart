import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/get_started_screen.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';

import '../db/constants.dart';
import '../util/storage_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _checkUserData();

    // 🔹 Setup animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // fade duration
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  Future<void> _checkUserData() async {
    currentUser = await StorageUtil.getUser() ?? {};

    if (kDebugMode) {
      print('::::::::::::::::::::::::::: USER :::::::::::::::::::::::::::');
      print(currentUser);
    }

    await Future.delayed(const Duration(seconds: 2)); // splash delay

    if (currentUser.isEmpty) {
      NavigationUtil.pushReplacement(context, GetStartedScreen());
    } else {
      NavigationUtil.pushReplacement(context, HomeScreen());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SizedBox(width: 170, child: Image.asset("assets/logo.webp")),
        ),
      ),
    );
  }
}

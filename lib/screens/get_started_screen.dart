import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';

import '../db/constants.dart';

class GetStartedScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String tagline;
  final VoidCallback? onGetStarted;

  const GetStartedScreen({
    super.key,
    this.imagePath = 'assets/images/get-started.webp',
    this.title = 'Welcome to Media Store',
    this.tagline =
        'All-in-one solutions for branding, printing, and advertising—creative impact under one roof.',
    this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    // make status icons visible on dark background
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full-screen image
          Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),

          // Gradient overlay: transparent at top -> dark by 80% -> slightly darker at bottom
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.8, 1.0],
                  colors: [
                    Colors.transparent, // top (0%)
                    Color.fromARGB(160, 0, 0, 0), // ~60% opacity black at 80%
                    Color.fromARGB(220, 0, 0, 0), // almost solid at very bottom
                  ],
                ),
              ),
            ),
          ),

          // Content at bottom
          SafeArea(
            child: Column(
              children: [
                // spacer to push content to bottom
                const Expanded(child: SizedBox.shrink()),

                // Bottom content container
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.05,
                        ),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        tagline,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Get Started button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed:
                              onGetStarted ??
                              () {
                                NavigationUtil.pushReplacement(
                                  context,
                                  HomeScreen(),
                                );
                              },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColorLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 6,
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VAL Graphics',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: primaryColorHover),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(primary: primaryColor),
        useMaterial3: true,
      ),
      // themeMode: ThemeMode.system, // 🔹 follow system setting (light/dark)
      themeMode: ThemeMode.light, // 🔹 follow system setting (light/dark)
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

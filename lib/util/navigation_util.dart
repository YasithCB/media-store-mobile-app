import 'package:flutter/material.dart';

class NavigationUtil {
  static Future<T?> push<T>(BuildContext context, Widget screen) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Future<T?> pushReplacement<T>(BuildContext context, Widget screen) {
    return Navigator.pushReplacement<T, T>(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Future<T?> pushAndRemoveUntil<T>(BuildContext context, Widget screen) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false, // removes all previous routes
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }
}

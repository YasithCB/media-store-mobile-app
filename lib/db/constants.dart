import 'package:flutter/material.dart';

final Color primaryColorLight = const Color(0xFFFFC107);
final Color primaryColor = const Color(0xFFF9A61B);
final Color primaryColor5 = Color(0x12FFCF00);
final Color primaryColor20 = Color(0x33FFCF00);
final Color primaryColor50 = Color(0x80FFCF00);
final Color primaryColorHover = Color(0xFFC17A0C);
final Color primaryColorHover2 = Color(0xFF785C00);

// 📏 Get device width & height
double deviceWidth = 0;
double deviceHeight = 0;

const String baseUrl = "http://192.168.100.120:5000";

Map<String, dynamic> currentUser = {};
String currentUserToken = '';

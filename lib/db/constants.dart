import 'package:flutter/material.dart';

final Color primaryColor = Color(0xFFFFE700);
final Color primaryColor5 = Color(0x12FFEB3B);
final Color primaryColor20 = Color(0x33FFEB3B);
final Color primaryColor50 = Color(0x80FFEB3B);
final Color primaryColorHover = Color(0xFFC3B006);
final Color primaryColorHover2 = Color(0xFFC19C06);

// 📏 Get device width & height
double deviceWidth = 0;
double deviceHeight = 0;

const String baseUrl = "http://192.168.100.120:3000";

Map<String, dynamic> currentUser = {};
String currentUserToken = '';

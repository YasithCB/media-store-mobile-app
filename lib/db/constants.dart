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

late Map<String, dynamic> currentUser;
String currentUserToken = '';

// ad post data
String post_country = '';
String post_emirate = '';
int post_category_id = -1;
String post_category_title = '';
int post_subcategory_id = -1;
String post_subcategory_title = '';

List<String> usageOptions = [
  "Never used",
  "Used once",
  "Light usage",
  "Normal usage",
  "Heavy usage",
];

List<String> conditionOptions = ["Excellent", "Good", "Average", "Poor"];

List<String> locationOptions = [
  "Dubai",
  "Abu Dhabi",
  "Sharjah",
  "Ajman",
  "Fujairah",
  "Ras Al Khaimah",
  "Umm Al Quwain",
];

// country and states
List<Map<String, dynamic>> countryAndStates = [
  {
    "country": "United Arab Emirates",
    "states": [
      "Abu Dhabi",
      "Dubai",
      "Sharjah",
      "Ajman",
      "Umm Al-Quwain",
      "Ras Al Khaimah",
      "Fujairah",
    ],
  },
  {
    "country": "Saudi Arabia",
    "states": [
      "Riyadh",
      "Makkah",
      "Madinah",
      "Qassim",
      "Eastern Province",
      "Asir",
      "Tabuk",
      "Hail",
      "Northern Borders",
      "Jizan",
      "Najran",
      "Al-Baha",
      "Al-Jouf",
    ],
  },
  {
    "country": "Kuwait",
    "states": [
      "Al Asimah",
      "Hawalli",
      "Farwaniya",
      "Jahra",
      "Mubarak Al-Kabeer",
      "Ahmadi",
    ],
  },
  {
    "country": "Qatar",
    "states": [
      "Doha",
      "Al Rayyan",
      "Al Wakrah",
      "Umm Salal",
      "Al Khor",
      "Al Daayen",
      "Al Shamal",
      "Al Shahaniya",
    ],
  },
  {
    "country": "Bahrain",
    "states": [
      "Capital Governorate",
      "Muharraq",
      "Northern Governorate",
      "Southern Governorate",
    ],
  },
  {
    "country": "Oman",
    "states": [
      "Muscat",
      "Dhofar",
      "Musandam",
      "Al Buraimi",
      "Al Dakhiliyah",
      "Al Batinah North",
      "Al Batinah South",
      "Al Sharqiyah North",
      "Al Sharqiyah South",
      "Ad Dhahirah",
      "Al Wusta",
    ],
  },
];

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../db/constants.dart';

class AuthApi {
  /// Login user
  static Future<Map<String, dynamic>> loginUser(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"), // your login endpoint
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    return data;
  }

  /// Get logged-in user profile
  static Future<Map<String, dynamic>> getUser(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/auth/user"), // your get user endpoint
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // auth token header
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error ${response.statusCode}: ${response.reasonPhrase}");
    }
  }

  static Future<Map<String, dynamic>> signupUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    File? profileImage,
  }) async {
    try {
      var uri = Uri.parse("${baseUrl}/auth/register");
      var request = http.MultipartRequest("POST", uri);

      // add text fields
      request.fields.addAll({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      });

      // add image if provided
      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "profile_picture",
            profileImage.path,
            contentType: MediaType("image", "jpeg"),
          ),
        );
      }

      // send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {"success": false, "statusCode": 500, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> updateUserDetails({
    required String token,
    required String name,
    required String email,
    required String phone,
    File? profileImage, // optional image
  }) async {
    final url = Uri.parse("$baseUrl/auth/profile");

    var request = http.MultipartRequest("PUT", url);

    // Add auth header
    request.headers["Authorization"] = "Bearer $token";

    // Add text fields
    request.fields["user_id"] = currentUser['user_id'].toString();
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["phone"] = phone;

    // Add image if provided
    if (profileImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "profile_picture",
          profileImage.path,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }

    // Send request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = Uri.parse("$baseUrl/auth/forgot-password");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> verifyOtp(
    String email,
    String otp,
  ) async {
    final url = Uri.parse("$baseUrl/auth/verify-otp");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "otp": otp}),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> resetPassword(
    String token,
    String newPassword,
  ) async {
    final url = Uri.parse("$baseUrl/auth/reset-password");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": token, "newPassword": newPassword}),
    );

    return jsonDecode(response.body);
  }
}

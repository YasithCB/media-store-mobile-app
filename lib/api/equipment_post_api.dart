import 'dart:convert';

import 'package:http/http.dart' as http;

import '../db/constants.dart';
import '../models/equipment_post_model.dart';

class EquipmentPostApi {
  /// Create Equipment Post
  static Future<void> createEquipmentPost(Map<String, dynamic> postData) async {
    final url = Uri.parse("$baseUrl/equipment-posts");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postData),
    );

    if (response.statusCode == 201) {
      print("✅ Equipment post created successfully");
    } else {
      print("❌ Failed to create equipment post: ${response.body}");
    }
  }

  /// Get All Equipment Posts
  static Future<List<EquipmentPostModel>> getAllEquipmentPosts() async {
    final url = Uri.parse("$baseUrl/equipment-posts");

    final response = await http.get(url);

    print('response.body');
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List postsJson = data['data'] ?? data;
      return postsJson
          .map((json) => EquipmentPostModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load all equipment posts");
    }
  }

  /// Get Equipment Posts by Subcategory
  static Future<List<EquipmentPostModel>> getEquipmentPostsBySubcategory(
    int subcategoryId,
  ) async {
    print('subcategoryId : api layer');
    print(subcategoryId);
    final url = Uri.parse(
      "$baseUrl/equipment-posts/subcategory/$subcategoryId",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List postsJson = data['data'] ?? data;
      return postsJson
          .map((json) => EquipmentPostModel.fromJson(json))
          .toList();
    } else {
      throw Exception(
        "Failed to load equipment posts for subcategory $subcategoryId",
      );
    }
  }
}

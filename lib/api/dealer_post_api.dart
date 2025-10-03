import 'dart:convert';

import 'package:http/http.dart' as http;

import '../db/constants.dart';
import '../models/dealer_post_model.dart';

class DealerPostApi {
  /// Create Dealer Post
  static Future<void> createDealerPost(Map<String, dynamic> postData) async {
    final url = Uri.parse("$baseUrl/dealer-posts");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postData),
    );

    if (response.statusCode == 201) {
      print("✅ Dealer post created successfully");
    } else {
      throw Exception("❌ Failed to create dealer post: ${response.body}");
    }
  }

  /// GET: All dealer posts
  static Future<List<DealerPostModel>> getAllDealerPosts() async {
    final url = Uri.parse("$baseUrl/dealer-posts");

    final response = await http.get(url);

    print('getAllDealerPosts');
    print(response.body);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // API might wrap data
      final List list = decoded['data'] ?? decoded;

      return list.map((x) => DealerPostModel.fromJson(x)).toList();
    } else {
      throw Exception("❌ Failed to fetch dealer posts: ${response.body}");
    }
  }

  /// GET: Dealer posts by Subcategory
  static Future<List<DealerPostModel>> getDealerPostsBySubcategory(
    int subcategoryId,
  ) async {
    final url = Uri.parse("$baseUrl/dealer-posts/subcategory/$subcategoryId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // API might wrap data
      final List list = decoded['data'] ?? decoded;

      return list.map((x) => DealerPostModel.fromJson(x)).toList();
    } else {
      throw Exception(
        "❌ Failed to fetch dealer posts by subcategory: ${response.body}",
      );
    }
  }

  /// UPDATE: Dealer Post
  static Future<void> updateDealerPost(
    String dealerId,
    Map<String, dynamic> postData,
  ) async {
    final url = Uri.parse("$baseUrl/dealer-posts/$dealerId");

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      print("✅ Dealer post updated successfully");
    } else {
      throw Exception("❌ Failed to update dealer post: ${response.body}");
    }
  }

  /// DELETE: Dealer Post
  static Future<void> deleteDealerPost(String dealerId) async {
    final url = Uri.parse("$baseUrl/dealer-posts/$dealerId");

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print("✅ Dealer post deleted successfully");
    } else {
      throw Exception("❌ Failed to delete dealer post: ${response.body}");
    }
  }
}

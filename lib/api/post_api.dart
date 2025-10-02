import 'dart:convert';

import 'package:http/http.dart' as http;

import '../db/constants.dart';
import '../models/post_model.dart';

class PostApi {
  // Get all posts
  static Future<List<PostModel>> getAllPosts() async {
    final response = await http.get(Uri.parse("$baseUrl/posts"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List postsJson = data['data'];
      return postsJson.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load all posts");
    }
  }

  // Get high rating posts
  static Future<List<PostModel>> getHighRatedPosts() async {
    final response = await http.get(Uri.parse("$baseUrl/posts/topRated"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List postsJson = data['data'];
      return postsJson.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load all posts");
    }
  }

  // Get posts by category ID static
  static Future<List<PostModel>> getPostsByCategory(int categoryId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/posts/category/$categoryId"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List postsJson = data['data'];
      return postsJson.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts by category");
    }
  }

  // Get posts by subcategory ID
  static Future<List<PostModel>> getPostsBySubcategory(
    int subcategoryId,
  ) async {
    print('response.body');
    final response = await http.get(
      Uri.parse("$baseUrl/posts/subcategory/$subcategoryId"),
    );
    print('response.body');
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List postsJson = data['data'];
      return postsJson.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts by subcategory");
    }
  }
}

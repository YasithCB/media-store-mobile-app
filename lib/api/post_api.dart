import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../db/constants.dart';
import '../models/post_model.dart';

class PostApi {
  /// GET all dealer posts for a specific user
  // static Future<List<dynamic>> getPostsByUser(String userId) async {
  //   final url = Uri.parse("$baseUrl/my-post/$userId");
  //
  //   final response = await http.get(url);
  //
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //
  //     if (jsonResponse['status'] == "success") {
  //       final List postsJson = jsonResponse['data'];
  //       return postsJson.map((post) => DealerPostModel.fromJson(post)).toList();
  //     } else {
  //       throw Exception("Failed to load posts: ${jsonResponse['message']}");
  //     }
  //   } else {
  //     throw Exception("Failed to load posts: ${response.body}");
  //   }
  // }

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
    final response = await http.get(
      Uri.parse("$baseUrl/posts/subcategory/$subcategoryId"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List postsJson = data['data'];
      return postsJson.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts by subcategory");
    }
  }

  static Future<Map<String, dynamic>> createDealerPost(
    Map<String, dynamic> data, {
    File? logo,
    List<File>? photos,
    required List<String> servicesList,
    required List<String> tagsList,
  }) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/dealer-posts/"),
    );

    request.fields['services'] = jsonEncode(servicesList);
    request.fields['tags'] = jsonEncode(tagsList);

    // Add fields
    data.forEach((key, value) {
      if (value != null) request.fields[key] = value.toString();
    });

    // Add logo
    if (logo != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "logo",
          logo.path,
          contentType: MediaType("image", "jpeg"), // <-- explicit MIME type
        ),
      );
    }

    // Add photos
    if (photos != null && photos.isNotEmpty) {
      for (var photo in photos) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "photos",
            photo.path,
            contentType: MediaType("image", "jpeg"), // <-- explicit MIME type
          ),
        );
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      return {
        "status": "error",
        "code": response.statusCode,
        "message": response.body,
      };
    }
  }
}

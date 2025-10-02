import 'dart:convert';

import 'package:http/http.dart' as http;

import '../db/constants.dart';
import '../models/job_post_model.dart';

class JobPostApi {
  static const String endpoint = "$baseUrl/job-posts";

  /// GET: All job posts
  static Future<List<JobPostModel>> getAllJobPosts() async {
    final url = Uri.parse(endpoint);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // ✅ Ensure data is a list
      final data = decoded['data'] as List<dynamic>;

      return data.map((x) => JobPostModel.fromJson(x)).toList();
    } else {
      throw Exception("Failed to fetch job posts: ${response.body}");
    }
  }

  /// GET: Job posts by subcategory ID
  static Future<List<JobPostModel>> getJobPostsBySubcategoryId(
    int subcategoryId,
  ) async {
    final url = Uri.parse("$endpoint/subcategory/$subcategoryId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // ✅ Ensure data is a list
      final data = decoded['data'] as List<dynamic>;

      return data.map((x) => JobPostModel.fromJson(x)).toList();
    } else {
      throw Exception(
        "Failed to fetch job posts by subcategory: ${response.body}",
      );
    }
  }

  /// POST: Create a job post
  static Future<void> createJobPost(Map<String, dynamic> postData) async {
    final url = Uri.parse(endpoint);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postData),
    );

    if (response.statusCode == 201) {
      print("✅ Job post created successfully");
    } else {
      print("❌ Failed to create job post: ${response.body}");
    }
  }

  /// PUT: Update a job post
  static Future<void> updateJobPost(
    String postId,
    Map<String, dynamic> postData,
  ) async {
    final url = Uri.parse("$endpoint/$postId");

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      print("✅ Job post updated successfully");
    } else {
      print("❌ Failed to update job post: ${response.body}");
    }
  }

  /// DELETE: Remove a job post
  static Future<void> deleteJobPost(String postId) async {
    final url = Uri.parse("$endpoint/$postId");

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print("✅ Job post deleted successfully");
    } else {
      print("❌ Failed to delete job post: ${response.body}");
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/job_post_data.dart';
import 'package:path/path.dart';

import '../db/constants.dart';

class JobPostApi {
  static const String endpoint = "$baseUrl/job-posts";

  static Future<JobPostData?> getJobPostById(String postId) async {
    final url = Uri.parse("$endpoint/$postId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded['status'] == "success" && decoded['data'] != null) {
        print("Job post data for ID $postId: ${decoded['data']}");
        return JobPostData.fromJson(decoded['data']);
      } else {
        print("No job post found with ID $postId");
        return null;
      }
    } else {
      throw Exception(
        "Failed to fetch job post with ID $postId: ${response.body}",
      );
    }
  }

  /// GET: All job posts
  static Future<List<JobPostData>> getAllJobPosts() async {
    final url = Uri.parse(endpoint);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // ✅ Ensure data is a list
      final data = decoded['data'] as List<dynamic>;

      print('getAllJobPosts');
      print(data);

      return data.map((x) => JobPostData.fromJson(x)).toList();
    } else {
      throw Exception("Failed to fetch job posts: ${response.body}");
    }
  }

  /// GET: Job posts by subcategory ID
  static Future<List<JobPostData>> getJobPostsBySubcategoryId(
    int subcategoryId,
  ) async {
    final url = Uri.parse("$endpoint/subcategory/$subcategoryId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // ✅ Ensure data is a list
      final data = decoded['data'] as List<dynamic>;

      return data.map((x) => JobPostData.fromJson(x)).toList();
    } else {
      throw Exception(
        "Failed to fetch job posts by subcategory: ${response.body}",
      );
    }
  }

  static Future<bool> createJobPost({
    required String title,
    required String companyName,
    String? logo, // this will be a file path
    String? location,
    String? country,
    String? jobType,
    String? industry,
    String? experienceLevel,
    String? salary,
    String? salaryType,
    String? description,
    DateTime? expiryDate,
    String? email,
    String? phone,
    String? applicationUrl,
    bool remote = false,
    bool isHiring = true,
    List<String>? tags,
    required int categoryId,
    required int subcategoryId,
  }) async {
    final uri = Uri.parse(endpoint);

    var request = http.MultipartRequest("POST", uri);

    // Add text fields
    request.fields.addAll({
      "title": title,
      "company_name": companyName,
      "location": location ?? "",
      "country": country ?? "",
      "job_type": jobType ?? "",
      "industry": industry ?? "",
      "experience_level": experienceLevel ?? "",
      "salary": salary ?? "",
      "salary_type": salaryType ?? "",
      "description": description ?? "",
      "expiry_date": expiryDate?.toIso8601String() ?? "",
      "email": email ?? "",
      "phone": phone ?? "",
      "application_url": applicationUrl ?? "",
      "remote": remote ? "1" : "0",
      "is_hiring": isHiring ? "1" : "0",
      "tags": tags != null ? tags.join(",") : "",
      "category_id": categoryId.toString(),
      "subcategory_id": subcategoryId.toString(),
    });

    // Add file
    if (logo != null && logo.isNotEmpty && File(logo).existsSync()) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "logo",
          logo,
          filename: basename(logo),
        ),
      );
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print("Error: ${response.statusCode}");
        print(response.body);
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
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

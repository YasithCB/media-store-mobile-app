import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/models/equipment_post_data.dart';
import 'package:path/path.dart';

import '../db/constants.dart';

class EquipmentPostApi {
  static Future<EquipmentPostData?> getEquipmentPostById(String postId) async {
    print('Fetching equipment post by ID: $postId');

    final url = Uri.parse("$baseUrl/equipment-posts/$postId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == "success" && data['data'] != null) {
        return EquipmentPostData.fromJson(data['data']);
      } else {
        print("No data found for ID: $postId");
        return null;
      }
    } else {
      throw Exception("Failed to load equipment post with ID $postId");
    }
  }

  static Future<bool> createEquipmentPost({
    required String title,
    required String contact,
    String? price,
    String description = '',
    String? brand,
    String? model,
    String? usage,
    String? itemCondition,
    String? addressLine1,
    String? addressLine2,
    String? country,
    String? city,
    String? location,
    required int categoryId,
    required int subcategoryId,
    List<File>? photos,
  }) async {
    try {
      print("=== createEquipmentPost START ===");

      print("Base URL: $baseUrl");
      var uri = Uri.parse("$baseUrl/equipment-posts");
      print("POST URI: $uri");

      var request = http.MultipartRequest("POST", uri);

      print("Adding text fields...");
      request.fields['title'] = title;
      request.fields['contact'] = contact;
      if (price != null) request.fields['price'] = price;
      request.fields['description'] = description;
      if (brand != null) request.fields['brand'] = brand;
      if (model != null) request.fields['model'] = model;
      if (usage != null) request.fields['usage'] = usage;
      if (itemCondition != null)
        request.fields['item_condition'] = itemCondition;
      if (addressLine1 != null) request.fields['address_line1'] = addressLine1;
      if (addressLine2 != null) request.fields['address_line2'] = addressLine2;
      if (country != null) request.fields['country'] = country;
      if (city != null) request.fields['city'] = city;
      if (location != null) request.fields['location'] = location;
      request.fields['category_id'] = categoryId.toString();
      request.fields['subcategory_id'] = subcategoryId.toString();

      print("Fields added: ${request.fields}");

      if (photos != null && photos.isNotEmpty) {
        print("Adding ${photos.length} photos...");
        for (var photo in photos) {
          print("Photo path: ${photo.path}");
          if (photo.path.isEmpty) {
            print("⚠️ Warning: photo.path is null or empty");
            continue;
          }
          request.files.add(
            await http.MultipartFile.fromPath(
              'photos',
              photo.path,
              filename: basename(photo.path),
            ),
          );
          print("Added photo: ${basename(photo.path)}");
        }
      } else {
        print("No photos to add.");
      }

      print("Sending request...");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      print("=== createEquipmentPost END ===");

      return response.statusCode == 201;
    } catch (e, stacktrace) {
      print("Exception in createEquipmentPost: $e");
      print(stacktrace);
      return false;
    }
  }

  /// Get All Equipment Posts
  static Future<List<EquipmentPostData>> getAllEquipmentPosts() async {
    final url = Uri.parse("$baseUrl/equipment-posts");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List postsJson = data['data'] ?? data;
      return postsJson.map((json) => EquipmentPostData.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load all equipment posts");
    }
  }

  /// Get Equipment Posts by Subcategory
  static Future<List<EquipmentPostData>> getEquipmentPostsBySubcategory(
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
      return postsJson.map((json) => EquipmentPostData.fromJson(json)).toList();
    } else {
      throw Exception(
        "Failed to load equipment posts for subcategory $subcategoryId",
      );
    }
  }
}

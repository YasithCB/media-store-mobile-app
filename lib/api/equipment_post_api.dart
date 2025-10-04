import 'dart:convert';

import 'package:http/http.dart' as http;

import '../db/constants.dart';
import '../models/equipment_post_model.dart';

class EquipmentPostApi {
  static Future<Map<String, dynamic>> createEquipmentPost({
    required String title,
    required String contact,
    required int categoryId,
    required int subcategoryId,
    String? price,
    String? description,
    String? brand,
    String? model,
    String? usage,
    String? itemCondition,
    String? address1,
    String? address2,
    String? city,
    String? country,
    String? location,
    List<String>? imagePaths,
  }) async {
    var uri = Uri.parse("$baseUrl/equipment-posts");
    var request = http.MultipartRequest("POST", uri);

    request.fields['title'] = title;
    request.fields['contact'] = contact;
    request.fields['category_id'] = categoryId.toString();
    request.fields['subcategory_id'] = subcategoryId.toString();
    if (price != null) request.fields['price'] = price;
    if (description != null) request.fields['description'] = description;
    if (brand != null) request.fields['brand'] = brand;
    if (model != null) request.fields['model'] = model;
    if (usage != null) request.fields['usage'] = usage;
    if (itemCondition != null) request.fields['item_condition'] = itemCondition;
    if (address1 != null) request.fields['address_line1'] = address1;
    if (address2 != null) request.fields['address_line2'] = address2;
    if (city != null) request.fields['city'] = city;
    if (country != null) request.fields['country'] = country;
    if (location != null) request.fields['location'] = location;

    if (imagePaths != null) {
      for (var path in imagePaths) {
        request.files.add(await http.MultipartFile.fromPath("photos", path));
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

  /// Get All Equipment Posts
  static Future<List<EquipmentPostModel>> getAllEquipmentPosts() async {
    final url = Uri.parse("$baseUrl/equipment-posts");

    final response = await http.get(url);

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

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../db/constants.dart';
import '../models/category_model.dart';

class CategoryApi {
  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final categories = data['data'] as List;
      return categories.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }
}

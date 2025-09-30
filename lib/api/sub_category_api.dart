import 'dart:convert';

import 'package:http/http.dart' as http;

import '../db/constants.dart';
import '../models/sub_category_model.dart';

class SubCategoryApi {
  static Future<List<Subcategory>> getSubcategoriesByCategoryId(
    int categoryId,
  ) async {
    final response = await http.get(
      Uri.parse("$baseUrl/subcategories/category/$categoryId"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List subcategoriesJson = data['data'];
      return subcategoriesJson
          .map((json) => Subcategory.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load subcategories");
    }
  }
}

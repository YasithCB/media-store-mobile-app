import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../db/constants.dart';
import '../models/dealer_post_data.dart';

class DealerPostApi {
  /// Create Dealer Post
  static Future<Map<String, dynamic>> createDealerPost(
    DealerPostData dealer,
  ) async {
    final uri = Uri.parse('$baseUrl/dealer-posts');
    final request = http.MultipartRequest('POST', uri);

    try {
      // Add text fields
      request.fields['name'] = dealer.title ?? '';
      request.fields['description'] = dealer.description ?? '';
      request.fields['email'] = dealer.email ?? '';
      request.fields['phone'] = dealer.phone ?? '';
      request.fields['whatsapp'] = dealer.whatsapp ?? '';
      request.fields['website_url'] = dealer.websiteUrl ?? '';
      request.fields['address_line1'] = dealer.addressLine1 ?? '';
      request.fields['address_line2'] = dealer.addressLine2 ?? '';
      request.fields['city'] = post_emirate;
      request.fields['country'] = post_country;
      request.fields['category_id'] = post_category_id.toString();
      request.fields['subcategory_id'] = post_subcategory_id.toString();
      request.fields['services_starting_from'] =
          dealer.servicesStartingFrom ?? '';

      // Convert list/map fields to JSON strings
      if (dealer.services != null) {
        request.fields['services'] = jsonEncode(dealer.services);
      }
      if (dealer.workingHours != null) {
        request.fields['working_hours'] = jsonEncode(dealer.workingHours);
      }
      if (dealer.tags != null) {
        request.fields['tags'] = jsonEncode(dealer.tags);
      }
      if (dealer.locationMap != null) {
        request.fields['location_map'] = jsonEncode(dealer.locationMap);
      }

      if (dealer.logo != null) {
        final mimeType = lookupMimeType(dealer.logo!.path);
        if (mimeType != null) {
          final mimeTypeData = mimeType.split('/');
          request.files.add(
            await http.MultipartFile.fromPath(
              'logo',
              dealer.logo!.path,
              filename: basename(dealer.logo!.path),
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
            ),
          );
        }
      }

      if (dealer.photos.isNotEmpty) {
        for (var photoPath in dealer.photos) {
          final mimeType = lookupMimeType(photoPath);
          if (mimeType != null) {
            final mimeTypeData = mimeType.split('/');
            request.files.add(
              await http.MultipartFile.fromPath(
                'photos',
                photoPath,
                filename: basename(photoPath),
                contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
              ),
            );
          }
        }
      }

      // Send request
      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      print('createDealerPost');
      print(jsonDecode(resBody));

      return jsonDecode(resBody);
    } catch (e) {
      print('Error creating dealer post: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// GET: All dealer posts
  static Future<List<DealerPostData>> getAllDealerPosts() async {
    final url = Uri.parse("$baseUrl/dealer-posts");

    final response = await http.get(url);

    print('getAllDealerPosts');
    print(response.body);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // API might wrap data
      final List list = decoded['data'] ?? decoded;

      return list.map((x) => DealerPostData.fromJson(x)).toList();
    } else {
      throw Exception("❌ Failed to fetch dealer posts: ${response.body}");
    }
  }

  /// GET: Dealer posts by Subcategory
  static Future<List<DealerPostData>> getDealerPostsBySubcategory(
    int subcategoryId,
  ) async {
    final url = Uri.parse("$baseUrl/dealer-posts/subcategory/$subcategoryId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // API might wrap data
      final List list = decoded['data'] ?? decoded;

      return list.map((x) => DealerPostData.fromJson(x)).toList();
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

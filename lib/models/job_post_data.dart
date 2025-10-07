import 'dart:convert';

class JobPostData {
  String title = '';
  String companyName = '';
  String? logoUrl;
  String industry = '';
  int? categoryId;
  int? subcategoryId;
  String jobType = '';
  String experienceLevel = '';
  bool remote = false;
  bool isHiring = true;
  String price = '';
  String salaryType = '';
  String location = '';
  String country = '';
  String description = '';
  List<String> tags = [];
  DateTime? expiryDate;
  DateTime? createdDate;
  String email = '';
  String phone = '';
  String applicationUrl = '';

  JobPostData();

  JobPostData.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    companyName = json['company_name'] ?? '';
    logoUrl = json['logo'];
    industry = json['industry'] ?? '';
    categoryId = json['category_id'] != null
        ? int.tryParse(json['category_id'].toString())
        : null;
    subcategoryId = json['subcategory_id'] != null
        ? int.tryParse(json['subcategory_id'].toString())
        : null;
    jobType = json['job_type'] ?? '';
    experienceLevel = json['experience_level'] ?? '';
    remote =
        json['remote'] != null &&
        (json['remote'] == 1 || json['remote'] == "1");
    isHiring =
        json['is_hiring'] != null &&
        (json['is_hiring'] == 1 || json['is_hiring'] == "1");
    price = json['salary']?.toString() ?? '';
    salaryType = json['salary_type'] ?? '';
    location = json['location'] ?? '';
    country = json['country'] ?? '';
    description = json['description'] ?? '';

    if (json['tags'] != null) {
      try {
        if (json['tags'] is String && json['tags'].isNotEmpty) {
          tags = List<String>.from(jsonDecode(json['tags']));
        } else if (json['tags'] is List) {
          tags = List<String>.from(json['tags']);
        }
      } catch (_) {
        tags = [];
      }
    }

    if (json['expiry_date'] != null &&
        json['expiry_date'].toString().isNotEmpty) {
      try {
        expiryDate = DateTime.parse(json['expiry_date']);
      } catch (_) {
        expiryDate = null;
      }
    } else {
      expiryDate = null;
    }

    if (json['created_at'] != null &&
        json['created_at'].toString().isNotEmpty) {
      try {
        createdDate = DateTime.parse(json['created_at']);
      } catch (_) {
        createdDate = null;
      }
    } else {
      createdDate = null;
    }

    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    applicationUrl = json['application_url'] ?? '';
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'company_name': companyName,
    'logo': logoUrl,
    'industry': industry,
    'category_id': categoryId,
    'subcategory_id': subcategoryId,
    'job_type': jobType,
    'experience_level': experienceLevel,
    'remote': remote ? 1 : 0,
    'is_hiring': isHiring ? 1 : 0,
    'salary': price,
    'salary_type': salaryType,
    'location': location,
    'country': country,
    'description': description,
    'tags': tags,
    'expiry_date': expiryDate?.toIso8601String(),
    'email': email,
    'phone': phone,
    'application_url': applicationUrl,
  };
}

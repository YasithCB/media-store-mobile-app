import 'dart:convert';
import 'dart:io';

class DealerPostData {
  String? postId;
  String? dealerId;
  String? title;
  File? logo;
  List<String> photos;
  String? description;
  int? categoryId;
  int? subcategoryId;
  String? email;
  String? phone;
  String? whatsapp;
  String? websiteUrl;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? country;
  Map<String, dynamic>? locationMap;
  List<String>? services;
  String? servicesStartingFrom;
  Map<String, dynamic>? workingHours;
  int? establishedYear;
  bool featured;
  List<String>? tags;

  DealerPostData({
    this.postId,
    this.dealerId,
    this.title,
    this.logo,
    this.photos = const [],
    this.description,
    this.categoryId,
    this.subcategoryId,
    this.email,
    this.phone,
    this.whatsapp,
    this.websiteUrl,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.country,
    this.locationMap,
    this.services,
    this.servicesStartingFrom,
    this.workingHours,
    this.establishedYear,
    this.featured = false,
    this.tags,
  });

  /// ✅ Create from JSON
  factory DealerPostData.fromJson(Map<String, dynamic> json) {
    return DealerPostData(
      postId: json['post_id'].toString(),
      dealerId: json['dealer_id']?.toString(),
      title: json['name'],
      // Logo could be URL or null — handle accordingly
      logo:
          json['logo'] != null &&
              json['logo'] is String &&
              json['logo'].isNotEmpty
          ? File(json['logo']) // local file
          : null,
      photos: (json['photos'] != null)
          ? List<String>.from(
              json['photos'] is String
                  ? (jsonDecode(json['photos']) as List)
                  : json['photos'],
            )
          : [],
      description: json['description'],
      categoryId: json['category_id'] != null
          ? int.tryParse(json['category_id'].toString())
          : null,
      subcategoryId: json['subcategory_id'] != null
          ? int.tryParse(json['subcategory_id'].toString())
          : null,
      email: json['email'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      websiteUrl: json['website_url'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      country: json['country'],
      locationMap: json['location_map'] is String
          ? jsonDecode(json['location_map'])
          : json['location_map'],
      services: json['services'] != null
          ? (json['services'] is String
                ? List<String>.from(jsonDecode(json['services']))
                : List<String>.from(json['services']))
          : [],
      servicesStartingFrom: json['services_starting_from'],
      workingHours: json['working_hours'] is String
          ? jsonDecode(json['working_hours'])
          : json['working_hours'],
      establishedYear: json['established_year'] != null
          ? int.tryParse(json['established_year'].toString())
          : null,
      featured: json['featured'] == 1 || json['featured'] == true,
      tags: json['tags'] != null
          ? (json['tags'] is String
                ? List<String>.from(jsonDecode(json['tags']))
                : List<String>.from(json['tags']))
          : [],
    );
  }

  /// ✅ Convert to JSON (for API request or local save)
  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'dealer_id': dealerId,
      'name': title,
      'logo': logo?.path,
      'photos': photos,
      'description': description,
      'category_id': categoryId,
      'subcategory_id': subcategoryId,
      'email': email,
      'phone': phone,
      'whatsapp': whatsapp,
      'website_url': websiteUrl,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'city': city,
      'country': country,
      'location_map': locationMap != null ? jsonEncode(locationMap) : null,
      'services': services != null ? jsonEncode(services) : null,
      'services_starting_from': servicesStartingFrom,
      'working_hours': workingHours != null ? jsonEncode(workingHours) : null,
      'established_year': establishedYear,
      'featured': featured ? 1 : 0,
      'tags': tags != null ? jsonEncode(tags) : null,
    };
  }

  /// ✅ Clone & modify
  DealerPostData copyWith({
    required String postId,
    String? dealerId,
    String? title,
    File? logo,
    List<String>? photos,
    String? description,
    int? categoryId,
    int? subcategoryId,
    String? email,
    String? phone,
    String? whatsapp,
    String? websiteUrl,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? country,
    Map<String, dynamic>? locationMap,
    List<String>? services,
    String? servicesStartingFrom,
    Map<String, dynamic>? workingHours,
    int? establishedYear,
    bool? featured,
    List<String>? tags,
  }) {
    return DealerPostData(
      postId: postId ?? this.postId,
      dealerId: dealerId ?? this.dealerId,
      title: title ?? this.title,
      logo: logo ?? this.logo,
      photos: photos ?? this.photos,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      country: country ?? this.country,
      locationMap: locationMap ?? this.locationMap,
      services: services ?? this.services,
      servicesStartingFrom: servicesStartingFrom ?? this.servicesStartingFrom,
      workingHours: workingHours ?? this.workingHours,
      establishedYear: establishedYear ?? this.establishedYear,
      featured: featured ?? this.featured,
      tags: tags ?? this.tags,
    );
  }
}

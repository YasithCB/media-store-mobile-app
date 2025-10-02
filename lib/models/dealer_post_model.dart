import 'dart:convert';

class DealerPostModel {
  final String dealerId;
  final String title;
  final String? logo;
  final List<String> photos;
  final String? description;
  final int categoryId;
  final int subcategoryId;
  final String? email;
  final String? phone;
  final String? whatsapp;
  final String? websiteUrl;
  final Map<String, dynamic>? socialLinks;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? country;
  final Map<String, dynamic>? locationMap;
  final List<String>? services;
  final String? price;
  final Map<String, dynamic>? workingHours;
  final double? rating;
  final int? reviewsCount;
  final bool? verified;
  final int? establishedYear;
  final bool? featured;
  final List<String>? tags;

  DealerPostModel({
    required this.dealerId,
    required this.title,
    this.logo,
    required this.photos,
    this.description,
    required this.categoryId,
    required this.subcategoryId,
    this.email,
    this.phone,
    this.whatsapp,
    this.websiteUrl,
    this.socialLinks,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.country,
    this.locationMap,
    this.services,
    this.price,
    this.workingHours,
    this.rating,
    this.reviewsCount,
    this.verified,
    this.establishedYear,
    this.featured,
    this.tags,
  });

  factory DealerPostModel.fromJson(Map<String, dynamic> json) {
    return DealerPostModel(
      dealerId: json['dealer_id'],
      title: json['name'],
      logo: json['logo'],
      photos: json['photos'] != null
          ? List<String>.from(jsonDecode(json['photos']))
          : [],
      description: json['description'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      email: json['email'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      websiteUrl: json['website_url'],
      socialLinks: json['social_links'] != null
          ? Map<String, dynamic>.from(json['social_links'])
          : null,
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      country: json['country'],
      locationMap: json['location_map'] != null
          ? Map<String, dynamic>.from(json['location_map'])
          : null,
      services: json['services'] != null
          ? List<String>.from(json['services'])
          : null,
      price: json['services_starting_from'],
      workingHours: json['working_hours'] != null
          ? Map<String, dynamic>.from(json['working_hours'])
          : null,
      rating: json['rating'] != null ? double.tryParse(json['rating']) : null,
      reviewsCount: json['reviews_count'],
      verified: json['verified'] == 1,
      establishedYear: json['established_year'],
      featured: json['featured'] == 1,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }
}

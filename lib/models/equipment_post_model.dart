class EquipmentPostModel {
  final String postId;
  final String title;
  final String contact;
  final double price;
  final String description;
  final String? brand;
  final String? model;
  final String? usage;
  final String? itemCondition;
  final String? addressLine1;
  final String? addressLine2;
  final String? country;
  final String? city;
  final int categoryId;
  final int subcategoryId;
  final String? location;
  final List<String> photos;
  final DateTime createdAt;
  final DateTime updatedAt;

  EquipmentPostModel({
    required this.postId,
    required this.title,
    required this.contact,
    required this.price,
    required this.description,
    this.brand,
    this.model,
    this.usage,
    this.itemCondition,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.city,
    required this.categoryId,
    required this.subcategoryId,
    this.location,
    required this.photos,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, String> toAttributesMap() {
    final map = <String, String>{};
    if (brand != null && brand!.isNotEmpty) map["Brand"] = brand!;
    if (model != null && model!.isNotEmpty) map["Model"] = model!;
    if (usage != null && usage!.isNotEmpty) map["Usage"] = usage!;
    if (itemCondition != null && itemCondition!.isNotEmpty)
      map["Condition"] = itemCondition!;

    if ((addressLine1 != null && addressLine1!.isNotEmpty) ||
        (addressLine2 != null && addressLine2!.isNotEmpty)) {
      map["Address"] = "${addressLine1 ?? ''} ${addressLine2 ?? ''}".trim();
    }

    if (country != null && country!.isNotEmpty) map["Country"] = country!;
    if (city != null && city!.isNotEmpty) map["City"] = city!;
    if (location != null && location!.isNotEmpty) map["Location"] = location!;
    return map;
  }

  factory EquipmentPostModel.fromJson(Map<String, dynamic> json) {
    return EquipmentPostModel(
      postId: json['post_id'],
      title: json['title'] ?? '',
      contact: json['contact'] ?? '',
      price: json['price'] != null
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      description: json['description'] ?? '',
      brand: json['brand'],
      model: json['model'],
      usage: json['usage'],
      itemCondition: json['item_condition'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      country: json['country'],
      city: json['city'],
      categoryId: json['category_id'] ?? 0,
      subcategoryId: json['subcategory_id'] ?? 0,
      location: json['location'],
      photos: json['photos'] != null ? List<String>.from(json['photos']) : [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "post_id": postId,
      "title": title,
      "contact": contact,
      "price": price,
      "description": description,
      "brand": brand,
      "model": model,
      "usage": usage,
      "item_condition": itemCondition,
      "address_line1": addressLine1,
      "address_line2": addressLine2,
      "country": country,
      "city": city,
      "category_id": categoryId,
      "subcategory_id": subcategoryId,
      "location": location,
      "photos": photos,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}

class EquipmentPostData {
  String postId;
  String title;
  String contact;
  String? price;
  String description;
  String? brand;
  String? model;
  String? usage;
  String? itemCondition;
  String? addressLine1;
  String? addressLine2;
  String? country;
  String? city;
  String? location;
  int? categoryId;
  int? subcategoryId;
  List<String> photos;

  // ✅ Default constructor
  EquipmentPostData({
    this.postId = '',
    this.title = '',
    this.contact = '',
    this.price,
    this.description = '',
    this.brand,
    this.model,
    this.usage,
    this.itemCondition,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.city,
    this.location,
    this.categoryId,
    this.subcategoryId,
    List<String>? photos,
  }) : photos = photos ?? [];

  Map<String, dynamic> toJson() => {
    'post_id': postId,
    'title': title,
    'contact': contact,
    'price': price,
    'description': description,
    'brand': brand,
    'model': model,
    'usage': usage,
    'item_condition': itemCondition,
    'address_line1': addressLine1,
    'address_line2': addressLine2,
    'country': country,
    'city': city,
    'location': location,
    'category_id': categoryId,
    'subcategory_id': subcategoryId,
    'photos': photos,
  };

  factory EquipmentPostData.fromJson(Map<String, dynamic> json) {
    List<String> photosList = [];
    final photosData = json['photos'];

    if (photosData != null) {
      if (photosData is List) {
        photosList = List<String>.from(photosData.map((e) => e.toString()));
      } else if (photosData is String) {
        photosList = photosData.split(',').map((e) => e.trim()).toList();
      }
    }

    return EquipmentPostData(
      postId: json['post_id'] ?? '',
      title: json['title'] ?? '',
      contact: json['contact'] ?? '',
      price: json['price']?.toString(),
      description: json['description'] ?? '',
      brand: json['brand'],
      model: json['model'],
      usage: json['usage'],
      itemCondition: json['item_condition'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      country: json['country'],
      city: json['city'],
      location: json['location'],
      categoryId: json['category_id'] is String
          ? int.tryParse(json['category_id'])
          : json['category_id'],
      subcategoryId: json['subcategory_id'] is String
          ? int.tryParse(json['subcategory_id'])
          : json['subcategory_id'],
      photos: photosList,
    );
  }
}

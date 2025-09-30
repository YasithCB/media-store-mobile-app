class Subcategory {
  final int subcategoryId;
  final int categoryId;
  final String name;
  final String description;
  final String image;
  final String categoryName;
  final String categoryImage;

  Subcategory({
    required this.subcategoryId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.image,
    required this.categoryName,
    required this.categoryImage,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      subcategoryId: json['subcategory_id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      categoryName: json['category_name'] ?? '',
      categoryImage: json['category_image'] ?? '',
    );
  }
}

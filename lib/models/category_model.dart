class Category {
  final int categoryId;
  final String name;
  final String description;
  final String icon;
  final String image;

  Category({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.icon,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

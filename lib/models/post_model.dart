class PostModel {
  final int postId;
  final int userId;
  final int subcategoryId;
  final int categoryId;
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<String> photos;
  final String userName;
  final String subcategoryName;
  final String categoryName;

  PostModel({
    required this.postId,
    required this.userId,
    required this.subcategoryId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.photos,
    required this.userName,
    required this.subcategoryName,
    required this.categoryName,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['post_id'],
      userId: json['user_id'],
      subcategoryId: json['subcategory_id'],
      categoryId: json['category_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] != null
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString()) ?? 0.0
          : 0.0,
      photos: json['media'] != null ? List<String>.from(json['media']) : [],
      userName: json['user_name'] ?? '',
      subcategoryName: json['subcategory_name'] ?? '',
      categoryName: json['category_name'] ?? '',
    );
  }
}

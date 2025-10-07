class PostSummaryData {
  final String id;
  final String type;
  final String? logo;
  final String? image;
  final String title;
  final String? description;
  final String? price;
  final String? salary;

  PostSummaryData({
    required this.id,
    required this.type,
    this.logo,
    this.image,
    required this.title,
    this.description,
    this.price,
    this.salary,
  });

  factory PostSummaryData.fromJson(Map<String, dynamic> json) {
    List<dynamic>? mediaList = json['media'];
    String? firstImage;
    if (mediaList != null && mediaList.isNotEmpty) {
      firstImage = mediaList[0]?.toString();
    }

    return PostSummaryData(
      id: json['post_id']?.toString() ?? "",
      type: json['category_id']?.toString() ?? "",
      logo: json['logo']?.toString(),
      image: firstImage,
      title: json['title']?.toString() ?? "",
      description: json['description']?.toString(),
      price: json['price']?.toString(),
      salary: json['salary']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'logo': logo,
    'image': image,
    'title': title,
    'description': description,
    'price': price,
    'salary': salary,
  };
}

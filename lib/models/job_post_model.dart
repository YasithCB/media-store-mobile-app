class JobPostModel {
  final String postId;
  final String title;
  final String companyName;
  final List<String> photos; // ✅ changed to List
  final String? logo;
  final String? location;
  final String? country;
  final String? jobType;
  final String? industry;
  final String? experienceLevel;
  final String? price;
  final String? salaryType;
  final String? description;
  final DateTime postedDate;
  final DateTime? expiryDate;
  final String? email;
  final String? phone;
  final String? applicationUrl;
  final bool? remote;
  final bool? isHiring;
  final List<String>? tags;
  final int categoryId;
  final int subcategoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  JobPostModel({
    required this.postId,
    required this.title,
    required this.companyName,
    required this.photos,
    this.logo,
    this.location,
    this.country,
    this.jobType,
    this.industry,
    this.experienceLevel,
    this.price,
    this.salaryType,
    this.description,
    required this.postedDate,
    this.expiryDate,
    this.email,
    this.phone,
    this.applicationUrl,
    this.remote,
    this.isHiring,
    this.tags,
    required this.categoryId,
    required this.subcategoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory JobPostModel.fromJson(Map<String, dynamic> json) {
    List<String> photosList = [];

    if (json['photos'] != null) {
      photosList = List<String>.from(json['photos']);
    } else if (json['logo'] != null && json['logo'].toString().isNotEmpty) {
      photosList = [json['logo']];
    }

    return JobPostModel(
      postId: json['post_id'],
      title: json['title'],
      companyName: json['company_name'],
      photos: photosList,
      logo: json['logo'],
      location: json['location'],
      country: json['country'],
      jobType: json['job_type'],
      industry: json['industry'],
      experienceLevel: json['experience_level'],
      price: json['salary'],
      salaryType: json['salary_type'],
      description: json['description'],
      postedDate: DateTime.parse(json['posted_date']),
      expiryDate: json['expiry_date'] != null
          ? DateTime.parse(json['expiry_date'])
          : null,
      email: json['email'],
      phone: json['phone'],
      applicationUrl: json['application_url'],
      remote: json['remote'] == 1,
      isHiring: json['is_hiring'] == 1,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class MaterialItem {
  final String name;
  final double? ratePerSqFt;
  final double? ratePerUnit;
  final double? rate;

  MaterialItem({
    required this.name,
    this.ratePerSqFt,
    this.ratePerUnit,
    this.rate,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      name: json['name'],
      ratePerSqFt: (json['ratePerSqFt'] as num?)?.toDouble(),
      ratePerUnit: (json['ratePerUnit'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
    );
  }
}

class ServiceModel {
  final String name;
  final String image;
  final String desc;
  final List<MaterialItem>? materials;
  final double rating; // new attribute
  final double startingPrice; // new attribute

  ServiceModel({
    required this.name,
    required this.image,
    required this.desc,
    this.materials,
    this.rating = 3.0, // default value
    this.startingPrice = 100.0, // default value in AED
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      name: json['name'],
      image: json['image'],
      desc: json['desc'],
      materials: (json['materials'] as List?)
          ?.map((m) => MaterialItem.fromJson(m))
          .toList(),
      rating: (json['rating'] != null)
          ? (json['rating'] as num).toDouble()
          : 3.0, // default if not present
      startingPrice: (json['startingPrice'] != null)
          ? (json['startingPrice'] as num).toDouble()
          : 100.0, // default value
    );
  }
}

class CategoryModel {
  final String name;
  final String image;
  final String description;
  final List<ServiceModel> subcategories;

  CategoryModel({
    required this.name,
    required this.image,
    required this.description,
    required this.subcategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      subcategories: (json['subcategories'] as List)
          .map((s) => ServiceModel.fromJson(s))
          .toList(),
    );
  }
}

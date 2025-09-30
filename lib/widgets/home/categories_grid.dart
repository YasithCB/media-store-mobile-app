import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/screens/add_post/select_subcategory.dart';
import 'package:mobile_app/screens/service_screen.dart';
import 'package:mobile_app/screens/sub_category_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/widgets/loading.dart';

import '../../api/category_api.dart';
import '../../models/category_model.dart';

class CategoryGrid extends StatefulWidget {
  final bool needSubCategories;
  CategoryGrid({super.key, required this.needSubCategories});

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = CategoryApi.getCategories();
  }

  IconData getIconFromName(String? name) {
    final Map<String, IconData> iconMapping = {
      "equipment": Icons.category_outlined,
      "jobs": Icons.shopping_bag_outlined,
      "deal": Icons.handshake_outlined,
      // add more as needed
    };

    if (name == null) return Icons.category_outlined; // default fallback
    return iconMapping[name] ?? Icons.category_outlined;
  }

  final List<Map<String, dynamic>> customSubCategories = [
    {
      "title": "Media Companies",
      "icon": Icons.business,
      "subcategoryId": 19, // match your DB subcategory_id
    },

    {
      "title": "Video & Camera Equipment",
      "icon": Icons.videocam,
      "subcategoryId": 5,
    },
    {"title": "Job Seeking", "icon": Icons.search, "subcategoryId": 10},

    {
      "title": "Advertising Companies",
      "icon": Icons.campaign,
      "subcategoryId": 20,
    },
    {
      "title": "Audio & Sound Equipment",
      "icon": Icons.headphones,
      "subcategoryId": 4,
    },
    {"title": "Job Hiring", "icon": Icons.work, "subcategoryId": 11},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          FutureBuilder(
            future: _categories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 200,
                  child: const Center(child: Loading()),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final categories = snapshot.data ?? [];

              if (categories.isEmpty) {
                return const Center(
                  child: Text(
                    "No categories available",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 columns
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1, // square boxes
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildCategoryBox(category);
                },
              );
            },
          ),

          const SizedBox(height: 8),

          widget.needSubCategories
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: customSubCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.5, // square boxes
                  ),
                  itemBuilder: (context, index) {
                    final category = customSubCategories[index];
                    return _buildCategoryBoxSmall(category);
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildCategoryBox(Category category) {
    return InkWell(
      onTap: () {
        // handle category click
        if (widget.needSubCategories) {
          NavigationUtil.push(
            context,
            SubcategoryScreen(
              categoryName: category.name,
              categoryId: category.categoryId,
            ),
          );
        } else {
          post_category_title = category.name;
          post_category_id = category.categoryId;
          NavigationUtil.push(
            context,
            SelectSubCategory(categoryId: category.categoryId),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getIconFromName(category.icon),
              size: 25,
              color: Colors.black54,
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBoxSmall(Map<String, dynamic> category) {
    return InkWell(
      onTap: () {
        // handle category click
        NavigationUtil.push(
          context,
          ServiceScreen(
            categoryName: category['title'],
            categoryId: category['subcategoryId'],
            filterBySubCategory: true,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(category['icon'], size: 15, color: Colors.black54),
            // const SizedBox(height: 8),
            Text(
              category['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

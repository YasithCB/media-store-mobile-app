import 'package:flutter/material.dart';
import 'package:mobile_app/api/sub_category_api.dart';
import 'package:mobile_app/models/sub_category_model.dart';
import 'package:mobile_app/screens/service_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';

import '../db/constants.dart';

class SubcategoryScreen extends StatefulWidget {
  final String categoryName;
  final int categoryId;

  const SubcategoryScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  late Future<List<Subcategory>> _subcategories;

  void fetchSubcategoriesByCategory() async {
    try {
      _subcategories = SubCategoryApi.getSubcategoriesByCategoryId(
        widget.categoryId,
      );
    } catch (e) {
      print("Error fetching subcategories: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSubcategoriesByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: FutureBuilder(
        future: _subcategories,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text("Error: ${asyncSnapshot.error}"));
          }
          if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
            return const Center(child: Text("No subcategories found"));
          }

          final subcategories = asyncSnapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 5,
              ),
              itemCount: subcategories.length + 1, // +1 for "All in ..."
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _subcategoryTile(
                    context,
                    "All in ${widget.categoryName}",
                    onTap: () {
                      NavigationUtil.push(
                        context,
                        ServiceScreen(
                          categoryId: widget.categoryId,
                          filterBySubCategory: false,
                          categoryName: widget.categoryName,
                        ),
                      );
                    },
                  );
                } else {
                  final sub = subcategories[index - 1];
                  return _subcategoryTile(
                    context,
                    sub.name,
                    onTap: () {
                      NavigationUtil.push(
                        context,
                        ServiceScreen(
                          categoryId: sub.subcategoryId,
                          filterBySubCategory: true,
                          categoryName: sub.name,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _subcategoryTile(
    BuildContext context,
    String title, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        shadowColor: Colors.black26,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/screens/add_post/enter_dealer_post_details.dart';
import 'package:mobile_app/screens/add_post/enter_post_details.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/widgets/loading.dart';

import '../../api/sub_category_api.dart';
import '../../models/sub_category_model.dart';

class SelectSubCategory extends StatefulWidget {
  final int categoryId;
  const SelectSubCategory({super.key, required this.categoryId});

  @override
  State<SelectSubCategory> createState() => _SelectSubCategoryState();
}

class _SelectSubCategoryState extends State<SelectSubCategory> {
  late Future<List<Subcategory>> _subcategories;

  @override
  void initState() {
    super.initState();
    // ✅ assign future here (no async method needed)
    _subcategories = SubCategoryApi.getSubcategoriesByCategoryId(
      widget.categoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Top Close Button ===
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // === Title & Tagline ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      post_category_title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "which category that your ad fits into?",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // === subcategories List ===
            Expanded(
              // ✅ make ListView fill available space
              child: FutureBuilder<List<Subcategory>>(
                future: _subcategories,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: Loading());
                  }

                  if (asyncSnapshot.hasError) {
                    return Center(child: Text("Error: ${asyncSnapshot.error}"));
                  }

                  if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                    return const Center(child: Text("No subcategories found"));
                  }

                  final subcategories = asyncSnapshot.data!;

                  // filter items like used items - bcz can't add post through them
                  final filteredSubcategories = subcategories
                      .where(
                        (sub) =>
                            sub.name.toLowerCase() != "rent items" &&
                            sub.name.toLowerCase() != "used items" &&
                            sub.name.toLowerCase() != "brand new items" &&
                            sub.name.toLowerCase() != "job seeking" &&
                            sub.name.toLowerCase() != "job hiring",
                      )
                      .toList();

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredSubcategories.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final sub = filteredSubcategories[index];

                      return InkWell(
                        onTap: () {
                          // todo
                          post_subcategory_id = sub.subcategoryId;
                          post_subcategory_title = sub.name;

                          if (post_category_id == 1) {
                            NavigationUtil.push(context, EnterPostDetails());
                          } else if (post_category_id == 2) {
                            NavigationUtil.push(context, EnterPostDetails());
                          } else {
                            NavigationUtil.push(
                              context,
                              EnterDealerPostDetails(),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  sub.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // 👈 prevents overflow
                                  maxLines: 1, // 👈 keeps to one line
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

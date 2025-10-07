import 'package:flutter/material.dart';
import 'package:mobile_app/api/dealer_post_api.dart';
import 'package:mobile_app/api/equipment_post_api.dart';
import 'package:mobile_app/api/job_post_api.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/models/dealer_post_model.dart';
import 'package:mobile_app/models/equipment_post_model.dart';
import 'package:mobile_app/models/job_post_data.dart';

import '../../models/post_model.dart';
import '../../widgets/post.dart';

class PostScreen extends StatefulWidget {
  final int categoryId;
  final int subCategoryId;
  final String categoryName;
  final bool filterBySubCategory;

  const PostScreen({
    super.key,
    required this.categoryId,
    required this.filterBySubCategory,
    required this.categoryName,
    required this.subCategoryId,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String selectedLocation = "Dubai";
  String selectedSort = "Popularity";

  late Future<List<PostModel>> _posts;
  late Future<List<EquipmentPostModel>> _posts_equipment;
  late Future<List<JobPostData>> _posts_jobs;
  late Future<List<DealerPostModel>> _posts_dealers;

  @override
  void initState() {
    super.initState();
    if (widget.categoryId == 1) {
      _posts_equipment = widget.filterBySubCategory
          ? EquipmentPostApi.getEquipmentPostsBySubcategory(
              widget.subCategoryId,
            )
          : EquipmentPostApi.getAllEquipmentPosts();
    } else if (widget.categoryId == 2) {
      _posts_jobs = widget.filterBySubCategory
          ? JobPostApi.getJobPostsBySubcategoryId(widget.subCategoryId)
          : JobPostApi.getAllJobPosts();
    } else if (widget.categoryId == 3) {
      _posts_dealers = widget.filterBySubCategory
          ? DealerPostApi.getDealerPostsBySubcategory(widget.subCategoryId)
          : DealerPostApi.getAllDealerPosts();
    } else {
      print('unknown category ID ::: ${widget.subCategoryId}');
    }
  }

  decideFuture() {
    if (widget.categoryId == 1) {
      return _posts_equipment;
    } else if (widget.categoryId == 2) {
      return _posts_jobs;
    } else if (widget.categoryId == 3) {
      return _posts_dealers;
    } else {
      return _posts;
    }
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: decideFuture(),
              builder: (context, asyncSnapshot) {
                print('asyncSnapshot.data');
                print(asyncSnapshot.data);
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (asyncSnapshot.hasError) {
                  return Center(child: Text("Error: ${asyncSnapshot.error}"));
                }

                if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                  return const Center(child: Text("No services available"));
                }

                final allServices = asyncSnapshot.data!;

                return ListView.builder(
                  itemCount: allServices.length + 1, // +1 for header row
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // 🔹 Header row (Services count + Sort dropdown)
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${allServices.length} Results",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Sort by:",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 8),
                                DropdownButton<String>(
                                  value: selectedSort,
                                  underline: const SizedBox(),
                                  items:
                                      <String>[
                                            "Popularity",
                                            "Price Low to High",
                                            "Price High to Low",
                                            "Rating",
                                          ]
                                          .map(
                                            (sort) => DropdownMenuItem(
                                              value: sort,
                                              child: Text(sort),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSort = value!;
                                      // todo: implement sorting
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }

                    // 🔹 Post card
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Post(post: allServices[index - 1]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

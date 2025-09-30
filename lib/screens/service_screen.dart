import 'package:flutter/material.dart';
import 'package:mobile_app/api/post_api.dart';
import 'package:mobile_app/db/constants.dart';

import '../../models/post_model.dart';
import '../../widgets/post.dart';

class ServiceScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final bool filterBySubCategory;

  const ServiceScreen({
    super.key,
    required this.categoryId,
    required this.filterBySubCategory,
    required this.categoryName,
  });

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String selectedLocation = "Dubai";
  String selectedSort = "Popularity";

  late Future<List<PostModel>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = widget.filterBySubCategory
        ? PostApi.getPostsBySubcategory(widget.categoryId)
        : PostApi.getPostsByCategory(widget.categoryId);
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
            child: FutureBuilder<List<PostModel>>(
              future: _posts,
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

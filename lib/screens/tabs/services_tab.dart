import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/api/post_api.dart';
import 'package:mobile_app/db/constants.dart';

import '../../models/post_summary_data.dart';
import '../../widgets/post.dart';

class ServicesTab extends StatefulWidget {
  const ServicesTab({super.key});

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  String selectedLocation = "Dubai";
  String selectedSort = "Popularity";

  late Future<List<PostSummaryData>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = PostApi.fetchPostSummaries();
    _posts
        .then((posts) {
          for (var post in posts) {
            print("${post.type}: ${post.title} (${post.id})");
          }
        })
        .catchError((e) {
          print("Error fetching posts: $e");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(5),
        child: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      body: Column(
        children: [
          // 🔹 Top search/filter bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.black54),
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        // todo: notifications
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // 🔹 Main content
          Expanded(
            child: FutureBuilder<List<PostSummaryData>>(
              future: _posts,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (asyncSnapshot.hasError) {
                  print("Error: ${asyncSnapshot.error}");
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
                              "${allServices.length} Services",
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

import 'package:flutter/material.dart';

import '../../api/post_api.dart';
import '../../models/post_model.dart';

class HorizontalPostSlider extends StatefulWidget {
  const HorizontalPostSlider({super.key});

  @override
  State<HorizontalPostSlider> createState() => _HorizontalPostSliderState();
}

class _HorizontalPostSliderState extends State<HorizontalPostSlider> {
  late Future<List<PostModel>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = PostApi.getHighRatedPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Popular Posts",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),

        SizedBox(
          height: 160, // enough space for image + title
          child: FutureBuilder(
            future: _posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No popular services found"));
              }

              final popularServices = snapshot.data!;

              return GridView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: popularServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // one row
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4, // adjust card proportion
                ),
                itemBuilder: (context, index) {
                  final item = popularServices[index];
                  return InkWell(
                    onTap: () {
                      // NavigationUtil.push(
                      //   context,
                      //   SubServiceDetailsScreen(service: item),
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.media[0], // remote URL
                            fit: BoxFit.cover,
                            height: 100,
                            width: 140,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 40,
                              ); // fallback if image fails
                            },
                          ),
                        ),

                        const SizedBox(height: 6),
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

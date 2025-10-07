import 'package:flutter/material.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/widgets/post_details/equipment_post_details.dart';

import '../db/constants.dart';
import '../models/post_summary_data.dart';

class Post extends StatelessWidget {
  final PostSummaryData post;

  const Post({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationUtil.push(
          context,
          EquipmentPostDetails(post: null, postId: post.id),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: _buildImage(post),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post.description ?? "",
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '4.0', // You can make rating dynamic later
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      if (post.price != null)
                        Text(
                          "From AED ${post.price}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (post.salary != null)
                        Text(
                          "Salary: ${post.salary}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(PostSummaryData post) {
    if (post.image != null && post.image!.isNotEmpty) {
      String imageUrl = post.image!;
      if (imageUrl.startsWith("/")) {
        imageUrl = "$baseUrl$imageUrl";
      }
      return Image.network(imageUrl, fit: BoxFit.cover);
    }

    if (post.logo != null && post.logo!.isNotEmpty) {
      String logoUrl = post.logo!;
      if (logoUrl.startsWith("/")) {
        logoUrl = "$baseUrl$logoUrl";
      }
      return Image.network(logoUrl, fit: BoxFit.cover);
    }

    return const Center(child: Icon(Icons.image, size: 50, color: Colors.grey));
  }
}

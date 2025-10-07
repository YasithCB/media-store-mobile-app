import 'package:flutter/material.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/widgets/post_details/equipment_post_details.dart';

import '../db/constants.dart';

class Post extends StatelessWidget {
  final dynamic post;

  const Post({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationUtil.push(context, EquipmentPostDetails(post: post));
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
                child: post.categoryId == 1
                    ? Image.network(
                        post.photos[0].startsWith("uploads")
                            ? "$baseUrl/${post.photos[0]}"
                            : post.photos[0],
                        fit: BoxFit.cover,
                      )
                    : post.categoryId == 2
                    ? Image.network(
                        post.logoUrl.startsWith("uploads")
                            ? "$baseUrl/${post.logoUrl}"
                            : post.logoUrl,
                        fit: BoxFit.cover,
                      )
                    : Image.network(post.photos[0], fit: BoxFit.cover),
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
                    post.description,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '4.0',
                            // post.rating.toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        "From AED${post.price}",
                        style: TextStyle(
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
}

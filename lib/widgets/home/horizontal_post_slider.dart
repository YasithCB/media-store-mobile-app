import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/widgets/post_details/dealer_post_details.dart';
import 'package:mobile_app/widgets/post_details/equipment_post_details.dart';
import 'package:mobile_app/widgets/post_details/job_post_details.dart';

import '../../util/navigation_util.dart';

class HorizontalPostSlider extends StatefulWidget {
  const HorizontalPostSlider({
    super.key,
    required this.title,
    required this.postsList,
    required this.categoryId,
  });

  final String title;
  final int categoryId;
  final List<dynamic> postsList;

  @override
  State<HorizontalPostSlider> createState() => _HorizontalPostSliderState();
}

class _HorizontalPostSliderState extends State<HorizontalPostSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),

        SizedBox(
          height: 170, // enough space for image + title
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.postsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // one row
              mainAxisSpacing: 12,
              childAspectRatio: 1.4, // adjust card proportion
            ),
            itemBuilder: (context, index) {
              final item = widget.postsList[index];
              return widget.categoryId == 2
                  ? InkWell(
                      onTap: () {
                        NavigationUtil.push(
                          context,
                          JobPostDetails(post: item),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.categoryId == 1
                                  ? (item.photos[0].startsWith("uploads")
                                        ? "$baseUrl/${item.photos[0]}"
                                        : item.photos[0])
                                  : (item.logoUrl.startsWith("uploads")
                                        ? "$baseUrl/${item.logoUrl}"
                                        : item.logoUrl),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 140,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 40);
                              },
                            ),
                          ),

                          const SizedBox(height: 6),
                          Text(
                            widget.categoryId == 3
                                ? item.title
                                : 'AED ${item.price.toString()}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: primaryColorHover2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        if (item.categoryId == 1) {
                          NavigationUtil.push(
                            context,
                            EquipmentPostDetails(post: item),
                          );
                        } else if (item.categoryId == 3) {
                          NavigationUtil.push(
                            context,
                            DealerPostDetails(dealer: item),
                          );
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.photos[0].startsWith("/")
                                  ? "$baseUrl${item.photos[0]}"
                                  : item.photos[0],
                              fit: BoxFit.cover,
                              height: 100,
                              width: 140,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 40);
                              },
                            ),
                          ),

                          const SizedBox(height: 6),
                          Text(
                            widget.categoryId == 3
                                ? item.title
                                : 'AED ${item.price.toString()}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: primaryColorHover2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}

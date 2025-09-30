import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';

import '../../models/post_model.dart';

class HorizontalPostSlider extends StatefulWidget {
  const HorizontalPostSlider({
    super.key,
    required this.title,
    required this.postsList,
  });

  final String title;
  final List<PostModel> postsList;

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
                      'AED ${item.price.toString()}',
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

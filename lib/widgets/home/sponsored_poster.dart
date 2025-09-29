import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';

class SponsoredPoster extends StatelessWidget {
  final String imagePath;
  final String tagline;
  final VoidCallback? onTap;

  const SponsoredPoster({
    super.key,
    required this.imagePath,
    this.tagline = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Sponsored",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Poster with tagline & button
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              // Full width image
              Container(
                width: double.infinity,
                height: deviceWidth - 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),

              // Gradient overlay for bottom tagline
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          tagline,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

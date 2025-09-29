import 'package:flutter/material.dart';

import '../../db/banners_data.dart';
import '../../db/constants.dart';

class BannerSwiper extends StatefulWidget {
  const BannerSwiper({super.key});

  @override
  State<BannerSwiper> createState() => _BannerSwiperState();
}

class _BannerSwiperState extends State<BannerSwiper> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // === Title: Special Offers ===
        const Text(
          "#SpecialForYou",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 8),

        // === Swipeable Banner Carousel ===
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imageBanners.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, i) {
              return BannerCard(imagePath: imageBanners[i]);
            },
          ),
        ),

        const SizedBox(height: 8),
        // === Indicator Dots / Bars ===
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageBanners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? primaryColor
                    : primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BannerCard extends StatelessWidget {
  final String imagePath;
  const BannerCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}

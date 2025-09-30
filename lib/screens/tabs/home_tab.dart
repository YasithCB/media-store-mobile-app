import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/screens/login_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/widgets/home/banner_swiper.dart';
import 'package:mobile_app/widgets/home/categories_grid.dart';
import 'package:mobile_app/widgets/home/horizontal_post_slider.dart';

import '../../widgets/home/sponsored_poster.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedLocation = "Dubai";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // Top section
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
                          child: TextField(
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
                        child: Icon(Icons.filter_list, color: Colors.black54),
                      ),
                      const SizedBox(width: 12),

                      InkWell(
                        onTap: () => {
                          NavigationUtil.pushReplacement(
                            context,
                            LoginScreen(),
                          ),
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
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

            // Rest of your page
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CategoryGrid(),
                    SizedBox(height: 10),

                    BannerSwiper(),
                    SizedBox(height: 20),

                    HorizontalPostSlider(),

                    // SizedBox(height: 30),
                    SponsoredPoster(
                      imagePath: "assets/images/sponsored/spo2.webp",
                      tagline: "Launch your brand to new heights today!",
                      onTap: () {
                        // todo
                      },
                    ),

                    // Add your other widgets here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

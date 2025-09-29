import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/widgets/home/banner_swiper.dart';
import 'package:mobile_app/widgets/home/category_icons.dart';

import '../../db/services_data.dart';
import '../../widgets/home/service_slider.dart';
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
                image: const DecorationImage(
                  image: AssetImage("assets/logo-icon-black.webp"),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  opacity: 0.1,
                ),
              ),

              child: Column(
                children: [
                  // Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left column
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 4),
                          DropdownButton<String>(
                            value: selectedLocation,
                            underline: const SizedBox(),
                            iconEnabledColor: Colors.black87,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            items:
                                <String>[
                                  'Dubai',
                                  'Abu Dhabi',
                                  'Sharjah',
                                  'Ajman',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLocation = newValue!;
                              });
                            },
                          ),
                        ],
                      ),

                      // Right column (notification icon)
                      Container(
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
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Second row: search + filter
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
                    SizedBox(height: 10),
                    BannerSwiper(),
                    SizedBox(height: 20),

                    CategoryIcons(),
                    SizedBox(height: 30),

                    ServiceSlider(list: allServices),

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

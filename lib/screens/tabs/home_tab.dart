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
    Color bgColor = primaryColor; // light background
    Color textColor = Colors.black87;
    Color iconColor = Colors.black54;

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // Top design section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: bgColor,
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
                  image: AssetImage("assets/logo-icon-white.webp"),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  opacity: 0.15,
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
                          Icon(Icons.location_on_rounded, color: iconColor),
                          const SizedBox(width: 4),
                          DropdownButton<String>(
                            value: selectedLocation,
                            underline: const SizedBox(),
                            iconEnabledColor: iconColor,
                            style: TextStyle(color: textColor, fontSize: 16),
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
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.notifications_rounded,
                          color: iconColor,
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
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.search, color: iconColor),
                              hintText: "Search...",
                              hintStyle: TextStyle(
                                color: iconColor.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.filter_list, color: iconColor),
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

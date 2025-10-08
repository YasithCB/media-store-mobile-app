import 'package:flutter/material.dart';
import 'package:mobile_app/api/dealer_post_api.dart';
import 'package:mobile_app/api/equipment_post_api.dart';
import 'package:mobile_app/api/job_post_api.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/models/dealer_post_data.dart';
import 'package:mobile_app/models/equipment_post_data.dart';
import 'package:mobile_app/models/job_post_data.dart';
import 'package:mobile_app/widgets/home/banner_swiper.dart';
import 'package:mobile_app/widgets/home/categories_grid.dart';
import 'package:mobile_app/widgets/home/horizontal_post_slider.dart';
import 'package:mobile_app/widgets/loading.dart';

import '../../widgets/home/sponsored_poster.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedLocation = "Dubai";

  late Future<List<dynamic>> _combinedFuture;

  fetchPopularPosts() {
    return EquipmentPostApi.getAllEquipmentPosts();
  }

  fetchJobs() {
    return JobPostApi.getAllJobPosts();
  }

  fetchDealers() {
    return DealerPostApi.getAllDealerPosts();
  }

  fetchPopularPostsInVideoAndCamera() {
    return EquipmentPostApi.getEquipmentPostsBySubcategory(5);
  }

  fetchPopularPostsInAudioAndSound() {
    return EquipmentPostApi.getEquipmentPostsBySubcategory(4);
  }

  @override
  void initState() {
    super.initState();
    _combinedFuture = Future.wait([
      fetchPopularPosts(), // returns List<Post>
      fetchPopularPostsInVideoAndCamera(),
      fetchPopularPostsInAudioAndSound(),
      fetchJobs(),
      fetchDealers(),
    ]);
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              icon: Icon(
                                Icons.search,
                                color: Colors.black54,
                                size: 20,
                              ),
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
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),

                      InkWell(
                        onTap: () => {
                          // todo
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
                            size: 20,
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
            FutureBuilder(
              future: _combinedFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 200,
                    child: const Center(child: Loading()),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text("No data found"));
                }

                final results = snapshot.data!;
                final popularPosts = results[0] as List<EquipmentPostData>;
                final videoAndCameraPosts =
                    results[1] as List<EquipmentPostData>;
                final audioAndSoundPosts =
                    results[2] as List<EquipmentPostData>;
                final popularJobs = results[3] as List<JobPostData>;
                final popularDealers = results[4] as List<DealerPostData>;

                return Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CategoryGrid(needSubCategories: true),
                        const SizedBox(height: 8),

                        BannerSwiper(),
                        const SizedBox(height: 8),

                        HorizontalPostSlider(
                          title: 'Popular Today',
                          postsList: popularPosts,
                          categoryId: 1,
                        ),

                        const SizedBox(height: 8),

                        HorizontalPostSlider(
                          title: 'Popular Dealers',
                          postsList: popularDealers,
                          categoryId: 3,
                        ),
                        const SizedBox(height: 8),

                        HorizontalPostSlider(
                          title: 'Popular In Video & Camera',
                          postsList: videoAndCameraPosts,
                          categoryId: 1,
                        ),
                        const SizedBox(height: 8),

                        HorizontalPostSlider(
                          title: 'Popular In Audio & Sound',
                          postsList: audioAndSoundPosts,
                          categoryId: 1,
                        ),
                        const SizedBox(height: 8),

                        HorizontalPostSlider(
                          title: 'Popular Jobs',
                          postsList: popularJobs,
                          categoryId: 2,
                        ),
                        const SizedBox(height: 8),

                        SponsoredPoster(
                          imagePath: "assets/images/sponsored/spo2.webp",
                          tagline: "Launch your brand to new heights today!",
                          onTap: () {
                            // todo
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

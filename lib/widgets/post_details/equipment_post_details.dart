import 'package:flutter/material.dart';
import 'package:mobile_app/api/equipment_post_api.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/models/equipment_post_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/util.dart';

class EquipmentPostDetails extends StatefulWidget {
  final String postId;

  const EquipmentPostDetails({Key? key, required this.postId})
    : super(key: key);

  @override
  State<EquipmentPostDetails> createState() => _EquipmentPostDetailsState();
}

class _EquipmentPostDetailsState extends State<EquipmentPostDetails> {
  late Future<EquipmentPostData?> equipmentPost;

  void callSeller(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      debugPrint("Could not launch $phoneNumber");
    }
  }

  @override
  void initState() {
    super.initState();
    equipmentPost = EquipmentPostApi.getEquipmentPostById(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: equipmentPost,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("Equipment post not found"));
            }

            final post = snapshot.data!;

            return Column(
              children: [
                // Top bar with back button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Go back
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        post.model ?? 'Item Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    children: [
                      _buildImagesSection(post.photos),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  post!.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(), // pushes the icon to the end
                                IconButton(
                                  onPressed: () {
                                    // handle wishlist toggle
                                  },
                                  icon: const Icon(
                                    Icons.bookmark_add_outlined,
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "AED ${post.price}",
                              style: TextStyle(
                                fontSize: 20,
                                color: primaryColorHover2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post.description,
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 16),
                            const Divider(color: Colors.black26),
                            const SizedBox(height: 8),
                            _buildSellerInfo(post.contact),
                            const SizedBox(height: 80), // space for bottom bar
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBottomBar(context, post.contact),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildImagesSection(List<String> images) {
    if (images.isEmpty) {
      return Container(
        height: 250,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.image, size: 80, color: Colors.grey),
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: PageView(
        children: images
            .map(
              (url) => Image.network(
                '$baseUrl/${removeLeadingSlash(url)}',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildAttributes(Map<String, String> attributes) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: attributes.entries.map((entry) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSellerInfo(String contact) {
    return Row(
      children: [
        CircleAvatar(
          child: Icon(Icons.person_outline, color: Colors.black54),
          backgroundColor: primaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          contact,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, String contact) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.phone_android_outlined,
                color: Colors.black54,
              ),
              label: const Text(
                "Call Seller",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                callSeller(contact); // pass seller contact
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // your custom color
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // low radius
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.message_outlined, color: Colors.black54),
              label: const Text(
                "Message",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                // message logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // your custom color
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // low radius
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

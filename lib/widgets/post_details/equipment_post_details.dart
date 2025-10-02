import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/equipment_post_model.dart';

class EquipmentPostDetails extends StatelessWidget {
  final EquipmentPostModel post;

  const EquipmentPostDetails({Key? key, required this.post}) : super(key: key);

  void callSeller(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      debugPrint("Could not launch $phoneNumber");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    post.model ?? 'Item Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "AED ${post.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 20,
                            color: primaryColorHover2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildAttributes(post.toAttributesMap()),
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
              (url) =>
                  Image.network(url, fit: BoxFit.cover, width: double.infinity),
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
                callSeller(post.contact); // pass seller contact
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

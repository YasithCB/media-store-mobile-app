import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db/constants.dart';
import '../../models/dealer_post_model.dart';

class DealerPostDetails extends StatelessWidget {
  final DealerPostModel dealer;

  const DealerPostDetails({Key? key, required this.dealer}) : super(key: key);

  void callDealer(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      debugPrint("Could not launch $phoneNumber");
    }
  }

  void openWebsite(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      debugPrint("Could not open URL: $url");
    }
  }

  void openSocialLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      debugPrint("Could not open URL: $url");
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
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      dealer.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  _buildImagesSection(dealer.photos),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dealer Name
                        Row(
                          children: [
                            Text(
                              dealer.title,
                              style: const TextStyle(
                                fontSize: 22,
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

                        const SizedBox(height: 8),

                        // Location & Rating
                        Row(
                          children: [
                            if (dealer.city != null && dealer.city!.isNotEmpty)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${dealer.city}, ${dealer.country}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            const SizedBox(width: 16),
                            if (dealer.rating != null)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    dealer.rating.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Services
                        if (dealer.services != null &&
                            dealer.services!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Services",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: dealer.services!
                                    .map(
                                      (service) => Chip(label: Text(service)),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),

                        // Services Starting Price
                        if (dealer.price != null && dealer.price!.isNotEmpty)
                          Text(
                            "Starting From : AED ${dealer.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        const SizedBox(height: 16),
                        const Divider(color: Colors.black26),

                        // Description
                        if (dealer.description != null &&
                            dealer.description!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "About Dealer",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                dealer.description ?? "-",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.black26),

                        // Contact Info
                        _buildContactInfo(dealer),

                        const SizedBox(height: 16),

                        // Social Links
                        if (dealer.socialLinks != null &&
                            dealer.socialLinks!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Social Links",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: dealer.socialLinks!.entries.map((
                                  entry,
                                ) {
                                  return ActionChip(
                                    label: Text(entry.key),
                                    onPressed: () =>
                                        openSocialLink(entry.value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            _buildBottomBar(context, dealer.phone, dealer.websiteUrl),
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

  Widget _buildContactInfo(DealerPostModel dealer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contact Info",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (dealer.email != null && dealer.email!.isNotEmpty)
          Text("Email: ${dealer.email}"),
        if (dealer.phone != null && dealer.phone!.isNotEmpty)
          Text("Phone: ${dealer.phone}"),
        if (dealer.whatsapp != null && dealer.whatsapp!.isNotEmpty)
          Text("WhatsApp: ${dealer.whatsapp}"),
        if (dealer.addressLine1 != null && dealer.addressLine1!.isNotEmpty)
          Text("Address: ${dealer.addressLine1} ${dealer.addressLine2 ?? ''}"),
      ],
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    String? phone,
    String? websiteUrl,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (phone != null && phone.isNotEmpty)
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.phone_android_outlined,
                  color: Colors.black54,
                ),
                label: const Text(
                  "Call",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => callDealer(phone),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          if (phone != null && phone.isNotEmpty && websiteUrl != null)
            const SizedBox(width: 8),
          if (websiteUrl != null && websiteUrl.isNotEmpty)
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_browser, color: Colors.black54),
                label: const Text(
                  "Website",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => openWebsite(websiteUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

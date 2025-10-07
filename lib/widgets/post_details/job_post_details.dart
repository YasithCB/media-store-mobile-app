import 'package:flutter/material.dart';
import 'package:mobile_app/models/job_post_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db/constants.dart';

class JobPostDetails extends StatelessWidget {
  final JobPostData post;

  const JobPostDetails({Key? key, required this.post}) : super(key: key);

  void callEmployer(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      debugPrint("Could not launch $phoneNumber");
    }
  }

  void openApplicationUrl(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
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
                      post.title,
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
                  _buildImagesSection(post.logoUrl!),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company Name
                        Row(
                          children: [
                            Text(
                              post.companyName,
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
                        const SizedBox(height: 5),

                        // Location and Type
                        Row(
                          children: [
                            if (post.location != null)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    post.location!,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            const SizedBox(width: 16),
                            if (post.jobType != null)
                              Chip(
                                label: Text(post.jobType!),
                                backgroundColor: Colors.grey.shade200,
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Salary
                        if (post.salary != null)
                          Text(
                            "Salary: ${post.salary} ${post.salaryType ?? ''}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        const SizedBox(height: 16),
                        const Divider(),

                        // Job Details Attributes
                        _buildAttributes({
                          "Industry": post.industry ?? "-",
                          "Experience": post.experienceLevel ?? "-",
                          "Remote": post.remote == true ? "Yes" : "No",
                          // "Posted": post.da.toLocal().toString().split(
                          //   " ",
                          // )[0],
                          if (post.expiryDate != null)
                            "Expiry": post.expiryDate!
                                .toLocal()
                                .toString()
                                .split(" ")[0],
                        }),

                        const SizedBox(height: 16),
                        const Text(
                          "Job Description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post.description ?? "-",
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 16),
                        const Divider(),

                        // Employer Info
                        _buildEmployerInfo(
                          post.companyName,
                          post.logoUrl,
                          post.email,
                          post.phone,
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            _buildBottomBar(context, post.phone, post.applicationUrl),
          ],
        ),
      ),
    );
  }

  Widget _buildImagesSection(String image) {
    if (image.isEmpty) {
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
      child: Image.network(
        '$baseUrl${image}',
        fit: BoxFit.cover,
        width: double.infinity,
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

  Widget _buildEmployerInfo(
    String companyName,
    String? logo,
    String? email,
    String? phone,
  ) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: logo != null ? NetworkImage(logo) : null,
          backgroundColor: Colors.grey.shade200,
          child: logo == null ? const Icon(Icons.business) : null,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              companyName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (email != null)
              Text(
                email,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            if (phone != null)
              Text(
                phone,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    String? phone,
    String? applicationUrl,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (phone != null)
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
                onPressed: () => callEmployer(phone),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          if (phone != null && applicationUrl != null) const SizedBox(width: 8),
          if (applicationUrl != null)
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_browser, color: Colors.black54),
                label: const Text(
                  "Apply",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => openApplicationUrl(applicationUrl),
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

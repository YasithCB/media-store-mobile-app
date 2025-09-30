import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/util/storage_util.dart';

import '../../util/navigation_util.dart';
import '../login_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // user details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor:
                        primaryColor, // background color while loading
                    backgroundImage: NetworkImage(
                      'https://media.istockphoto.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=0&k=20&c=tyLvtzutRh22j9GqSGI33Z4HpIwv9vL_MZw_xOE19NQ=',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delmaine Donson",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    size: 14,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 8),

                                  const Text(
                                    "Verified",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Joined Jan 2023",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== My Ads Row =====
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "My Ads",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 18),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===== Settings List =====
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.perm_identity, size: 21),
                    title: const Text("Profile"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined, size: 21),
                    title: const Text("Account Settings"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.notifications_active_outlined,
                      size: 21,
                    ),
                    title: const Text("Notification Settings"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock_open, size: 21),
                    title: const Text("Security"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.work_history_outlined, size: 21),
                    title: const Text("My Job Applications"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.support_agent, size: 21),
                    title: const Text("Support"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_ic_call_outlined, size: 21),
                    title: const Text("Call Us"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.campaign_outlined, size: 21),
                    title: const Text("Advertising"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Color(0xFFE00000),
                      size: 21,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: Color(0xFFE00000)),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black54,
                    ),
                    onTap: () {
                      StorageUtil.clear();
                      NavigationUtil.pushReplacement(context, LoginScreen());
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== App Version =====
            Center(
              child: Text(
                "App Version 1.0.0",
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

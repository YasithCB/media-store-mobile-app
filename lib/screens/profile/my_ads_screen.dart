import 'package:flutter/material.dart';

import '../../widgets/post.dart'; // or JobPostModel if you want

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  late Future<List<dynamic>> _myPosts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
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
                  const Text(
                    "My Ads",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Ads list
            FutureBuilder<List<dynamic>>(
              future: _myPosts,
              builder: (context, asyncSnapshot) {
                print('asyncSnapshot.data');
                print(asyncSnapshot.data);

                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (asyncSnapshot.hasError) {
                  return Center(child: Text("Error: ${asyncSnapshot.error}"));
                }

                if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                  return const Center(child: Text("No Posts available"));
                }

                final postsList = asyncSnapshot.data!;

                return ListView.builder(
                  itemCount: postsList.length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Post(post: postsList[index]),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

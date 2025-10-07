import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/api/dealer_post_api.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/util/snackbar_util.dart';

import '../../../models/dealer_post_data.dart';
import '../../../widgets/custom_button.dart';

class AddDealerStep6Review extends StatefulWidget {
  final DealerPostData data;
  final VoidCallback onBack;

  const AddDealerStep6Review({
    Key? key,
    required this.data,
    required this.onBack,
  }) : super(key: key);

  @override
  State<AddDealerStep6Review> createState() => _AddDealerStep6ReviewState();
}

class _AddDealerStep6ReviewState extends State<AddDealerStep6Review> {
  bool _isLoading = false;

  Future<void> _submitDealerPost() async {
    setState(() => _isLoading = true);

    final resp = await DealerPostApi.createDealerPost(widget.data);

    setState(() => _isLoading = false);

    SnackBarUtil.show(context, resp['message']);

    if (resp['success']) {
      NavigationUtil.pushAndRemoveUntil(context, HomeScreen());
    }
  }

  Widget _buildRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 3, child: Text(value ?? '-')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Review & Submit",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Logo preview
                if (widget.data.logo != null) ...[
                  const Text(
                    "Logo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        widget.data.logo!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Images preview
                if (widget.data.photos.isNotEmpty) ...[
                  const Text(
                    "Photos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 140,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.data.photos.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(widget.data.photos[index]),
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Review text rows
                _buildRow("Dealer Name", widget.data.title),
                _buildRow("Email", widget.data.email),
                _buildRow("Phone", widget.data.phone),
                _buildRow("Country", widget.data.country),
                _buildRow("Services", widget.data.services?.join(", ")),

                const SizedBox(height: 80), // space for button
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(text: "Back", onPressed: widget.onBack),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomButton(
                  text: _isLoading ? "Submitting..." : "Submit",
                  onPressed: _submitDealerPost,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

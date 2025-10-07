import 'package:flutter/material.dart';

import '../../../models/dealer_post_data.dart';
import '../../../widgets/custom_button.dart';

class AddDealerStep2Contact extends StatelessWidget {
  final DealerPostData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddDealerStep2Contact({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

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
                  "Contact Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (v) => data.email = v,
                ),
                const SizedBox(height: 12),

                TextField(
                  decoration: const InputDecoration(labelText: 'Phone'),
                  onChanged: (v) => data.phone = v,
                ),
                const SizedBox(height: 12),

                TextField(
                  decoration: const InputDecoration(labelText: 'WhatsApp'),
                  onChanged: (v) => data.whatsapp = v,
                ),
                const SizedBox(height: 12),

                TextField(
                  decoration: const InputDecoration(labelText: 'Website'),
                  onChanged: (v) => data.websiteUrl = v,
                ),
                const SizedBox(height: 80), // Space for button
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
                child: CustomButton(text: "Back", onPressed: onBack),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomButton(text: "Next", onPressed: onNext),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

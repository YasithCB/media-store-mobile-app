import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/util/snackbar_util.dart';
import 'package:mobile_app/widgets/loading.dart';

import '../../../api/equipment_post_api.dart';
import '../../../models/equipment_post_data.dart';
import '../../../util/util.dart';
import '../../../widgets/custom_button.dart';

class AddEquipmentStep4Review extends StatefulWidget {
  final EquipmentPostData data;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const AddEquipmentStep4Review({
    Key? key,
    required this.data,
    required this.onBack,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AddEquipmentStep4Review> createState() =>
      _AddEquipmentStep4ReviewState();
}

class _AddEquipmentStep4ReviewState extends State<AddEquipmentStep4Review> {
  bool _isLoading = false;

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Future<void> submitEquipmentPost() async {
    setState(() => _isLoading = true);

    bool success = await EquipmentPostApi.createEquipmentPost(
      title: widget.data.title,
      contact: widget.data.contact,
      price: widget.data.price,
      description: widget.data.description,
      brand: widget.data.brand,
      model: widget.data.model,
      usage: widget.data.usage,
      itemCondition: widget.data.itemCondition,
      addressLine1: widget.data.addressLine1,
      addressLine2: widget.data.addressLine2,
      country: widget.data.country,
      city: widget.data.city,
      location: widget.data.location,
      categoryId: post_category_id,
      subcategoryId: post_subcategory_id,
      photos: convertPathsToFiles(
        widget.data.photos,
      ), // ✅ convert to List<File>
    );

    setState(() => _isLoading = false);

    SnackBarUtil.show(
      context,
      success ? "Equipment posted successfully" : "Error posting equipment",
    );

    if (success) {
      NavigationUtil.pushAndRemoveUntil(context, HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Review & Post',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Scrollable review content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRow('Title', widget.data.title),
                      _buildRow('Contact', widget.data.contact),
                      _buildRow('Price', widget.data.price ?? ''),
                      _buildRow('Brand', widget.data.brand ?? ''),
                      _buildRow('Model', widget.data.model ?? ''),
                      _buildRow('Description', widget.data.description ?? ''),
                      const SizedBox(height: 12),
                      if (widget.data.photos.isNotEmpty)
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.data.photos.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(widget.data.photos[index]),
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Buttons fixed at bottom
              SafeArea(
                child: _isLoading
                    ? Loading()
                    : Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Back',
                              onPressed: widget.onBack,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              onPressed: submitEquipmentPost,
                              text: 'Submit',
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

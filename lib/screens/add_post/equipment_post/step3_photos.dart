import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/equipment_post_data.dart';
import '../../../util/snackbar_util.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class AddEquipmentStep3Photos extends StatefulWidget {
  final EquipmentPostData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddEquipmentStep3Photos({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<AddEquipmentStep3Photos> createState() =>
      _AddEquipmentStep3PhotosState();
}

class _AddEquipmentStep3PhotosState extends State<AddEquipmentStep3Photos> {
  final ImagePicker _picker = ImagePicker();
  final _descController = TextEditingController();

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      widget.data.photos.addAll(images.map((e) => e.path));
      setState(() {});
    }
  }

  void _nextStep() {
    if (widget.data.photos.isEmpty) {
      SnackBarUtil.show(context, 'Please add at least one photo.');
      return;
    }
    widget.data.description = _descController.text.trim();
    widget.onNext();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Photos & Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: widget.data.photos.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.data.photos.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  height: 180,
                                  width: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(widget.data.photos[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.data.photos.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.black38,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Add Product Images',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Description field
              CustomTextField(
                controller: _descController,
                hint: 'Add description for your equipment',
                maxLines: 4,
                prefixIcon: const Icon(Icons.description),
              ),

              const Spacer(),

              // Buttons fixed at bottom
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Back',
                        onPressed: widget.onBack,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(text: 'Next', onPressed: _nextStep),
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

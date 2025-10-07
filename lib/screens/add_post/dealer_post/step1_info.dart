import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/dealer_post_data.dart';
import '../../../util/snackbar_util.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class AddDealerStep1Info extends StatefulWidget {
  final DealerPostData data;
  final VoidCallback onNext;

  const AddDealerStep1Info({Key? key, required this.data, required this.onNext})
    : super(key: key);

  @override
  State<AddDealerStep1Info> createState() => _AddDealerStep1InfoState();
}

class _AddDealerStep1InfoState extends State<AddDealerStep1Info> {
  final _picker = ImagePicker();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  Future<void> _pickLogo() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => widget.data.logo = File(image.path));
    }
  }

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        widget.data.photos = List<String>.from(widget.data.photos ?? []);
        widget.data.photos.addAll(images.map((e) => e.path));
      });
    }
  }

  void _nextStep() {
    if (_nameController.text.trim().isEmpty) {
      SnackBarUtil.show(context, "Please enter dealer name.");
      return;
    }

    widget.data.title = _nameController.text.trim();
    widget.data.description = _descController.text.trim();
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dealer Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _nameController,
                  hint: 'Dealer Name',
                  prefixIcon: const Icon(Icons.store),
                ),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: _pickLogo,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: widget.data.logo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              widget.data.logo!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.black38,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Add Logo',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

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
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.data.photos.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(widget.data.photos[index]),
                                      height: 180,
                                      width: 150,
                                      fit: BoxFit.cover,
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
                                      child: const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.black54,
                                        child: Icon(
                                          Icons.close,
                                          size: 16,
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

                CustomTextField(
                  controller: _descController,
                  hint: 'Description',
                  maxLines: 3,
                  prefixIcon: const Icon(Icons.description),
                ),

                const SizedBox(height: 80), // Give space for button
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(text: 'Next', onPressed: _nextStep),
          ),
        ),
      ),
    );
  }
}

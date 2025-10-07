import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/db/constants.dart';

import '../../../models/job_post_data.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class AddJobStep2CompanyInfo extends StatefulWidget {
  final JobPostData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddJobStep2CompanyInfo({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<AddJobStep2CompanyInfo> createState() => _AddJobStep2CompanyInfoState();
}

class _AddJobStep2CompanyInfoState extends State<AddJobStep2CompanyInfo> {
  late final TextEditingController _companyController;
  late final TextEditingController _locationController;
  late final TextEditingController _countryController;

  File? _logoImage; // selected image

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _companyController = TextEditingController(text: widget.data.companyName);
    _locationController = TextEditingController(
      text: widget.data.location != '' ? widget.data.location : post_emirate,
    );
    _countryController = TextEditingController(
      text: widget.data.country != '' ? widget.data.country : post_country,
    );
  }

  @override
  void dispose() {
    _companyController.dispose();
    _locationController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // or ImageSource.camera
      maxWidth: 500,
      maxHeight: 500,
    );

    if (pickedFile != null) {
      setState(() {
        _logoImage = File(pickedFile.path);
      });

      widget.data.logoUrl = pickedFile.path; // store local path for now
    }
  }

  void _nextStep() {
    widget.data.companyName = _companyController.text.trim();
    widget.data.location = _locationController.text.trim();
    widget.data.country = _countryController.text.trim();
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
                'Company Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _companyController,
                hint: 'Company Name',
                prefixIcon: const Icon(Icons.apartment, color: Colors.black54),
              ),
              const SizedBox(height: 12),

              // Logo picker
              GestureDetector(
                onTap: _pickLogo,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: _logoImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_logoImage!, fit: BoxFit.cover),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.black38,
                            ),
                            const SizedBox(height: 5),

                            Text(
                              'Add Logo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _locationController,
                hint: 'Location (city)',
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _countryController,
                hint: 'Country',
                prefixIcon: const Icon(Icons.flag, color: Colors.black54),
              ),

              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(text: 'Back', onPressed: widget.onBack),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(text: 'Next', onPressed: _nextStep),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

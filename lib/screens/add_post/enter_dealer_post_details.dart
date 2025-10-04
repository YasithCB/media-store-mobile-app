import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/api/dealer_post_api.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';
import 'package:mobile_app/widgets/loading_button.dart';

import '../../db/constants.dart';

class EnterDealerPostDetails extends StatefulWidget {
  const EnterDealerPostDetails({super.key});

  @override
  State<EnterDealerPostDetails> createState() => _EnterDealerPostDetailsState();
}

class _EnterDealerPostDetailsState extends State<EnterDealerPostDetails> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _startingPriceController = TextEditingController();
  final _establishedYearController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _serviceController = TextEditingController();
  final _tagController = TextEditingController();

  bool _isLoading = false;

  List<String> _servicesList = [];
  List<String> _tagsList = [];

  File? _logo;
  List<XFile> _photos = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickLogo() async {
    final XFile? pickedLogo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // forces JPEG
    );
    if (pickedLogo != null) {
      setState(() {
        _logo = File(pickedLogo.path);
      });
    }
  }

  Future<void> pickPhotos() async {
    final List<XFile>? resultList = await _picker.pickMultiImage(
      imageQuality: 80, // forces JPEG
    );

    if (resultList != null) {
      setState(() {
        _photos = resultList;
      });
    }
  }

  void _submitDealer() async {
    if (!_formKey.currentState!.validate()) return;

    final dealerData = {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "phone": _phoneController.text,
      "whatsapp": _whatsappController.text,
      "email": _emailController.text,
      "website_url": _websiteController.text,
      "established_year": _establishedYearController.text,
      "services_starting_from": _startingPriceController.text,
      "address_line1": _addressLine1Controller.text,
      "address_line2": _addressLine2Controller.text,
      "city": post_emirate,
      "country": post_country,
      "category_id": post_category_id,
      "subcategory_id": post_subcategory_id,
    };

    print("Submitting dealer: $dealerData");

    setState(() {
      _isLoading = true;
    });

    final result = await DealerPostApi.createDealerPost(
      dealerData,
      logo: _logo,
      photos: _photos.map((x) => File(x.path)).toList(),
      servicesList: _servicesList,
      tagsList: _tagsList,
    );

    print('Submitting dealer result');
    print(result);

    if (result["status"] == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Dealer created successfully")));
      NavigationUtil.pushAndRemoveUntil(context, HomeScreen());
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${result['message']}")));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Dealer"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(_nameController, "Dealer Name"),
                  const SizedBox(height: 10),
                  _buildTextField(
                    _descriptionController,
                    "Description",
                    maxLines: 4,
                  ),
                  const SizedBox(height: 10),

                  // Logo Picker
                  _logo != null
                      ? Image.file(_logo!, height: 100, fit: BoxFit.cover)
                      : SizedBox(
                          width: double.infinity, // ✅ full width
                          child: TextButton.icon(
                            onPressed: pickLogo,
                            icon: const Icon(Icons.upload),
                            label: const Text("Upload Logo"),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ), // make it taller
                              backgroundColor:
                                  Colors.grey[200], // optional background color
                              foregroundColor:
                                  Colors.black87, // icon & text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(height: 10),

                  // Photos Picker
                  _photos.isNotEmpty
                      ? SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _photos.length,
                            itemBuilder: (_, i) => Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Image.file(
                                    File(_photos[i].path),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Optional remove button
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _photos.removeAt(i);
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          width: double.infinity, // ✅ full width button
                          child: TextButton.icon(
                            onPressed: pickPhotos,
                            icon: const Icon(Icons.photo_library),
                            label: const Text("Add Photos"),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(height: 20),

                  _buildTextField(_phoneController, "Phone"),
                  const SizedBox(height: 20),

                  _buildTextField(_whatsappController, "WhatsApp"),
                  const SizedBox(height: 20),

                  _buildTextField(_emailController, "Email"),
                  const SizedBox(height: 20),

                  _buildTextField(_websiteController, "Website URL"),
                  const SizedBox(height: 20),

                  // Services Section
                  const Text(
                    "What Services Do You Offer?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  // services
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _serviceController,
                          decoration: InputDecoration(
                            hintText: "Enter a service",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          final service = _serviceController.text.trim();
                          if (service.isNotEmpty &&
                              !_servicesList.contains(service)) {
                            setState(() {
                              _servicesList.add(service);
                              _serviceController.clear();
                            });
                          }
                          print('_servicesList');
                          print(_servicesList);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Show services as tags
                  Wrap(
                    spacing: 5,
                    runSpacing: 0,
                    children: _servicesList
                        .map(
                          (service) => Chip(
                            label: Text(
                              service,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black87,
                            deleteIcon: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                            onDeleted: () {
                              setState(() {
                                _servicesList.remove(service);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // tags Section
                  const Text(
                    "Describe Your Ad with Tags",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  // tags
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _tagController,
                          decoration: InputDecoration(
                            hintText: "Enter Tag Eg: 'Offset'",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          final tag = _tagController.text.trim();
                          if (tag.isNotEmpty && !_tagsList.contains(tag)) {
                            setState(() {
                              _tagsList.add(tag);
                              _tagController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Show services as tags
                  Wrap(
                    spacing: 5,
                    runSpacing: 0,
                    children: _tagsList
                        .map(
                          (service) => Chip(
                            label: Text(
                              service,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black87,
                            deleteIcon: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                            onDeleted: () {
                              setState(() {
                                _tagsList.remove(service);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    _startingPriceController,
                    "Services Starting Price",
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    _establishedYearController,
                    "Established Year",
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(_addressLine1Controller, "Address Line 1"),
                  const SizedBox(height: 20),

                  _buildTextField(_addressLine2Controller, "Address Line 2"),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _submitDealer,
                      child: _isLoading
                          ? LoadingInButton()
                          : const Text(
                              "Add Dealer",
                              style: TextStyle(color: Colors.black87),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (val) => val == null || val.isEmpty ? "$label required" : null,
      style: TextStyle(fontSize: 13),

      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

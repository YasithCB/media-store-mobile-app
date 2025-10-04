import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/api/equipment_post_api.dart';
import 'package:mobile_app/widgets/loading_button.dart';

import '../../db/constants.dart';
import '../../util/navigation_util.dart';
import '../home_screen.dart';

class EnterPostDetails extends StatefulWidget {
  const EnterPostDetails({super.key});

  @override
  State<EnterPostDetails> createState() => _EnterPostDetailsState();
}

class _EnterPostDetailsState extends State<EnterPostDetails> {
  final _titleController = TextEditingController();
  final _contactController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _modelController = TextEditingController();
  final _brandController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();

  bool _isLoading = false;

  String? _selectedUsage;
  String? _selectedCondition;

  String? _selectedLocation;

  List<XFile> _selectedPhotos = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> pickPhotos() async {
    final List<XFile>? resultList = await _picker.pickMultiImage(
      imageQuality: 80, // forces JPEG
    );

    if (resultList != null) {
      setState(() {
        _selectedPhotos = resultList;
      });
    }
  }

  void _submitPost() async {
    setState(() {
      _isLoading = true;
    });

    final result = await EquipmentPostApi.createEquipmentPost(
      title: _titleController.text,
      contact: _contactController.text,
      categoryId: post_category_id,
      subcategoryId: post_subcategory_id,
    );

    print('Submitting createEquipmentPost result');
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
        title: const Text("You are almost there!"),
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Include as much details and pictures as possible!",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // Title Field
                _buildTextField(_titleController, "Title"),
                const SizedBox(height: 20),

                // image preview
                _selectedPhotos.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                              ),
                          itemCount: _selectedPhotos.length,
                          itemBuilder: (context, index) {
                            return Image.file(
                              File(_selectedPhotos[index].path),
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      )
                    : SizedBox(),
                const SizedBox(height: 10),

                _selectedPhotos.isNotEmpty
                    ? ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedPhotos.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text("Clear Images"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFFE00000),
                          backgroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                        ),
                      )
                    : const SizedBox.shrink(),

                const SizedBox(height: 20),

                // Add Photos Button
                ElevatedButton.icon(
                  onPressed: pickPhotos,
                  icon: const Icon(Icons.photo_camera, color: Colors.black),
                  label: const Text(
                    "Add Photos",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black87, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Contact No
                _buildTextField(_contactController, "Contact No"),

                const SizedBox(height: 20),

                // Price Field
                _buildTextField(
                  _priceController,
                  "Price (AED)",
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 20),

                // Description
                _buildTextField(
                  _descriptionController,
                  "Describe your item",
                  maxLines: 4,
                ),

                const SizedBox(height: 20),

                // Brand & Model
                _buildTextField(_brandController, "Brand"),
                const SizedBox(height: 12),
                _buildTextField(_modelController, "Model Name"),

                const SizedBox(height: 20),

                // Usage Selection
                const Text(
                  "Usage",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: usageOptions
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _buildSelectableChip(e, _selectedUsage, (
                              value,
                            ) {
                              setState(() {
                                _selectedUsage = value;
                              });
                            }),
                          ),
                        )
                        .toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // Condition Selection
                const Text(
                  "Condition",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    direction: Axis.horizontal,
                    children: conditionOptions
                        .map(
                          (e) => _buildSelectableChip(e, _selectedCondition, (
                            value,
                          ) {
                            setState(() {
                              _selectedCondition = value;
                            });
                          }),
                        )
                        .toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // Location
                _buildTextField(_addressLine1Controller, "Address Line 1"),
                const SizedBox(height: 10),

                _buildTextField(_addressLine2Controller, "Address Line 2"),

                const SizedBox(height: 20),

                // Submit Button
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _submitPost,
                    child: _isLoading
                        ? LoadingInButton()
                        : const Text(
                            "Submit Post",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
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
    TextInputType keyboardType = TextInputType.text,
    double fontSize = 13, // text size
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: fontSize),
      cursorColor: Colors.black87, // ✅ set cursor color
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(fontSize: fontSize),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: primaryColorHover2, // ✅ focus border color
            width: 2,
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: primaryColorHover2, // ✅ label color on focus
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget _buildSelectableChip(
    String label,
    String? selectedValue,
    Function(String) onSelected,
  ) {
    final isSelected = label == selectedValue;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(label),
      selectedColor: primaryColor,
      labelStyle: TextStyle(color: isSelected ? Colors.black87 : Colors.black),
      backgroundColor: Colors.yellow[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // <-- custom radius here
        side: BorderSide(color: primaryColorHover2, width: 1),
      ),
    );
  }
}

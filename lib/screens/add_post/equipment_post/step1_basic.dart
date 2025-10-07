import 'package:flutter/material.dart';

import '../../../models/equipment_post_data.dart';
import '../../../util/snackbar_util.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class AddEquipmentStep1Basic extends StatefulWidget {
  final EquipmentPostData data;
  final VoidCallback onNext;

  const AddEquipmentStep1Basic({
    Key? key,
    required this.data,
    required this.onNext,
  }) : super(key: key);

  @override
  State<AddEquipmentStep1Basic> createState() => _AddEquipmentStep1BasicState();
}

class _AddEquipmentStep1BasicState extends State<AddEquipmentStep1Basic> {
  final _titleController = TextEditingController();
  final _contactController = TextEditingController();
  final _priceController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();

  bool validateForm() {
    if (_titleController.text.isEmpty || _contactController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void _nextStep() {
    if (validateForm()) {
      widget.data.title = _titleController.text.trim();
      widget.data.contact = _contactController.text.trim();
      widget.data.price = _priceController.text.trim();
      widget.data.brand = _brandController.text.trim();
      widget.data.model = _modelController.text.trim();
      widget.onNext();
    } else {
      SnackBarUtil.show(context, 'Fill all required fields to continue!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Basic Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _titleController,
                hint: 'Equipment Title',
                prefixIcon: const Icon(Icons.build, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _contactController,
                hint: 'Contact Info',
                prefixIcon: const Icon(Icons.phone, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _priceController,
                hint: 'Price (optional)',
                prefixIcon: const Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _brandController,
                hint: 'Brand',
                prefixIcon: const Icon(
                  Icons.label_outline,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _modelController,
                hint: 'Model',
                prefixIcon: const Icon(
                  Icons.design_services_outlined,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              CustomButton(text: 'Next', onPressed: _nextStep),
            ],
          ),
        ),
      ),
    );
  }
}

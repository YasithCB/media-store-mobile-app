import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';

import '../../../models/equipment_post_data.dart';
import '../../../util/snackbar_util.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class AddEquipmentStep2Location extends StatefulWidget {
  final EquipmentPostData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddEquipmentStep2Location({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<AddEquipmentStep2Location> createState() =>
      _AddEquipmentStep2LocationState();
}

class _AddEquipmentStep2LocationState extends State<AddEquipmentStep2Location> {
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _locationController = TextEditingController();

  bool validateForm() {
    return _address1Controller.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _countryController.text.isNotEmpty;
  }

  void _nextStep() {
    if (validateForm()) {
      widget.data.addressLine1 = _address1Controller.text.trim();
      widget.data.addressLine2 = _address2Controller.text.trim();
      widget.data.city = _cityController.text.trim();
      widget.data.country = _countryController.text.trim();
      widget.data.location = _locationController.text.trim();
      widget.onNext();
    } else {
      SnackBarUtil.show(context, 'Please fill required fields.');
    }
  }

  @override
  void initState() {
    super.initState();
    _cityController.text = post_emirate;
    _countryController.text = post_country;
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
                'Location Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _address1Controller,
                hint: 'Address Line 1',
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _address2Controller,
                hint: 'Address Line 2 (optional)',
              ),
              const SizedBox(height: 12),
              CustomTextField(controller: _cityController, hint: 'City'),
              const SizedBox(height: 12),
              CustomTextField(controller: _countryController, hint: 'Country'),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _locationController,
                hint: 'Location (optional)',
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

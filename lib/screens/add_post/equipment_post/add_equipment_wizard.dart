import 'package:flutter/material.dart';
import 'package:mobile_app/screens/add_post/equipment_post/step1_basic.dart';
import 'package:mobile_app/screens/add_post/equipment_post/step2_location.dart';
import 'package:mobile_app/screens/add_post/equipment_post/step3_photos.dart';
import 'package:mobile_app/screens/add_post/equipment_post/step4_review.dart';

import '../../../db/constants.dart';
import '../../../models/equipment_post_data.dart';

class AddEquipmentWizard extends StatefulWidget {
  const AddEquipmentWizard({Key? key}) : super(key: key);

  @override
  State<AddEquipmentWizard> createState() => _AddEquipmentWizardState();
}

class _AddEquipmentWizardState extends State<AddEquipmentWizard> {
  int _currentStep = 0;
  final EquipmentPostData data = EquipmentPostData();

  void _next() => setState(() => _currentStep++);
  void _back() => setState(() => _currentStep--);

  void _submit() {
    // TODO: Send data.toJson() to backend via API
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Equipment post submitted!')));
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      AddEquipmentStep1Basic(data: data, onNext: _next),
      AddEquipmentStep2Location(data: data, onNext: _next, onBack: _back),
      AddEquipmentStep3Photos(data: data, onNext: _next, onBack: _back),
      AddEquipmentStep4Review(data: data, onSubmit: _submit, onBack: _back),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Add Equipment - Step ${_currentStep + 1} of 5',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: steps[_currentStep],
    );
  }
}

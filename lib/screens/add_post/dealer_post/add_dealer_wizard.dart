import 'package:flutter/material.dart';
import 'package:mobile_app/screens/add_post/dealer_post/step1_info.dart';
import 'package:mobile_app/screens/add_post/dealer_post/step2_contact.dart';
import 'package:mobile_app/screens/add_post/dealer_post/step3_address.dart';
import 'package:mobile_app/screens/add_post/dealer_post/step4_services.dart';
import 'package:mobile_app/screens/add_post/dealer_post/step5_details.dart';
import 'package:mobile_app/screens/add_post/dealer_post/step6_review.dart';

import '../../../db/constants.dart';
import '../../../models/dealer_post_data.dart';

class AddDealerWizard extends StatefulWidget {
  const AddDealerWizard({Key? key}) : super(key: key);

  @override
  State<AddDealerWizard> createState() => _AddDealerWizardState();
}

class _AddDealerWizardState extends State<AddDealerWizard> {
  int _currentStep = 0;
  final DealerPostData _data = DealerPostData();

  void _nextStep() => setState(() => _currentStep++);
  void _backStep() => setState(() => _currentStep--);

  @override
  Widget build(BuildContext context) {
    final steps = [
      AddDealerStep1Info(data: _data, onNext: _nextStep),
      AddDealerStep2Contact(data: _data, onNext: _nextStep, onBack: _backStep),
      AddDealerStep3Address(data: _data, onNext: _nextStep, onBack: _backStep),
      AddDealerStep4Services(data: _data, onNext: _nextStep, onBack: _backStep),
      AddDealerStep5Details(data: _data, onNext: _nextStep, onBack: _backStep),
      AddDealerStep6Review(data: _data, onBack: _backStep),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Add Dealer - Step ${_currentStep + 1} of 6',
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

import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/models/job_post_data.dart';
import 'package:mobile_app/screens/add_post/job_post/step1_job_info.dart';
import 'package:mobile_app/screens/add_post/job_post/step2_company_info.dart';
import 'package:mobile_app/screens/add_post/job_post/step3_details.dart';
import 'package:mobile_app/screens/add_post/job_post/step4_description_contact.dart';
import 'package:mobile_app/screens/add_post/job_post/step5_review.dart';

class AddJobWizard extends StatefulWidget {
  const AddJobWizard({Key? key}) : super(key: key);

  @override
  _AddJobWizardState createState() => _AddJobWizardState();
}

class _AddJobWizardState extends State<AddJobWizard> {
  final PageController _pageController = PageController();
  final JobPostData data = JobPostData();
  int _currentStep = 0;

  void _next() {
    if (_currentStep < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _back() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _onPageChanged(int idx) => setState(() => _currentStep = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Add Job - Step ${_currentStep + 1} of 5',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(), // control via buttons
        children: [
          AddJobStep1JobInfo(
            data: data,
            onNext: () => _next(),
            onBack: () => _back(),
          ),
          AddJobStep2CompanyInfo(
            data: data,
            onNext: () => _next(),
            onBack: () => _back(),
          ),
          AddJobStep3Details(
            data: data,
            onNext: () => _next(),
            onBack: () => _back(),
          ),
          AddJobStep4DescriptionContact(
            data: data,
            onNext: () => _next(),
            onBack: () => _back(),
          ),
          AddJobStep5Review(
            data: data,
            onBack: () => _back(),
            onSubmit: () {
              // TODO: Call API to create job_post using data
              Navigator.pop(context); // close wizard after submit
            },
          ),
        ],
      ),
    );
  }
}

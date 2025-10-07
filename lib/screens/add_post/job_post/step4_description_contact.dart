import 'package:flutter/material.dart';

import '../../../models/job_post_data.dart';
import '../../../util/snackbar_util.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class AddJobStep4DescriptionContact extends StatefulWidget {
  final JobPostData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddJobStep4DescriptionContact({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<AddJobStep4DescriptionContact> createState() =>
      _AddJobStep4DescriptionContactState();
}

class _AddJobStep4DescriptionContactState
    extends State<AddJobStep4DescriptionContact> {
  late final TextEditingController _descController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _applyUrlController;

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController(text: widget.data.description);
    _emailController = TextEditingController(text: widget.data.email);
    _phoneController = TextEditingController(text: widget.data.phone);
    _applyUrlController = TextEditingController(
      text: widget.data.applicationUrl,
    );
  }

  @override
  void dispose() {
    _descController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _applyUrlController.dispose();
    super.dispose();
  }

  bool validateForm() {
    if (_descController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _applyUrlController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void _nextStep() {
    if (validateForm()) {
      widget.data.description = _descController.text.trim();
      widget.data.email = _emailController.text.trim();
      widget.data.phone = _phoneController.text.trim();
      widget.data.applicationUrl = _applyUrlController.text.trim();
      widget.onNext();
    } else {
      SnackBarUtil.show(context, 'Fill all fields to continue!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description & Contact',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: _descController,
                          hint: 'Job Description',
                          maxLines: 6,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: _emailController,
                          hint: 'Email',
                          prefixIcon: const Icon(
                            Icons.alternate_email,
                            color: Colors.black54,
                            size: 20,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: _phoneController,
                          hint: 'Phone',
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black54,
                            size: 20,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: _applyUrlController,
                          hint: 'Application URL',
                          prefixIcon: const Icon(
                            Icons.link,
                            color: Colors.black54,
                            size: 20,
                          ),
                          keyboardType: TextInputType.url,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                Row(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

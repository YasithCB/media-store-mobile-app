import 'package:flutter/material.dart';
import 'package:mobile_app/models/job_post_data.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class AddJobStep1JobInfo extends StatefulWidget {
  final JobPostData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddJobStep1JobInfo({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<AddJobStep1JobInfo> createState() => _AddJobStep1JobInfoState();
}

class _AddJobStep1JobInfoState extends State<AddJobStep1JobInfo> {
  late final TextEditingController _titleController;
  late final TextEditingController _industryController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.data.title);
    _industryController = TextEditingController(text: widget.data.industry);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _industryController.dispose();
    super.dispose();
  }

  void _nextStep() {
    widget.data.title = _titleController.text.trim();
    widget.data.industry = _industryController.text.trim();
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
                'Job Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _titleController,
                hint: 'Job Title',
                prefixIcon: const Icon(Icons.work, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _industryController,
                hint: 'Industry',
                prefixIcon: const Icon(Icons.business, color: Colors.black54),
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

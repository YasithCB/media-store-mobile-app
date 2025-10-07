import 'package:flutter/material.dart';

import '../../../models/job_post_data.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class AddJobStep3Details extends StatefulWidget {
  final JobPostData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddJobStep3Details({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<AddJobStep3Details> createState() => _AddJobStep3DetailsState();
}

class _AddJobStep3DetailsState extends State<AddJobStep3Details> {
  late final TextEditingController _salaryController;
  late final TextEditingController _tagsController;

  String? _salaryType;
  String? _experience;
  String? _jobType;
  bool _remote = false;
  bool _isHiring = true;

  @override
  void initState() {
    super.initState();
    _salaryController = TextEditingController(text: widget.data.salary);
    _tagsController = TextEditingController(text: widget.data.tags.join(','));
    _salaryType = widget.data.salaryType.isEmpty
        ? null
        : widget.data.salaryType;
    _experience = widget.data.experienceLevel.isEmpty
        ? null
        : widget.data.experienceLevel;
    _remote = widget.data.remote;
    _isHiring = widget.data.isHiring;
  }

  @override
  void dispose() {
    _salaryController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _nextStep() {
    widget.data.salary = _salaryController.text.trim();
    widget.data.salaryType = _salaryType ?? '';
    widget.data.jobType = _jobType ?? '';
    widget.data.experienceLevel = _experience ?? '';
    widget.data.tags = _tagsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    widget.data.remote = _remote;
    widget.data.isHiring =
        _isHiring; // note: typo safe - will correct below in JSON
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
                'Job Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: _salaryController,
                        hint: 'Salary (e.g. 1000 - 2000)',
                        prefixIcon: const Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.black54,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _salaryType,
                        decoration: const InputDecoration(
                          labelText: 'Salary Type',
                        ),
                        items: ['Monthly', 'Yearly', 'Hourly']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _salaryType = v),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _experience,
                        decoration: const InputDecoration(
                          labelText: 'Experience Level',
                        ),
                        items: ['Entry', 'Mid', 'Senior']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _experience = v),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _jobType,
                        decoration: const InputDecoration(
                          labelText: 'Job Type',
                        ),
                        items: ['Full-Time', 'Part-Time', 'Contract']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _jobType = v),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _tagsController,
                        hint: 'Tags (comma separated)',
                        prefixIcon: const Icon(
                          Icons.label_outline,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              value: _remote,
                              onChanged: (v) =>
                                  setState(() => _remote = v ?? false),
                              title: const Text('Remote'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

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

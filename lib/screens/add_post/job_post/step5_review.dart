import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/api/job_post_api.dart';
import 'package:mobile_app/db/constants.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/util/navigation_util.dart';

import '../../../models/job_post_data.dart';
import '../../../widgets/custom_button.dart';

class AddJobStep5Review extends StatefulWidget {
  final JobPostData data;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const AddJobStep5Review({
    Key? key,
    required this.data,
    required this.onBack,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AddJobStep5Review> createState() => _AddJobStep5ReviewState();
}

class _AddJobStep5ReviewState extends State<AddJobStep5Review> {
  bool _isLoading = false;

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildLogoPreview() {
    if (widget.data.logoUrl == null || widget.data.logoUrl!.isEmpty) {
      return const SizedBox();
    }

    final isFile = File(widget.data.logoUrl!).existsSync();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: isFile
              ? Image.file(
                  File(widget.data.logoUrl!),
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  widget.data.logoUrl!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
        ),
      ),
    );
  }

  Future<void> submitJobPost() async {
    setState(() => _isLoading = true);

    bool success = await JobPostApi.createJobPost(
      title: widget.data.title,
      companyName: widget.data.companyName,
      logo: widget.data.logoUrl,
      location: widget.data.location,
      country: widget.data.country,
      jobType: widget.data.jobType,
      industry: widget.data.industry,
      experienceLevel: widget.data.experienceLevel,
      salary: widget.data.salary,
      salaryType: widget.data.salaryType,
      description: widget.data.description,
      expiryDate: widget.data.expiryDate,
      email: widget.data.email,
      phone: widget.data.phone,
      applicationUrl: widget.data.applicationUrl,
      remote: widget.data.remote,
      isHiring: widget.data.isHiring,
      tags: widget.data.tags,
      categoryId: post_category_id,
      subcategoryId: post_subcategory_id,
    );

    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "Job posted successfully" : "Error posting job",
        ),
      ),
    );

    if (success) {
      widget.onSubmit(); // call parent callback
      NavigationUtil.pushAndRemoveUntil(context, HomeScreen());
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
                const Text(
                  'Review & Post',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLogoPreview(),
                        _buildRow('Title', widget.data.title),
                        _buildRow('Company', widget.data.companyName),
                        _buildRow('Industry', widget.data.industry),
                        _buildRow('Location', widget.data.location),
                        _buildRow('Salary', widget.data.salary),
                        _buildRow('Email', widget.data.email),
                      ],
                    ),
                  ),
                ),

                _isLoading
                    ? CircularProgressIndicator(color: Colors.black54)
                    : Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Back',
                              onPressed: widget.onBack,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              onPressed: submitJobPost,
                              text: 'Submit',
                            ),
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

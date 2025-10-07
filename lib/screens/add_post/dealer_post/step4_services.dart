import 'package:flutter/material.dart';

import '../../../models/dealer_post_data.dart';
import '../../../widgets/custom_button.dart';

class AddDealerStep4Services extends StatefulWidget {
  final DealerPostData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AddDealerStep4Services({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<AddDealerStep4Services> createState() => _AddDealerStep4ServicesState();
}

class _AddDealerStep4ServicesState extends State<AddDealerStep4Services> {
  final TextEditingController _serviceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Services",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _serviceController,
                  decoration: InputDecoration(
                    labelText: 'Add Service',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (_serviceController.text.isNotEmpty) {
                          setState(() {
                            widget.data.services ??= [];
                            widget.data.services!.add(_serviceController.text);
                            _serviceController.clear();
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Wrap(
                  spacing: 8,
                  children:
                      widget.data.services
                          ?.map((e) => Chip(label: Text(e)))
                          .toList() ??
                      [],
                ),
                const SizedBox(height: 16),

                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Starting From (price or description)',
                  ),
                  onChanged: (v) => widget.data.servicesStartingFrom = v,
                ),
                const SizedBox(height: 80), // space for button
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(text: "Back", onPressed: widget.onBack),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomButton(text: "Next", onPressed: widget.onNext),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

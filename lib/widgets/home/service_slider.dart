import 'package:flutter/material.dart';
import 'package:mobile_app/models/service_model.dart';

import '../service_card.dart';

class ServiceSlider extends StatelessWidget {
  final List<ServiceModel> list;

  const ServiceSlider({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 10),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ServiceCard(service: item),
          );
        },
      ),
    );
  }
}

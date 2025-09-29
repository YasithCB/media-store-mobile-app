import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';

import '../../db/services_data.dart';

class CategoryIcons extends StatelessWidget {
  const CategoryIcons({super.key});

  static const Map<String, IconData> serviceIcons = {
    "Branding": Icons.directions_car,
    "Interior Fitouts": Icons.chair,
    "Digital Printing": Icons.print,
    "Billboard & Signage": Icons.business,
    "Digital Solutions": Icons.computer,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        // === Categories row (5 icons) ===
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categoryList.map((service) {
            return Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // todo
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                      child: Icon(
                        serviceIcons[service.name] ?? Icons.category,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

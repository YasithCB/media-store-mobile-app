import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ needed for SystemUiOverlayStyle
import 'package:mobile_app/db/constants.dart';

import '../../db/services_data.dart';
import '../../widgets/service_card.dart';

class ServicesTab extends StatefulWidget {
  const ServicesTab({super.key});

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  String selectedLocation = "Dubai";
  String selectedSort = "Popularity";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(5), // set your desired height
        child: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      body: Column(
        children: [
          // Top section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
              image: const DecorationImage(
                image: AssetImage("assets/logo-icon-black.webp"),
                fit: BoxFit.contain,
                alignment: Alignment.center,
                opacity: 0.1,
              ),
            ),

            child: Column(
              children: [
                // Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left column
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, color: Colors.black87),
                        const SizedBox(width: 4),
                        DropdownButton<String>(
                          value: selectedLocation,
                          underline: const SizedBox(),
                          iconEnabledColor: Colors.black87,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          items:
                              <String>[
                                'Dubai',
                                'Abu Dhabi',
                                'Sharjah',
                                'Ajman',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocation = newValue!;
                            });
                          },
                        ),
                      ],
                    ),

                    // Right column (notification icon)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Second row: search + filter
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.black54),
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.filter_list, color: Colors.black54),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),

          // Top row with count & sort
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${allServices.length} Services",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text("Sort by:", style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: selectedSort,
                      underline: const SizedBox(),
                      items:
                          <String>[
                                "Popularity",
                                "Price Low to High",
                                "Price High to Low",
                                "Rating",
                              ]
                              .map(
                                (sort) => DropdownMenuItem(
                                  value: sort,
                                  child: Text(sort),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSort = value!;
                          // Implement sorting logic here if needed
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Services grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                itemCount: allServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // two items per row
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75, // adjust card height
                ),
                itemBuilder: (context, index) {
                  return ServiceCard(service: allServices[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

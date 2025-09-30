import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    const double normalIconSize = 24;
    const double centerIconSize = 35;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTabSelected,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: primaryColorHover,
          unselectedItemColor: Colors.black54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.content_paste_search),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(), // placeholder for center button
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
        ),

        // Floating center button
        Positioned(
          top: -10,
          child: GestureDetector(
            onTap: () => onTabSelected(2),
            child: Container(
              height: centerIconSize + 15,
              width: centerIconSize + 15,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.add_box_outlined, // plus icon
                  color: Colors.black54,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

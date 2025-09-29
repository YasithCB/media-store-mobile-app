import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/screens/tabs/home_tab.dart';
import 'package:mobile_app/screens/tabs/tab_2.dart';
import 'package:mobile_app/screens/tabs/tab_3.dart';
import 'package:mobile_app/screens/tabs/tab_4.dart';
import 'package:mobile_app/screens/tabs/tab_5.dart';

import '../db/constants.dart';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // default to middle Services tab

  final List<Widget> _pages = [HomeTab(), Tab2(), Tab3(), Tab4(), Tab5()];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // 📏 Get device width & height
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor, // your desired color
        statusBarIconBrightness: Brightness.dark, // icons color (light/dark)
      ),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(5), // set your desired height
        child: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),

      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

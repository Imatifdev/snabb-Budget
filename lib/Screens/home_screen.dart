// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/daily_stats.dart';
import 'package:snabbudget/Screens/dashboard_screen.dart';
import 'package:snabbudget/Screens/profile_screen.dart';

import '../utils/custom_bottombar.dart';
import '../utils/expandable_fab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home-screen";
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late PageController _pageController;
  final List<Widget> _pages = [
    DashboardScreen(),
    const DailyStats(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const ExpandableFloatingActionButton(),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
          });
        },
      ),
    );
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:loginsit/StudentPages/ProfilePage.dart';
import 'package:loginsit/StudentPages/SettingsPage.dart';
import 'package:loginsit/StudentPages/StudentHome.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int pageIndex = 0;
  final List<Widget> _pages = [
    StudentHome(),
    StudentProfilePage(),
    SettingsPage(),
  ];
  List<Color> _navBarColors = [
    Colors.yellowAccent.shade200,
    Colors.yellowAccent.shade200,
    Colors.yellowAccent.shade200,
  ];
  List<Color> _background = [
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  List<Color> _iconColors = [
    Colors.red.shade900, // Home initially selected
    Colors.white,
    Colors.white,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: _background[pageIndex],
        color: _navBarColors[pageIndex],
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(
            Icons.home,
            color: _iconColors[0],
          ),
          Icon(
            Icons.favorite,
            color: _iconColors[1],
          ),
          Icon(
            Icons.settings,
            color: _iconColors[2],
          ),
        ],
        onTap: (index) {
          setState(() {
            pageIndex = index;
            // Update navigation bar color based on the selected page
            _navBarColors = [
              Colors.yellowAccent.shade200,
              Colors.lightBlueAccent, // Change color for FavoritePage
              Colors.blueGrey,
            ];
            _background = [
              Colors.white,
              Colors.white, // Change color for FavoritePage
              Colors.white,
            ];
            _iconColors = [
              Colors.white,
              Colors.white,
              Colors.white,
            ];
            _iconColors[index] = Colors.red.shade900;
          });
        },
      ),
    );
  }
}

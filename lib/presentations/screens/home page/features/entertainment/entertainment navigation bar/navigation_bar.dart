import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/presentations/screens/home%20page/features/entertainment/efavorite.dart';
import 'package:camdell/presentations/screens/home%20page/features/entertainment/entertainment%20navigation%20bar/navigation_widget.dart';
import 'package:camdell/presentations/screens/home%20page/features/entertainment/entertainment_screen.dart';
import 'package:camdell/presentations/screens/home%20page/features/entertainment/esearch.dart';
import 'package:camdell/presentations/screens/home%20page/features/entertainment/eshows_page.dart';
import 'package:flutter/material.dart';

class ENavigationBar extends StatefulWidget {
  const ENavigationBar({super.key});

  @override
  State<ENavigationBar> createState() => _ENavigationBarState();
}

class _ENavigationBarState extends State<ENavigationBar> {
  int _selectedIndex = 0;


   static const List<Widget> _widgetOptions = <Widget>[
    EntertainmentScreen(),
    Esearch(),
    EshowsPage(),
    Efavorite(),

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: EntertainmentNavbar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
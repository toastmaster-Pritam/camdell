import 'package:camdell/presentations/screens/home%20page/features/payment/payment%20navigationbar/paymentnav_widget.dart';
import 'package:camdell/presentations/screens/home%20page/features/payment/payment%20navigationbar/phistory_page.dart';
import 'package:camdell/presentations/screens/home%20page/features/payment/payment%20navigationbar/phome_page.dart';
import 'package:camdell/presentations/screens/home%20page/features/payment/payment%20navigationbar/pnotification.dart';
import 'package:flutter/material.dart';

class PaymentNavigationbar extends StatefulWidget {
  const PaymentNavigationbar({super.key});

  @override
  State<PaymentNavigationbar> createState() => _PaymentNavigationbarState();
}

class _PaymentNavigationbarState extends State<PaymentNavigationbar> {
  int _selectedIndex = 0;


   static const List<Widget> _widgetOptions = <Widget>[
   PhomePage(),
    PHistoryPage( ),
    PNotificationPage()


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
            child: PaymentnavWidget(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:async';

import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/presentations/screens/auth/auth_services/social%20media%20login/facebook_auth.dart';
import 'package:camdell/presentations/screens/auth/auth_services/social%20media%20login/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AppNavbar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AppNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<AppNavbar>  createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  late List<String> carSearchImages;
  int currentCarSearchImageIndex = 0;
  late Timer _timer;
  final controller = Get.put(GoogleAuthController());
   final AuthController authController = Get.put(AuthController());


  @override
  void initState() {
    super.initState();
  Future.delayed(const Duration(seconds: 10), () {

  setState(() async {
await controller.logout();
await authController.logout();
  });

});
    carSearchImages = [
      AppImage.carsearch,
      AppImage.ride,
      AppImage.homeicon,
      AppImage.list
    ];
    _startImageCycling();
  }
 @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startImageCycling() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentCarSearchImageIndex = (currentCarSearchImageIndex + 1) % carSearchImages.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: Responsive.doubleR(context, mobile: 55, desktop: 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(AppImage.homeicon, 0),
            _buildNavItem(AppImage.ride, 1),
            _buildNavItem(carSearchImages[currentCarSearchImageIndex], 2),
            _buildNavItem(AppImage.list, 3),
            _buildNavItem(AppImage.setting, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, int index) {
    final isSelected = widget.selectedIndex == index;
    return IconButton(
      icon: Image.asset(
        icon,
        height: 25,
        width: 25,
        color: isSelected ? AppColor.black : Colors.grey,
      ),
      onPressed: () => widget.onItemTapped(index),
    );
  }
}
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:flutter/material.dart';


class PaymentnavWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const PaymentnavWidget({super.key, required this.selectedIndex, required this.onItemTapped});
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
            _buildNavItem(AppImage.ehome, 0),
            _buildNavItem(AppImage.history, 1),
            _buildNavItem(AppImage.notification, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, int index) {
    final isSelected = selectedIndex == index;
    return IconButton(
      icon: Image.asset(
        icon,
        height: 25,
        width: 25,
        color: isSelected ? AppColor.black : Colors.grey,
      ),
      onPressed: () => onItemTapped(index),
    );
  }
}

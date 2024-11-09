import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_text.dart';
import '../../meta/utils/ts.dart';

class PaymentButton extends StatelessWidget {
  final String imagepath;
  final String cardNumber;
  final VoidCallback? onTap;
  const PaymentButton({super.key, required this.imagepath, required this.cardNumber, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(imagepath, width: 30, height: 30),
                const Wbox(12),
                AppText(
                  cardNumber,
                  style: Ts.semiBold16(color: AppColor.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
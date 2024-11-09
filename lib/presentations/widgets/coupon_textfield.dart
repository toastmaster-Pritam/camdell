import 'package:flutter/material.dart';

import '../../core/constants/app_button.dart';
import '../../meta/utils/app_color.dart';
import '../../meta/utils/responsive.dart';
import '../../meta/utils/ts.dart';

class CouponCodeWidget extends StatelessWidget {
  final Function(String) onApply;

  const CouponCodeWidget({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return  _buildWideLayout(context);
            
      },
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildTextField()),
        const SizedBox(width: 16),
        _buildApplyButton(context),
      ],
    );
  }

  // Widget _buildNarrowLayout() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       _buildTextField(),
  //       const SizedBox(height: 16),
  //       _buildApplyButton(),
  //     ],
  //   );
  // }

  Widget _buildTextField() {
    return SizedBox(
      height: 45,
      child: TextField(
        cursorColor: AppColor.black,
        decoration: InputDecoration(
          hintText: 'Enter Coupon Code',
          hintStyle:  Ts.regular15(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.black, width: 1.0),
          ),
          
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppButton(
                      bgColor: AppColor.blue900,
                      onPressed: () => onApply('COUPON_CODE'),
                      text: 'Apply',
                      elevation: 0,
                      height: 45,
                      horizontalPadding: Responsive.doubleR(context, mobile: 20, desktop: 25, tablet: 30),
                      isFullWidth: false,
                      borderRadius: 10,
                      textColor: AppColor.white,
                    ),
    );
  }
}
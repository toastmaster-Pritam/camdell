import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermanentDeactivate extends StatefulWidget {
  const PermanentDeactivate({super.key});

  @override
  State<PermanentDeactivate> createState() => _PermanentDeactivateState();
}

class _PermanentDeactivateState extends State<PermanentDeactivate> {
  int? _selectedIndex;

  final List<String> _reasons = [
    "I'm leaving temporary",
    "I'm on CAMDELL too much",
    "Safety and Privacy Concerns",
    "Trouble getting Started",
    "I have multiple accounts",
    "Another reason",
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("Deactivate Account", style: Ts.semiBold20(color: AppColor.white),),
    onBackPressed: () => Get.back(),
    body: LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Why are you leaving CAMDELL?',
                style: Ts.bold13(color: AppColor.black),
              ),
              const SizedBox(height: 16),
              Text(
                "We're sad to see you go! We'd love to know why you want to delete your account, so we can improve the app and support our community.",
                style: Ts.semiBold10(color: AppColor.black),
              ),
              const Hbox(24),
              ..._reasons.asMap().entries.map((entry) {
                final index = entry.key;
                final reason = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildReasonCard(index, reason),
                );
              }),
              Hbox(screenHeight(context) * 0.05),
             Padding(
             padding: const EdgeInsets.all(16),
             child: AppButton(
              text: "Continue",
              textColor: AppColor.white,
              onPressed: ()=> Get.toNamed(AppRoute.deleteAccount2),
              isFullWidth: true,
             ),
           ),
           
            ],
          ),
        );
      },
    )
    );
  }

  Widget _buildReasonCard(int index, String reason) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(child: Text(reason,style:Ts.regular10(color: AppColor.black),)),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.red : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? Colors.red : Colors.transparent,
              ),
            ),
          ],
        ),
      ),);
  }
}
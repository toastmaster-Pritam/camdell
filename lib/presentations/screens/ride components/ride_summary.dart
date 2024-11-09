import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideSummary extends StatefulWidget {
  const RideSummary({super.key});

  @override
  State<RideSummary> createState() => _RideSummaryState();
}

class _RideSummaryState extends State<RideSummary> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: const AppText(""),
     backIcon: Icons.arrow_back,
     chat: false,
     onBackPressed: () => Get.back(),
     body: Center(
       child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImage.precise), fit: BoxFit.cover),
        ),
       ),
     ),);

  }
}
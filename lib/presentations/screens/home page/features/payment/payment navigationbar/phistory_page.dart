import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class PHistoryPage extends StatefulWidget {
  const PHistoryPage({super.key});

  @override
  State<PHistoryPage> createState() => _PHistoryPageState();
}

class _PHistoryPageState extends State<PHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("History", style: Ts.semiBold20(color: AppColor.white),), body: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: _wtransactions(),
        ),
      ),
    )
    );
  }

  Widget _wtransactions() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(AppImage.tprofile),
        ),
        title: AppText('Emma', style: Ts.semiBold16(color: AppColor.white)),
        subtitle: AppText('29th, august, 2024 at 8:00am', style: Ts.semiBold11()),
        trailing: AppText('\$100', style: Ts.semiBold11(color: AppColor.white)),
      ),
      separatorBuilder: (context, index) => const Hbox(16),
      itemCount: 15,
    );
  }
}


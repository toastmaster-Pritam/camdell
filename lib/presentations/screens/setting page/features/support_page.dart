
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/setting%20page/model/profile_model.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("Support", style: Ts.semiBold20(color: AppColor.white),),
    onBackPressed: () => Get.back(),
    chat: false,
    backIcon: Icons.arrow_back,
    body: Center(child: Padding(padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText("Security", style: Ts.regular14(color: AppColor.grey),),
              const Hbox(10),
              CardWidget(iconVisible: false, onPressed: () {}, title: "Help Center",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
              CardWidget( iconVisible: false,onPressed: (){} , title: "Safety Center",),
              CardWidget(iconVisible: false, onPressed: () {}, title: "Privacy Center",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
       
      ],
    ),
    ))
    );
  }
}
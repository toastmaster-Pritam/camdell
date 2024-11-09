
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/setting%20page/model/profile_model.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("Security", style: Ts.semiBold20(color: AppColor.white),),
    onBackPressed: () => Get.back(),
    chat: false,
    backIcon: Icons.arrow_back,
     body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Security", style: Ts.regular14(color: AppColor.grey),),
              const Hbox(10),
              CardWidget(iconVisible: false, onPressed: () {}, title: "Security alerts",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
              CardWidget( iconVisible: false,onPressed: (){} , title: "Manage devices",),
              CardWidget(iconVisible: false, onPressed: () {}, title: "2-step verification",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
               const Hbox(15),
            AppText("Permission", style: Ts.regular14(color: AppColor.grey),),
            const Hbox(10),
             CardWidget(iconVisible: false, onPressed: () {}, title: "Apps and services permissions",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
             CardWidget(iconVisible: false, onPressed: () {}, title: "Browser settings",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
          ],
        ),
      ),)
     );
  }
}
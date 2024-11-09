import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/profile_model.dart';


class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
   return AppScaffold(title: AppText("Language", style: Ts.semiBold20(color: AppColor.white),),
    onBackPressed: () => Get.back(),
    chat: false,
    backIcon: Icons.arrow_back,
    body: Center(child: Padding(padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText("Language", style: Ts.regular14(color: AppColor.grey),),
              const Hbox(10),
              CardWidget(iconVisible: false, onPressed: () {}, title: "Always Translate",
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
              switchVisible: true,),
              CardWidget( iconVisible: false,onPressed: (){} , title: "App Language",subtitle: "Select your default app language",trailingText: "English (US)",),
              CardWidget(iconVisible: false, onPressed: () {}, title: "Translate into",
              trailingText: "English",
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
       
      ],
    ),
    ))
    );
  }
}
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/setting%20page/model/profile_model.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("Profile", style: Ts.semiBold20(color: AppColor.white),),
    onBackPressed: () => Get.back(),
    
     body: Center(
       child: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Account Information", style: Ts.regular14(color: AppColor.grey),),
            const Hbox(10),
            CardWidget(iconVisible: false, onPressed: () {}, title: "Phone Number",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
            CardWidget( iconVisible: false,onPressed: (){}, title: "Email",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
             const Hbox(15),
            AppText("Password", style: Ts.regular14(color: AppColor.grey),),
            const Hbox(10),
            CardWidget( iconVisible: false,onPressed: (){}, title: "**********",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),),
             const Hbox(15),
             AppText("Deactivate or Delete account", style: Ts.regular14(color: AppColor.grey),),
            const Hbox(10),
            CardWidget(iconVisible: false, onPressed: () => Get.toNamed(AppRoute.deactivate), title: "Deactivate account",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
            CardWidget( iconVisible: false,onPressed: () => Get.toNamed(AppRoute.deleteAccount), title: "Permanently delete account",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
             const Hbox(15),
          ],
         ),
       ),
     ));
  }
}
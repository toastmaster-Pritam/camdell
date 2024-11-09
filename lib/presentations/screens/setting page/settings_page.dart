import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/presentations/screens/setting%20page/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppText(
        "Settings",
        style: Ts.semiBold20(color: AppColor.white),
      ),
      chat: true,
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           UserProfileCard(
              name: 'Jack benible',
              email: 'to***@***.com',
              id: '12345678',
              isVerified: true,
              onTap: () =>  Get.toNamed(AppRoute.setupProfile),

            ),
            const SizedBox(height: 24),
            AppText(
              'Privacy',
              style: Ts.regular14(color: AppColor.grey),
            ),
            const Hbox(5),
            CardWidget(icon: FontAwesomeIcons.circleUser, onPressed: () => Get.toNamed(AppRoute.profile), title: "Profile",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
            CardWidget(icon: Icons.security_outlined, onPressed: ()=> Get.toNamed(AppRoute.security), title: "Security",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
             const Hbox(10),
            AppText(
              'Finance',
              style: Ts.regular14(color: AppColor.grey),
            ),
            const Hbox(5),
            CardWidget(icon: FontAwesomeIcons.file, onPressed: (){}, title: "History",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
            CardWidget(icon: FontAwesomeIcons.chartPie, onPressed: (){}, title: "Limits",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
             const Hbox(10),
            AppText(
              'Account',
              style: Ts.regular14(color: AppColor.grey),
            ),
            const Hbox(5),
            CardWidget(icon: FontAwesomeIcons.image, onPressed: (){}, title: "Theme",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
            switchVisible: true,
            switchValue: false,),
            CardWidget(icon: Icons.notifications_none_outlined, onPressed: () => Get.toNamed(AppRoute.notificationpage), title: "Notification",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
            const Hbox(10),
            AppText(
              'More',
              style: Ts.regular14(color: AppColor.grey),
            ),
            const Hbox(5),
            CardWidget(icon: Icons.card_giftcard_outlined, onPressed: (){}, title: "My Bonus",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
            CardWidget(icon: Icons.translate, onPressed: ()=> Get.toNamed(AppRoute.language), title: "Language",),
            CardWidget(icon: Icons.person_add_alt, onPressed: (){}, title: "Share with Friends",),
             CardWidget(icon: Icons.contact_support_outlined, onPressed: () => Get.toNamed(AppRoute.support), title: "Help and Support",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
             const Hbox(20),
             Padding(
               padding: const EdgeInsets.all(16),
               child: AppButton(
                text: "Logout",
                textColor: AppColor.white,
                onPressed: () => Get.dialog(_wLogoutDialog()),
                isFullWidth: true,
               ),
             ),
           const Hbox(40)
          ],
        ),
      ),
    );
  }
  Widget _wLogoutDialog(){
    return AlertDialog(
      title: const AppText('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
      content: const AppText('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          child: const AppText('Cancel', style: TextStyle(color: AppColor.primarytext)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const AppText('Ok', style: TextStyle(color: AppColor.primarytext)),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
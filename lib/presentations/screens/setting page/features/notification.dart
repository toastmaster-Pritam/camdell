import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/setting%20page/model/profile_model.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("Security", style: Ts.semiBold20(color: AppColor.white),),
    onBackPressed: () => Get.back(),
    chat: false,
    backIcon: Icons.arrow_back,
     body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Hbox(10),
                CardWidget(iconVisible: false, onPressed: () {}, title: "In-app notifications",shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
                CardWidget(iconVisible: false, onPressed: () {}, title: "Push notifications Schedule",
                subtitle: "Set a schedule to turn off push notifications.",
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),),
                 const Hbox(15),
              AppText("Account", style: Ts.regular14(color: AppColor.grey),),
              const Hbox(10),
               CardWidget(iconVisible: false, onPressed: () {}, title: "Message",
               switchValue: true,
               switchVisible: true,
               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
               CardWidget(iconVisible: false, onPressed: () {},
                switchValue: true,
               switchVisible: true,
                title: "Order",),
               CardWidget(iconVisible: false, onPressed: () {},
                switchValue: true,
               switchVisible: true,
                title: "Delivery",),
               CardWidget(iconVisible: false, onPressed: () {},
                switchValue: false,
               switchVisible: true,
                title: "Rating",
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                ),
                 const Hbox(15),
              AppText("Messages", style: Ts.regular14(color: AppColor.grey),),
              const Hbox(10),
               CardWidget(iconVisible: false, onPressed: () {}, title: "Active Status",
               switchValue: true,
               switchVisible: true,
               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
               CardWidget(iconVisible: false, onPressed: () {},
                title: "Direct Messages",),
               CardWidget(iconVisible: false, onPressed: () {},
                switchValue: false,
               switchVisible: true,
                title: "Direct Message Preview",
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                ),
                 const Hbox(15),
              AppText("Others", style: Ts.regular14(color: AppColor.grey),),
              const Hbox(10),
               CardWidget(iconVisible: false, onPressed: () {}, title: "People you may know",
               switchValue: true,
               switchVisible: true,
               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),),
               CardWidget(iconVisible: false, onPressed: () {},
                title: "Customized updates and more",),
               CardWidget(iconVisible: false, onPressed: () {},
                switchValue: false,
               switchVisible: true,

                title: "Email notifications ",
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                ),
              
            ],
          ),
        ),
      ),));
  }
}
import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:camdell/presentations/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("Edit Profile", style: Ts.semiBold20(color: AppColor.white),),
    onBackPressed: () => Get.back(),
    body:  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText("Add personal details", style: TextStyle(color: AppColor.black,fontWeight: FontWeight.w600,fontSize: 20),),
          const Hbox(15),
          const AppTextField(
            name: "Name",
            hintText: "Enter name",
            fillColor: Color(0xffF5F5F5),
            hideBorder: true,
            suffixIcon: Icon(Icons.person_2_outlined, color: AppColor.black),
          ),
          const Hbox(15),
          const AppTextField(
            name: "Phone Number",
            hintText: "Enter Phone Number",
            fillColor: Color(0xffF5F5F5),
            hideBorder: true,
            suffixIcon: Icon(Icons.phone_in_talk_outlined, color: AppColor.black),
          ),
          const Hbox(15),
          const AppTextField(
            name: "Email Address",
            hintText: "Email",
            fillColor: Color(0xffF5F5F5),
            hideBorder: true,
            suffixIcon: Icon(Icons.email_outlined, color: AppColor.black),
          ),
          const Hbox(15),
          const AppTextField(
            name: "Address",
            hintText: "Street Address",
            fillColor: Color(0xffF5F5F5),
            hideBorder: true,
            suffixIcon: Icon(Icons.location_on_rounded, color: AppColor.black),
          ),
          const Hbox(15),
          const AppTextField(
            name: "Password",
            hintText: "Password",
            fillColor: Color(0xffF5F5F5),
            hideBorder: true,
            suffixIcon: Icon(Icons.lock_outline, color: AppColor.black),
          ),
          const Hbox(40),
          Padding(
             padding:  const EdgeInsets.all(16),
             child: AppButton(
              text: "Save Changes",
              textColor: AppColor.white,
              onPressed: ()=> Get.back(),
              isFullWidth: true,
             ),
           ),
        ],
      ),
    ),);
  }
}
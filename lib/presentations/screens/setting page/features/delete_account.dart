import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("Deactivate Account", style: Ts.semiBold20(color: AppColor.white),),
    onBackPressed: () => Get.back(),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText("User345: Delete this account?",style: Ts.semiBold14(color: AppColor.black),),
              const Hbox(10),
              AppText("If you delete your account:",style: Ts.regular10(color: AppColor.grey),),
              const Hbox(20),
              _wAccountinfo(),
              Hbox(screenHeight(context) * 0.4),
               Padding(
               padding: const EdgeInsets.all(16),
               child: AppButton(
                text: "Delete",
                textColor: AppColor.white,
                onPressed: (){},
                isFullWidth: true,
               ),
             ),
             Hbox(screenHeight(context) * 0.2),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _wAccountinfo (){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem('You won’t be able to log in and use any CAMDELL services with this account'),
        _buildInfoItem('You will lose access to all your Data.'),
        _buildInfoItem('Information that isn’t stored in your account, such as direct messages, may still be visible to others.'),
        _buildInfoItem('Do you still want to continue?'),
      ],
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColor.grey)),
          Expanded(
            child: Text(
              text,
              style:Ts.regular10(color: AppColor.grey),
            ),
          ),
        ],
      ),
    );
  
  }
}
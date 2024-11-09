import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../../meta/utils/app_color.dart';

class PhomePage extends StatelessWidget {
  const PhomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppText(
        "Payment",
        style: Ts.semiBold20(color: AppColor.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _wprofile(),
          const Hbox(20),
          SizedBox(
            height: screenHeight(context) * 0.3,
            width: screenwidth(context) * 0.9,
            child: _wBalance(1000),
          ),
          const Hbox(20),
          AppText("Quick send", style: Ts.semiBold15()),
          const Hbox(10),
          SizedBox(
            height: screenHeight(context) / 8,
            child: _quickSend(),
          ),
          const Hbox(10),
          _transactionsSection(context),
        ],
      ),
    );
  }

  Widget _wprofile() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(AppImage.tprofile),
        ),
        const Wbox(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText('John Doe', style: Ts.semiBold16()),
            const Hbox(4),
            AppText('View Profile', style: Ts.regular10(color: AppColor.gray300)),
          ],
        ),
      ],
    );
  }

  Widget _wBalance(double balance) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: screenwidth(context) * 0.9,
          height: screenHeight(context) * 0.3,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: const DecorationImage(image: AssetImage(AppImage.walletbg), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    'Your Balance',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Icon(Icons.visibility, color: Colors.white70),
                ],
              ),
              AppText(
                '\$${balance.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: AppButton(
                      icon: FontAwesomeIcons.paperPlane,
                      onPressed: () => Get.toNamed(AppRoute.sendtrans),
                      horizontalPadding: 30,
                      elevation: 0,
                      textColor: AppColor.white,
                      text: 'Send',
                    ),
                  ),
                  const Wbox(16),
                  Expanded(
                    child: AppButton(
                      icon: FontAwesomeIcons.handHoldingDollar,
                      onPressed: () {},
                      horizontalPadding: 30,
                      elevation: 0,
                      borderRadius: 10,
                      textColor: AppColor.white,
                      text: 'Receive',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _quickSend() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(right: 16),
      itemBuilder: (context, index) => Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(AppImage.tprofile),
          ),
          const Hbox(10),
          AppText('Emma', style: Ts.semiBold11()),
        ],
      ),
      separatorBuilder: (context, index) => const Wbox(16),
      itemCount: 10,
    );
  }

  Widget _transactionsSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                AppText("Transactions", style: Ts.semiBold15(color: AppColor.white)),
                const Spacer(),
                AppText("See All", style: Ts.semiBold15(color: AppColor.blue300)),
              ],
            ),
            const Hbox(10),
            SizedBox(
              height: screenHeight(context) * 0.5, // Limit the height
              child: _wtransactions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wtransactions() {
    return ListView.separated(
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
      itemCount: 10,
    );
  }
}
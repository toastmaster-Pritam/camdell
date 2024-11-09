import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'cart widget/container_selected.dart';
import 'cart widget/counter_widget.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppText("Cart", style: Ts.semiBold20(color: AppColor.white),),
      onBackPressed: () => Get.back(),
       body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
         child: Center(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                   const Hbox(10),
                AppText("Cart", style: Ts.semiBold24(),),
                const Hbox(10),
                ListTile(
                  title: AppText("Delivery Address",style: Ts.semiBold16()),
                  subtitle: AppText("123, Main Street, Anytown, USA",style: Ts.regular14(color: AppColor.grey)),
                  leading: const Icon(Icons.location_on_outlined, color: AppColor.black,),
                ),
                const Hbox(10),
                const Divider(thickness: 1, color: AppColor.grey,),
                const Hbox(10),
                Row(
                  children: [
                    AppText("Items in your Cart", style: Ts.semiBold16(),),
                    const Spacer(),
                    AppText("+ Add more", style: Ts.semiBold16(color: AppColor.primary),),
                  ],
                ),
                const Hbox(10),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText("Banana Store",style: Ts.semiBold16()),
                      const Hbox(10),
                       AppText("Banana",style: Ts.semiBold16()),
                    ],
                  ),
                  subtitle: AppText("\$300",style: Ts.regular14(color: AppColor.grey)),
                  leading: Container(
                   width: screenwidth(context) /6,
                    height: screenwidth(context) /6,
                    decoration: BoxDecoration(  
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.grey, width: 1),
                      image: const DecorationImage(image: AssetImage(AppImage.banana), fit: BoxFit.cover),
                    ),
                  ),
                  trailing:SizedBox(
                    width: screenwidth(context) /4,
                    child: CounterButton(
                      initialValue: 0,
                      onChanged: (value) {
                        print('New value: $value');
                      },
                    ),
                  ),
                ),
                const Hbox(10),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText("Lemon Store",style: Ts.semiBold16()),
                      const Hbox(10),
                       AppText("Banana",style: Ts.semiBold16()),
                    ],
                  ),
                  subtitle: AppText("\$700",style: Ts.regular14(color: AppColor.grey)),
                  leading: Container(
                   width: screenwidth(context) /6,
                    height: screenwidth(context) /6,
                    decoration: BoxDecoration(  
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.grey, width: 1),
                      image: const DecorationImage(image: AssetImage(AppImage.lemon), fit: BoxFit.cover),
                    ),
                  ),
                  trailing:SizedBox(
                    width: screenwidth(context) /4,
                    child: CounterButton(
                      initialValue: 0,
                      onChanged: (value) {
                        print('New value: $value');
                      },
                    ),
                  ),
                ),
                const Hbox(10),
                AppText("Delivery Time", style: Ts.semiBold16(),),
                const Hbox(10),
                SelectableContainer(
  items: const ['Standard\n25-30 mins', 'Standard\n25-30 mins'],
  onSelected: (index) {
    print('Selected index: $index');
    // Handle selection
  },
),
                const Hbox(10),
                Card(
                  elevation: 1,
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: AppText("Delivery Instructions",style: Ts.semiBold16()),
                    subtitle: AppText("Leave at Door",style: Ts.regular14(color: AppColor.grey)),
                    leading: Image.asset(AppImage.deliveryinstructions, height: 24,),
                  ),
                ),
                const Hbox(10),
                Card(
                  elevation: 1,
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: AppText("Promo code Applied",style: Ts.semiBold16()),
                    subtitle: AppText("PAY2024 \$150 coupon savings",style: Ts.regular14(color: AppColor.grey)),
                    leading: const Icon(Icons.discount_outlined, color: AppColor.black,size: 25,),
                  ),
                ),
                const Hbox(10),
                AppText("Bill Details", style: Ts.semiBold16(),),
                const Hbox(10),
                Row(
                  children: [
                    AppText("Subtotal", style: Ts.regular11(color: AppColor.black),),
                    const Spacer(),
                    AppText("\$1000", style: Ts.regular11(color: AppColor.grey),),
                  ],
                ),
                const Hbox(10),
                Row(
                  children: [
                    AppText("Promocode", style: Ts.regular11(color: AppColor.black),),
                    const Spacer(),
                    AppText("-\$150", style: Ts.regular11(color: AppColor.primary),),
                  ],
                ),
                const Hbox(10),
                Row(
                  children: [
                    AppText("Delivery Fee", style: Ts.regular11(color: AppColor.black),),
                    const Spacer(),
                    AppText("\$100", style: Ts.regular11(color: AppColor.grey),),
                  ],
                ),
                const Hbox(10),
                Row(
                  children: [
                    AppText("Tax", style: Ts.regular11(color: AppColor.black),),
                    const Spacer(),
                    AppText("\$50", style: Ts.regular11(color: AppColor.grey),),
                  ],
                ),
                const Hbox(10),
                Row(
                  children: [
                    AppText("Total", style: Ts.semiBold15(color: AppColor.black),),
                    const Spacer(),
                    AppText("\$1000", style: Ts.semiBold15(color: AppColor.black),),
                  ],
                ),
                const Hbox(20),
                 Padding(
               padding: const EdgeInsets.all(20),
               child: AppButton(
                text: "Make Payment",
                textColor: AppColor.white,
                onPressed: () => Get.toNamed(AppRoute.payment),
                isFullWidth: true,
               ),
             ),
            ]
           ),
         ),
       ));
  }
}
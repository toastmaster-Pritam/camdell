import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:camdell/presentations/widgets/circular_progress_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_progress_indicator/flutter_circular_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

 
  @override
  Widget build(BuildContext context) {
    return  AppScaffold(
      title: AppText("Payment", style: Ts.semiBold20(color: AppColor.white),),
      onBackPressed: () => Get.back(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              const Hbox(10),
                AppText("Payment", style: Ts.semiBold24(),),
                const Hbox(10),
               paymentbutton("Alexandra Matete", "**** **** **** 7895", AppImage.visa, (){}),
                const Hbox(10),
               paymentbutton("Alexandra Matete", "**** **** **** 7895", AppImage.mastercard, (){}),
                const Hbox(10),
               paymentbutton("Alexandra Matete", "****56@gmail.com", AppImage.paypal, (){}),
                const Hbox(10),
               paymentbutton("Alexandra Matete", "cash", AppImage.cash, (){}),
                const Hbox(10),
               Center(child: _waddpayment()),
                const Hbox(50),
                 Padding(
               padding: const EdgeInsets.all(20),
               child: AppButton(
                text: "Place Order",
                textColor: AppColor.white,
                onPressed: () {},
               )
             ),
             const Hbox(10),
             
          ],
        ),
      ),
      );
  }
  Widget paymentbutton(String text,String subtitle,String image,VoidCallback onTap) {
    return  Card(
      
                  color: AppColor.white,
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: ListTile(
                    onTap: onTap,
                    title: AppText(text,style: Ts.semiBold16()),
                    subtitle: AppText(subtitle,style: Ts.semiBold16()),
                    leading: Image.asset(image, height: 24,),
                  ),
                );
  }
   Widget _waddpayment() {
    return DottedBorder(
      dashPattern: const [6, 6],
      strokeWidth: 1.5,
      color: Colors.black,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: AppText(
          '+ Add Payment Method',
          style: Ts.semiBold16()
        ),
      ),
    );
  }
}



// class LoadingPage extends StatelessWidget {
//   const LoadingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(
//         color: AppColor.white,
//       ),
//     );
//   }
// }
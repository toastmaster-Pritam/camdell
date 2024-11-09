import 'dart:math';

import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/home%20page/features/buying%20and%20selling/buying%20and%20selling%20widget/banner_shoe.dart';
import 'package:camdell/presentations/screens/home%20page/features/buying%20and%20selling/buying%20and%20selling%20widget/shoe_gridview.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class BuyingsellingPage extends StatefulWidget {
  const BuyingsellingPage({super.key});

  @override
  State<BuyingsellingPage> createState() => _BuyingsellingPageState();
}

class _BuyingsellingPageState extends State<BuyingsellingPage> {
  
  final products = [
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),
  Product(
    name: 'Nike Shoe',
    price: 300,
    rating: 4.2,
    imageUrl: AppImage.shoes,
  ),

];

 
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: AppText("Buys and Sells", style: Ts.semiBold20(color: AppColor.white),),
    showCart: true,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
         ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(AppImage.tprofile),
          ),
           title: AppText("Good Morning", style: Ts.semiBold11(color: AppColor.grey),),
           subtitle:  AppText("Emmanuel Chase", style: Ts.semiBold13(),),
         ),
         const Hbox(10),
        const ShoeBannerWidget(),
        const Hbox(10),
       Row(
        children: [
          AppText("Popular Stores", style: Ts.semiBold20(),),
          const Spacer(),
          AppText("View all", style: Ts.semiBold12(color: AppColor.blue900),),
        ],
       ),
       const Hbox(10),
      SizedBox(
        height: screenHeight(context) * 0.5,
        child: ProductGrid(
          products: products,
        ),
      )

        ],
      ),
    ),
      
    );
  }
}
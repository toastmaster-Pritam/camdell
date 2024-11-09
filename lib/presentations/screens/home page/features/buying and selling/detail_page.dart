import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/home%20page/features/buying%20and%20selling/buying%20and%20selling%20widget/shoe_gridview.dart';
import 'package:camdell/presentations/screens/home%20page/features/buying%20and%20selling/buying%20and%20selling%20widget/show_product_widget.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
    return AppScaffold(
     onBackPressed: () => Get.back(),
      title: AppText("Detail", style: Ts.semiBold20(color: AppColor.white),),
    showCart: true,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText("Detail", style: Ts.semiBold20(),),
          const Hbox(16),
         const ShowProductWidget(),
          const Hbox(10),
          AppText("Checkout similar products", style: Ts.semiBold20(),),
          const Hbox(10),
          SizedBox(
            height: screenHeight(context) * 0.3,
            child: ProductGrid(products: products,),
          ),
          
        ],
      ),
    ),
    );
  }
 
}
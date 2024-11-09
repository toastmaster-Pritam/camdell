import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/model/fruits_model.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/widgets/discount_widget.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/widgets/filter_navigation_bar.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/widgets/storelist_popular.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class SupermarketScreen extends StatefulWidget {
  const SupermarketScreen({super.key});

  @override
  State<SupermarketScreen> createState() => _SupermarketScreenState();
}

class _SupermarketScreenState extends State<SupermarketScreen> {
  final imageurls = [AppImage.discount,AppImage.discount,AppImage.discount,
  ];
 final List<Stores> stores = [
    Stores(
      name: 'Banana Store',
      location: 'London',
      rating: '4.2',
      time: '11km|25 min',
      image:  AppImage.bananastore,
    ),
    Stores(
      name: 'Kiwi Store',
      location: 'China',
      rating: '4.2',
      time: '1km|20 min',
      image:  AppImage.bananastore,
    ),
 
  ];

  
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showCart: true,
      
      title: AppText("Supermarket", style: Ts.semiBold20(color: AppColor.white),), body: 
     SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.all(16),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Hbox(10),
            AppText("Supermarket", style: Ts.semiBold24(),),
            const Hbox(10),
            FilterNavigationBar(items: [  FilterItem(text: 'Sort By', icon: Icons.filter_list),
             FilterItem(text: 'Kiwi'),
             FilterItem(text: 'Free delivery', ),
             FilterItem(text: 'Groceries',),
             FilterItem(text: 'All Fruits',),
             ], onItemSelected: (index) {
             // Handle item selection here
             print('Selected item at index: $index');
           },),
           const Hbox(20),
           SizedBox(
             height:screenHeight(context) * 0.3,child: FruitGridView()),
             ImageSlider(imageUrls: imageurls),
             const Hbox(10),
             AppText("Popular Stores", style: Ts.semiBold20(),),
             const Hbox(10),
             SizedBox(
              height: screenHeight(context) * 0.3,
              child: StoreListView(stores: stores,)),
             const Hbox(20),
             AppText("Popular Groceries", style: Ts.semiBold20(),),
             const Hbox(10),
             SizedBox(
              height: screenHeight(context) * 0.3,
              child: StoreListView(stores: stores,)),
             const Hbox(20),

          ],
             ),
       ),
     ));
  
  }
}
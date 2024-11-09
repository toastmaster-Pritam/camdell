import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/model/fruits_model.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/widgets/banana_tabs.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/widgets/filter_navigation_bar.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class BananaPage extends StatefulWidget {
  const BananaPage({super.key});

  @override
  State<BananaPage> createState() => _BananaPageState();
}

class _BananaPageState extends State<BananaPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showCart: true,
      title: AppText("Banana",
    
     style: Ts.semiBold20(color: AppColor.white),), body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Hbox(10),
            AppText("Banana", style: Ts.semiBold24(),),
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
           const Hbox(10),
           SizedBox(
             height:screenHeight(context) * 0.3,child: FruitGridView()),
            
             SizedBox(
              height: screenHeight(context) *0.6,
              child: const ProduceStoreTabs())
        ],
      ),
    ));
  }
}
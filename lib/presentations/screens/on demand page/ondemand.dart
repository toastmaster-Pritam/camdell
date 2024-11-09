import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/route/routes.dart';
import '../../widgets/search_widget.dart';
import 'widgets/food_grid_view.dart';

class OnDemand extends StatefulWidget {
  const OnDemand({super.key});

  @override
  State<OnDemand> createState() => _OnDemandState();
}

class _OnDemandState extends State<OnDemand> {
  final TextEditingController search = TextEditingController();
    final List<Map<String, String>> foodresturents = [
    {"title": "Foodie", "subtitle": "Chinese Rice", "rating": "4.2", "time": "11km/28 min", "image": AppImage.restaurants},
    {"title": "Foodie", "subtitle": "Chinese Rice", "rating": "4.5", "time": "3km/15 min", "image": AppImage.restaurants},
    {"title": "Foodie", "subtitle": "Chinese Rice", "rating": "4.8", "time": "2km/10 min", "image": AppImage.restaurants},
    
  ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      showCart: true,
      title:AppText("On Demand", style: Ts.semiBold20(color: AppColor.white),),
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Hbox(20),
              SearchWidget(controller: search, onChanged: (value){}),
              const Hbox(10),
               SizedBox(
                  height: screenHeight(context) * 0.2,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = (constraints.maxWidth - 30) / 4;
                      final itemHeight = itemWidth * 1.5;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: itemWidth / itemHeight,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _serviceItem(
                            _getServiceTitle(index),
                            _getServiceImage(index),
                            () => _handleServiceTap(index),
                          );
                        },
                      );
                    },
                  ),
                ),
                const FoodGridView(),
                const Hbox(20),
                AppText("Popular Restaurants",style: Ts.bold20(color: AppColor.black)),
                const Hbox(10),
                SizedBox(
                height: screenHeight(context) / 4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foodresturents.length,
                  itemBuilder: (context, index) {
                    return _topPickItem(foodresturents[index]);
                  },
                ),
              ),
                const Hbox(20),
                AppText("Popular Groceries",style: Ts.bold20(color: AppColor.black)),
                const Hbox(10),
                SizedBox(
                height: screenHeight(context) / 4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foodresturents.length,
                  itemBuilder: (context, index) {
                    return _topPickItem(foodresturents[index]);
                  },
                ),
              ),
            ],
           ),
         ),
       ));
  }
  void _handleServiceTap(int index) {
    switch (index) {
     
      case 0:
        Get.toNamed(AppRoute.supermarket);
        break;
      case 1:
        Get.toNamed(AppRoute.flower);
        break;
      case 2:
        Get.toNamed(AppRoute.electronic);
        break;
      case 3:
        Get.toNamed(AppRoute.flower);
        break;
      case 4:
        Get.toNamed(AppRoute.flower);
        break;

      default:
        // Handle other services or show a message
        Get.snackbar(
          'Service Unavailable',
          'This service is not available yet.',
          snackPosition: SnackPosition.BOTTOM,
        );
    }
  }
   Widget _serviceItem(String title, String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(child: Image.asset(image, height: 35, width: 35)),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style:Ts.medium11(color: AppColor.gray500),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  String _getServiceTitle(int index) {
    switch (index) {
     
      case 0: return "Super Market";
      case 1: return "Flower delivery";
      case 2: return "Electronic Delivery";
      case 3: return "beauty";
      case 4: return "Courier Service";
      
      default: return "";
    }
  }

  String _getServiceImage(int index) {
    switch (index) {
      
      case 0: return AppImage.cart;
      case 1: return AppImage.flower;
      case 2: return AppImage.edelivery;
      case 3: return AppImage.edelivery;
      case 4: return AppImage.cservices;
      default: return "";
    }
  }
  Widget _topPickItem(Map<String, String> item) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              item['image']!,
              height: 100,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(item['title']!, style: Ts.bold14(color: AppColor.black)),
          Text(item['subtitle']!, style: Ts.regular12(color: AppColor.gray500)),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              Text(item['rating']!, style: Ts.regular12(color: AppColor.gray500)),
              const SizedBox(width: 10),
              Text(item['time']!, style: Ts.regular12(color: AppColor.gray500)),
            ],
          ),
        ],
      ),
    );
  }
}
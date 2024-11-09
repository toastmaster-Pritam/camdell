import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/presentations/screens/on%20demand%20page/widgets/discount_widget.dart';
import 'package:camdell/presentations/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final imageurls = [
    AppImage.discount,
    AppImage.discount,
    AppImage.discount,
    AppImage.discount,
  ];
   final List<Map<String, String>> topPicks = [
    {"title": "Handy Man", "subtitle": "Plumber", "rating": "4.2", "time": "11km/28 min", "image": AppImage.handyman},
    {"title": "Beauty", "subtitle": "Makeup Artist", "rating": "4.5", "time": "3km/15 min", "image": AppImage.beauty},
    {"title": "Massage", "subtitle": "Chinese Massage", "rating": "4.8", "time": "2km/10 min", "image": AppImage.massage},
    
  ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Image.asset(AppImage.logo, height: 50, width: 112),
      showProfile: true,
      chat: true,
      body: Stack(
        children: [
         
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      const SizedBox(height: 10),
                  SearchWidget(controller: controller, onChanged: (value) {}),
                  SizedBox(
                    height: screenHeight(context) /2.9,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final itemWidth = (constraints.maxWidth - 30) / 4;
                        final itemHeight = itemWidth * 1.5;
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: itemWidth / itemHeight,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: 7,
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
                  const Hbox(10),
                    ImageSlider(imageUrls: imageurls),
                  const Hbox(10),
                  AppText("Top Picks", style: Ts.bold20(color: AppColor.black)),
                  const Hbox(10),
                  SizedBox(
                    height: screenHeight(context) / 4.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topPicks.length,
                      itemBuilder: (context, index) {
                        return _topPickItem(topPicks[index]);
                      },
                    ),
                  ),
                  const Hbox(10),
                  AppText("Popular services", style: Ts.bold20(color: AppColor.black)),
                  const Hbox(10),
                  SizedBox(
                    height: screenHeight(context) / 4.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topPicks.length,
                      itemBuilder: (context, index) {
                        return _topPickItem(topPicks[index]);
                      },
                    ),
                  ),
                  const Hbox(10),
                  AppText("Top Rated", style: Ts.bold20(color: AppColor.black)),
                  const Hbox(10),
                  SizedBox(
                    height: screenHeight(context) / 4.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topPicks.length,
                      itemBuilder: (context, index) {
                        return _topPickItem(topPicks[index]);
                      },
                    ),
                  ),
                  const Hbox(50),
                ],
              ),
            ),
          ),
           Positioned(
            right: 20,
            bottom: 80,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: AppColor.primary,
              onPressed: () {},
              elevation: 5,
              child: const Icon(Icons.qr_code_scanner_rounded, size: 25, color: AppColor.white),
            ),
          ),
        ],
      ),
    );
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
          AppText(item['title']!, style: Ts.bold14(color: AppColor.black)),
          AppText(item['subtitle']!, style: Ts.regular12(color: AppColor.gray500)),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              AppText(item['rating']!, style: Ts.regular12(color: AppColor.gray500)),
              const SizedBox(width: 10),
              AppText(item['time']!, style: Ts.regular12(color: AppColor.gray500)),
            ],
          ),
        ],
      ),
    );
  }

  void _handleServiceTap(int index) {
    switch (index) {
      case 0:
        Get.toNamed(AppRoute.foodelivery);
        break;
      case 1:
        Get.toNamed(AppRoute.ride);
        break;
      case 2:
        Get.toNamed(AppRoute.travel);
        break;
      case 3:
        Get.toNamed(AppRoute.enavigationbar);
        break;
      case 4:
        Get.toNamed(AppRoute.buyandsell);
        break;
      case 5:
        Get.toNamed(AppRoute.paymentscreen);
        break;
      case 6:
        // Get.toNamed(AppRoute.ride);
        break;
      case 7:
         Get.snackbar(
          'Service Unavailable',
          'This service is not available yet.',
          snackPosition: SnackPosition.BOTTOM,
        );
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
            child: AppText(
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
      case 0: return "On Demand Delivery";
      case 1: return "Ride";
      case 2: return "Travel & Pleasures";
      case 3: return "Entertainment & Lifestyle";
      case 4: return "Buying & Selling";
      case 5: return "Payments";
      case 6: return "All Services";
      default: return "";
    }
  }

  String _getServiceImage(int index) {
    switch (index) {
      case 0: return AppImage.truck;
      case 1: return AppImage.carnew;
      case 2: return AppImage.airoplane;
      case 3: return AppImage.movie;
      case 4: return AppImage.bag;
      case 5: return AppImage.pay;
      case 6: return AppImage.home;
      default: return "";
    }
  }
}
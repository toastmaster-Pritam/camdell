import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EntertainmentScreen extends StatefulWidget {
  const EntertainmentScreen({super.key});

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  final List<String> imageList = [
    AppImage.deadpool,
    AppImage.deadpool,
    AppImage.deadpool,
    AppImage.deadpool,
  ];
  int currentIndex = 0;

    @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      showProfile: false,
      title: AppText("Entertainment", style: Ts.semiBold20(color: AppColor.white)),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainMovie(),
              _buildForYouSection(  'For You'),
              _buildForYouSection("Top Rated on IMDB"),
              _buildForYouSection("Disney Movies"),
            ],
          ),
        ),
      ),
    );
  }

  Widget  _buildMainMovie() {
    return SizedBox(
      width: double.infinity,
      height: screenHeight(context) * 0.6,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              itemCount: imageList.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  child: Image.asset(
                    imageList[index],
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            top: 250,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: const Row(
                children: [
                  Text(
                    '8.0',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 130,
            left: 18,
            child: AppText(
              'DeadPool',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 16,
            right: 16,
            child: Row(
              children: [
                AppButton(
                  text: 'Watch Now',
                  onPressed: () {},
                  isFullWidth: false,
                  textColor: AppColor.white,
                  horizontalPadding: 20,
                  borderRadius: 15,
                ),
                const Wbox(10),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border, color: AppColor.white),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageList.length,
                (index) => Container(
                  width: index == currentIndex ? 16 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: index == currentIndex ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildForYouSection(String text) {
    final List<String> moviePosters = [
     AppImage.deadpool,
     AppImage.deadpool,
     AppImage.deadpool,
     AppImage.deadpool,
     AppImage.deadpool,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppText(
               text,
                style: Ts.semiBold16(color: AppColor.white),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppText(
                'See All',
                style: Ts.semiBold16(color: AppColor.blue300),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: moviePosters.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    moviePosters[index],
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

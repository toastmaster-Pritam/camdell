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

class EshowsPage extends StatefulWidget {
  const EshowsPage({super.key});

  @override
  State<EshowsPage> createState() => _EshowsPageState();
}

class _EshowsPageState extends State<EshowsPage> {
  final List moviePosters = [
    AppImage.deadpool,
    AppImage.deadpool2,
    AppImage.deadpool3,
    AppImage.deadpool4,
  ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backIcon: Icons.arrow_back,
      onBackPressed: () => Get.back(),
      title: AppText("TV Shows", style: Ts.semiBold20(color: AppColor.white)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Genres", style: Ts.semiBold20(color: AppColor.blue300)),
            const Hbox(10),
            Row(
              children: [
                AppText("Trending", style: Ts.semiBold11()),
                const Spacer(),
                AppText("See All", style: Ts.semiBold11(color: AppColor.blue300)),
              ],
            ),
            const Hbox(10),
            SizedBox(
              height: screenHeight(context) * 0.2,
              child: ListView.builder(
                itemCount: moviePosters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: screenHeight( context) * 0.2,
                  width: screenwidth(context) * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:  DecorationImage(
                      image: AssetImage(
                        moviePosters[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
            const Hbox(10),
            Row(
              children: [
                AppText("Watched", style: Ts.semiBold11()),
                const Spacer(),
                AppText("See All", style: Ts.semiBold11(color: AppColor.blue300)),
              ],
            ),
            const Hbox(10),
            SizedBox(
              height: screenHeight(context) * 0.2,
              child: ListView.builder(
                itemCount: moviePosters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: screenHeight( context) * 0.2,
                  width: screenwidth(context) * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:  DecorationImage(
                      image: AssetImage(
                        moviePosters[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
            const Hbox(10),
            Row(
              children: [
                AppText("Anticipated", style: Ts.semiBold11()),
                const Spacer(),
                AppText("See All", style: Ts.semiBold11(color: AppColor.blue300)),
              ],
            ),
            const Hbox(10),
            SizedBox(
              height: screenHeight(context) * 0.2,
              child: ListView.builder(
                itemCount: moviePosters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: screenHeight( context) * 0.2,
                  width: screenwidth(context) * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:  DecorationImage(
                      image: AssetImage(
                        moviePosters[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
            const Hbox(10),
            Row(
              children: [
                AppText("Trending", style: Ts.semiBold11()),
                const Spacer(),
                AppText("See All", style: Ts.semiBold11(color: AppColor.blue300)),
              ],
            ),
            const Hbox(10),
            SizedBox(
              height: screenHeight(context) * 0.2,
              child: ListView.builder(
                itemCount: moviePosters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: screenHeight( context) * 0.2,
                  width: screenwidth(context) * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:  DecorationImage(
                      image: AssetImage(
                        moviePosters[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
            const Hbox(10),
            Row(
              children: [
                AppText("Trending", style: Ts.semiBold11()),
                const Spacer(),
                AppText("See All", style: Ts.semiBold11(color: AppColor.blue300)),
              ],
            ),
            const Hbox(10),
            SizedBox(
              height: screenHeight(context) * 0.2,
              child: ListView.builder(
                itemCount: moviePosters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: screenHeight( context) * 0.2,
                  width: screenwidth(context) * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:  DecorationImage(
                      image: AssetImage(
                        moviePosters[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),

          ],
        ),
      ),
      );
  }
}
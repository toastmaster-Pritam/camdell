import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'Welcome to Camdell!',
      image: AppImage.onboard1,
    ),
    OnboardingPage(
      title: 'Transport & Logistics',
      image: AppImage.onboard2,
    ),
    OnboardingPage(
      title: 'Get food and groceries',
      image: AppImage.onboard3,
    ),
    OnboardingPage(title: "PAYMENT", image: AppImage.onboard4,)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: Image.asset(AppImage.logo, height: 80),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return buildPageContent(pages[index]);
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                bgColor: AppColor.primary,
                textColor: AppColor.white,
                horizontalPadding: 60,
                isFullWidth: false,
                text: _currentPage == pages.length - 1 ? "Get Started" : "Next",
                onPressed: () {
                  if (_currentPage == pages.length - 1) {
                    Get.offNamed(AppRoute.welcome);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPageContent(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(page.image, height: 280),
          const Hbox(15),
          Text(
            page.title,
            style: Ts.bold24(color: AppColor.secondary),
          ),
        ],
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 4,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColor.primary : AppColor.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String image;

  OnboardingPage({
    required this.title,
    required this.image,
  });
}
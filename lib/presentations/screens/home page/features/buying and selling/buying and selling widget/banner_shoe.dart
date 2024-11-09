import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ShoeBannerWidget extends StatefulWidget {
  const ShoeBannerWidget({super.key});

  @override
  _ShoeBannerWidgetState createState() => _ShoeBannerWidgetState();
}

class _ShoeBannerWidgetState extends State<ShoeBannerWidget> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight(context) * 0.2,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xff002366),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: AppText(
                        "Nike Shoe",
                        style: Ts.semiBold24(color: AppColor.white),
                      ),
                    ),
                    Positioned(
                      top: 55,
                      left: 20,
                      child: SizedBox(
                        width: screenwidth(context) * 0.4,
                        child: AppText(
                          "Get 20% off on your first Order",
                          style: Ts.semiBold10(color: AppColor.white),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 30,
                      child: AppButton(
                        horizontalPadding: 10,
                        text: "Shop Now",
                        height: 30,
                        onPressed: () {},
                        bgColor: AppColor.white,
                        textColor: AppColor.black,
                        textStyle: Ts.semiBold12(),
                        isFullWidth: false,
                        borderRadius: 30,
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      right: -40,
                      child: Transform.rotate(
                        angle: 20 * pi / 180,
                        child: Image.asset(
                          AppImage.shoes,
                          height: screenHeight(context) * 0.3,
                          width: screenwidth(context) * 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        ExpandableDotIndicator(
          currentPage: _currentPage,
        ),
      ],
    );
  }
}

class ExpandableDotIndicator extends StatelessWidget {
  final double currentPage;

  const ExpandableDotIndicator({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) {
          final selectedness = Curves.easeOut.transform(
            1.0 - ((currentPage - index).abs()).clamp(0.0, 1.0),
          );
        
          return Container(
            width: 18,
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Color.lerp(Colors.grey, const Color(0xff002366), selectedness),
            ),
          );
        },
      ),
    );
  }
}
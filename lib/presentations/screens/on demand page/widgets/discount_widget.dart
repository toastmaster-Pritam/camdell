import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const ImageSlider({super.key, required this.imageUrls});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
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
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(
                  widget.imageUrls[index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imageUrls.length,
            (index) => DotIndicator(
              isActive: index == _currentPage,
              currentPage: _currentPage,
              index: index,
              totalDots: widget.imageUrls.length,
            ),
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;
  final int currentPage;
  final int index;
  final int totalDots;

  const DotIndicator({
    super.key, 
    required this.isActive,
    required this.currentPage,
    required this.index,
    required this.totalDots,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the width based on the dot's position relative to the current page
    double widthFactor = 1.0;
    if (isActive) {
      widthFactor = 5.0;
    } else {
      int distance = (currentPage - index).abs();
      widthFactor = 1.0 + (1.0 / (distance + 1));
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: screenHeight(context) * 0.01,
      width: screenHeight(context) * 0.01 * widthFactor,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight(context) * 0.005),
        color: isActive ? AppColor.primary : AppColor.grey,
      ),
    );
  }
}

import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    Future.delayed(const Duration(seconds: 5), () {
     Get.offNamed( AppRoute.onBoarding);
    });
  }
@override
void dispose() {
  _controller.stop();
  _controller.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors:[
        AppColor.primary,
        AppColor.secondary,
      ],
     begin: Alignment.topCenter,
     end: Alignment.bottomCenter,)
    ),
    child: FadeTransition(opacity: _animation,child: Center(
      child: Image.asset(AppImage.logo, height: 200, width: 200,),
    ),),
  ),
    );
  }
}
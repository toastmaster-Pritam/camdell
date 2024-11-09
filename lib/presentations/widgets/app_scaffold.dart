import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:get/get.dart';

class AppScaffold extends StatelessWidget {
  final Widget title;
  final Widget? body;
  final PreferredSizeWidget? appbar;
  final IconData backIcon;
  final VoidCallback? onBackPressed;
  final bool showProfile;
  final bool chat;
  final bool showCart;
  final bool showAppBarInContainer;

  const AppScaffold({
    super.key,
    this.appbar,
    this.backIcon = Icons.arrow_back,
    required this.title,
   this.body,
    this.onBackPressed,
    this.showProfile = false,
    this.chat = false,
    this.showCart = false,
    this.showAppBarInContainer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBarInContainer ? null : appbar,
      body: Container(
        color: AppColor.blue900,
        child: Column(
          children: [
            if (showAppBarInContainer && appbar != null) 
              Container(
                child: appbar,
              ),
            if (appbar == null) _buildAppBar(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLeftButton(),
            Expanded(child: _buildTitle()),
            _buildRightButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftButton() {
    if (showProfile) {
      return IconButton(
        icon: Image.asset(AppImage.profile, height: 30),
        onPressed: () => Get.toNamed(AppRoute.setupProfile),
      );
    } else {
      return Container(
        height: 38,
        decoration: const BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: IconButton(
            icon: Icon(backIcon, color: AppColor.black, size: 24),
            onPressed: onBackPressed ?? () => Get.back(),
          ),
        ),
      );
    }
  }

  Widget _buildTitle() {
    return Center(
      child: title,
    );
  }

  Widget _buildRightButton() {
    if (showCart) {
      return IconButton(
        icon: Image.asset(AppImage.cartnew, height: 24, color: AppColor.white,),
        onPressed: ()=> Get.toNamed(AppRoute.cart),
      );
    } else if (chat) {
      return IconButton(
        icon: Image.asset(AppImage.msg, height: 24, color: AppColor.white),
        onPressed: () => Get.toNamed(AppRoute.chatScreen),
      );
    } else {
      return Container(
        width: 40,
      );
    }
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        child: body,
      ),
    );
  }
}
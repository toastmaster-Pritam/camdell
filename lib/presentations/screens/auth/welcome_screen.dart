import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/auth/signin_screen.dart';
import 'package:camdell/presentations/widgets/social_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_services/social media login/apple_auth.dart';
import 'auth_services/social media login/facebook_auth.dart';
import 'auth_services/social media login/google_auth.dart';



class WelcomeScreen extends StatelessWidget {
   
 WelcomeScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final controller = Get.put(GoogleAuthController());
  final AppleAuthController appleController = Get.put(AppleAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Hbox(10),
            AppText(
              'Welcome to\nCAMDELL',
              style: Ts.bold24(color: AppColor.textcolor),
              textAlign: TextAlign.center,
            ),
            AppButton(
              bgColor: AppColor.white,
              elevation: 0,
              borderColor: AppColor.grey,
              icon: Icons.phone,
              textStyle: Ts.regular(color: AppColor.black),
              height: 55,
              text: "Continue with Phone Number",
              onPressed: () => _navigateToSignIn(AuthRoute.phone),
              isFullWidth: true,
            ),
            AppButton(
              bgColor: AppColor.white,
              elevation: 0,
              borderColor: AppColor.grey,
              icon: Icons.email_outlined,
              textStyle: Ts.regular(color: AppColor.black),
              height: 55,
              text: "Continue with Email",
              onPressed: () => _navigateToSignIn(AuthRoute.email),
              isFullWidth: true,
            ),
            AppButton(
              text: "Signup",
              onPressed: () {
                Get.toNamed(AppRoute.signup);
              },
              isFullWidth: true,
              textColor: AppColor.white,
            ),
         
            SocialLoginWidget(
              dividerColor: AppColor.grey,
              onAppleTap: () => appleController.signUpOrLogin(),
              onFacebookTap: () => authController.signUpOrLogin(),
              onGoogleTap: ()async {
                await controller.signUpOrLogin();
              },
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColor.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: AppText('Already have an account?'),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColor.grey,
                  ),
                ),
              ],
            ),
            AppButton(
              bgColor: AppColor.white,
              elevation: 0,
              borderColor: AppColor.primary,
              textStyle: Ts.regular(color: AppColor.black),
              height: 55,
              textColor: AppColor.primary,
              text: "SignIn",
              onPressed: () => _navigateToSignIn(AuthRoute.none),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }



  void _navigateToSignIn(AuthRoute route) {
    Get.to(
      () => const SignInScreen(),
      binding: BindingsBuilder(() {
        Get.put(SignInController());
      }),
      arguments: {'authRoute': route},
    );
  }
}
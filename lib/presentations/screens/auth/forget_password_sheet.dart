import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/presentations/widgets/app_textfield.dart';
import 'package:camdell/meta/utils/ts.dart';

import '../../widgets/four_digit_code.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxInt currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void resetPassword() {
    // Implement reset password logic here
    print('Reset password');
    Get.back(); // Close the bottom sheet
  }
}

class ForgotPasswordBottomSheet extends StatelessWidget {
  final controller = Get.put(ForgotPasswordController());

   ForgotPasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              
                const SizedBox(height: 10),
                Obx(() => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: _buildStep(controller.currentStep.value),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return _buildEmailStep();
      case 1:
        return _buildCodeStep();
      case 2:
        return _buildNewPasswordStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: const ValueKey<int>(0),
      children: [
          AppText(
                  "Forgot password",
                  style: Ts.medium24(color: AppColor.black),
                ),
                const Hbox(15),
        const AppText(
          "Enter your email for the verification process, we will send a 4-digit code to your email",
        ),
        const Hbox(15),
        AppTextfield(
          label: "Email",
          controller: controller.emailController,
          prefixIcon: Icons.email_outlined,
          validator: (p0) => p0 == null || p0.isEmpty ? "Email cannot be empty" : null,
        ),
        const Hbox(15),
        AppButton(
          text: "Continue",
          onPressed: controller.nextStep,
          isFullWidth: true,
          textColor: AppColor.white,
        ),
      ],
    );
  }

Widget _buildCodeStep() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    key: const ValueKey<int>(1),
    children: [
      FourDigitCodeEntry(
        onCodeEntered: (code) {
          controller.codeController.text = code;
          controller.nextStep();
        },
      ),
    ],
  );
}
  Widget _buildNewPasswordStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      key: const ValueKey<int>(2),
      children: [
        AppText("Reset Password", style: Ts.medium24(color: AppColor.black)),
        const AppText(
          "Set the new password for your account so you can login and access all the features.",
        ),
        const Hbox(15),
        AppTextfield(
          label: "New Password",
          controller: controller.newPasswordController,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: (p0) => p0 == null || p0.isEmpty ? "Password cannot be empty" : null,
        ),
        const Hbox(15),
        AppTextfield(
          label: "Confirm New Password",
          controller: controller.confirmPasswordController,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: (p0) => p0 == null || p0.isEmpty ? "Password cannot be empty" : null,
        ),
        const Hbox(15),
        AppButton(
          text: "Update Password",
          onPressed: controller.resetPassword,
          isFullWidth: true,
          textColor: AppColor.white,
        ),
      ],
    );
  }
}
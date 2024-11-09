
import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
   int currentStep = 0;
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hbox(20),
                          AppText(
                  'Get started in 3\neasy steps',
                  style: Ts.bold32(color: AppColor.textcolor),
                  textAlign: TextAlign.center,
                ),
                                 Image.asset(
                AppImage.lock,
                height: 250,),
                Stepper(
                  currentStep: currentStep,
                  onStepTapped: (step) => setState(() => currentStep = step),
                  controlsBuilder: (context, controlDetails) {
                    return const SizedBox.shrink(); 
                  },
                  steps: [
                    _buildStep(title: 'Create your account', ),
                    _buildStep(title: 'Confirm your account', ),
                    _buildStep(title: 'Create a password',),
                  ],
                ),
               AppButton(
                 text: 'Continue',
                 onPressed: () {
                  Get.toNamed(AppRoute.addmail);
                 },
                 isFullWidth: true,
                 textColor: AppColor.white,
                 bgColor: AppColor.secondary,
               )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Step _buildStep({required String title, }) {
    return Step(
      stepStyle: const StepStyle(
        color: AppColor.secondary
      ),
      title: Text(title,),
      content: const SizedBox.shrink(),
      isActive: currentStep >= 0,
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
    );
  }
}

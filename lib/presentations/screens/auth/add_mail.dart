import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:camdell/presentations/screens/auth/auth_services/auth_services.dart';
import 'package:camdell/presentations/widgets/app_textfield.dart';
import 'package:camdell/presentations/widgets/new_apptextfield.dart';
import 'package:camdell/presentations/widgets/social_media_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../../../meta/utils/app_switch.dart';
import '../../widgets/custom_stepper.dart';
import 'auth_services/social media login/apple_auth.dart';
import 'auth_services/social media login/facebook_auth.dart';
import 'auth_services/social media login/google_auth.dart';

class AddMail extends  StatefulWidget {
   
   const AddMail({super.key});

  @override
  State<AddMail> createState() => _AddMailState();
}

class _AddMailState extends State<AddMail> {
  final AddMailViewModel viewModel = Get.put(AddMailViewModel());
   final isEmailValid = true.obs;
  final prefixIcon = Icons.email.obs;

   final AuthController authController = Get.put(AuthController());

   final controller = Get.put(GoogleAuthController());

   final AppleAuthController appleController = Get.put(AppleAuthController());

   @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => CustomStepper(
              currentPage: viewModel.currentStep.value,
              totalPages: 5,
              onStepBack: viewModel.decrementStep,
            )),
            Expanded(
              child: Obx(() => _buildStepContent(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context) {
    switch (viewModel.currentStep.value) {
      case 1:
        return _buildEmailStep();
      case 2:
        return _buildEmailConfirmStep();
      case 3:
        return _buildOtpVerificationStep(context);
      case 4:
        return _buildSetPasswordStep();
      case 5:
        return _buildSuccessStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildEmailStep() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What's your email and Phone Number?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter the email address and Phone number you want to use to register with camdell',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Obx(() => SmartTextField(
            label: "Email and Phone number",
            controller: viewModel.emailController,
            // prefixIcon: viewModel.prefixIcon.value, 
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    }
    // Check for either valid email or phone number
    if (!GetUtils.isEmail(value) && !viewModel.isValidPhoneNumber(value)) {
      return "Please enter a valid email or phone number";
    }
    return null;
  },
            errorText: !viewModel.isEmailValid.value && viewModel.emailController.text.isNotEmpty
                ? "Please enter a valid email"
                : null,
          )),
          const Hbox(16),
          AppText(
            isRich: true,
            "Have An Account?",
            spans: [
              TextSpan(
                text: "Login here",
                style: Ts.semiBold14(color: AppColor.primary),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.toNamed(AppRoute.signin),
              )
            ],
          ),
          const Hbox(40),
          Obx(() => AppButton(
            text: 'Continue',
            textColor: AppColor.white,
            onPressed: viewModel.isEmailValid.value || viewModel.isValidPhoneNumber(viewModel.emailController.text) ?  viewModel.sendOTP : null,
            isLoading: viewModel.isLoading.value,
          )),
            const Hbox(16),
            const Text(
              'By registering you accept our Terms & Conditions and Privacy Policy. Your data will be securely encrypted with camdell',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const Hbox(50),
            SocialLoginWidget(
              dividerColor: AppColor.grey,
              onAppleTap: () =>appleController.signUpOrLogin(),
              onFacebookTap: () => authController.signUpOrLogin(),
            
              onGoogleTap: () async {
                await controller.signUpOrLogin();
              },
            )
          ],
        ),
      ),
    );
  }

Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

Widget _buildEmailConfirmStep (){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(AppImage.email,height: 200,),
        ),
       const Hbox(20),
       AppText(viewModel.isEmailValid.value ? "Confirm your PhoneNumber" : "Confirm your email",style: Ts.bold24(color: AppColor.black),),
       const Hbox(10),
       AppText( viewModel.isEmailValid.value ? "We just sent an OTP to ${viewModel.emailController.text}" :
        "We just sent you an email to ${viewModel.emailController.text}",style: Ts.regular18(color: AppColor.black),textAlign: TextAlign.center,),
       const Hbox(20),
     AppButton(
        text: "Continue",
        horizontalPadding: 40,
        textColor: AppColor.white,
        onPressed: viewModel.incrementStep,
       ),
       const Hbox(80),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: [
              const TextSpan(text: 'I '),
              TextSpan(
                text: "didn't receive",
                style: const TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap =  viewModel.decrementStep,
              ),
            
          TextSpan(text: viewModel.isEmailValid.value ? ' My Phone Number' : "my email"),
            ],
          ),
        ),
      
  

      ],
    ),
  );
}

 Widget _buildOtpVerificationStep(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Please enter the code',
            style: Ts.bold32(color: AppColor.black),
          ),
          const SizedBox(height: 8),
          Text(
            'We sent email to ${viewModel.emailController.text}',
            style: Ts.semiBold14(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Icon(Icons.email_outlined, size: 64, color: Colors.blue),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6,
              (index) => Container(
                width: 40,
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  focusNode: viewModel.otpFocusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) => viewModel.onOTPDigitChanged(value, index),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Obx(() => Text(
            viewModel.verificationMessage.value,
            style: TextStyle(
              color: viewModel.verificationMessage.value.contains('success')
                  ? Colors.green
                  : Colors.red,
            ),
          )),
          const SizedBox(height: 16),
          TextButton(
            onPressed: viewModel.isLoading.value ? null : viewModel.sendOTP,
            child: const Text(
              "Didn't get a mail? Send again",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => AppButton(
            onPressed: viewModel.isLoading.value ? null : viewModel.verifyOTP,
            text: "Verify OTP",
            horizontalPadding: 40,
            textColor: AppColor.white,
            isLoading: viewModel.isLoading.value,
          )),
        ],
      ),
    ),
  );
}

Widget _buildSetPasswordStep() {
  final viewModel = Get.find<AddMailViewModel>();
  
  return Center(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AppText(
                "Create a password",
                style: Ts.bold32(color: AppColor.black),
              ),
            ),
            const Hbox(20),
            AppText(
              "The password must be 8 characters, including 1 uppercase letter, 1 number and 1 special character.",
              style: Ts.regular18(color: AppColor.black),
              textAlign: TextAlign.center,
            ),
            const Hbox(20),
            AppTextfield(
              label: "Password",
              controller: viewModel.passwordController,
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              validator: viewModel.validatePassword,
            ),
            const Hbox(20),
            AppText(
              "Confirm Password",
              style: Ts.regular12(color: AppColor.black),
            ),
            const Hbox(10),
            AppTextfield(
              label: "Confirm Password",
              controller: viewModel.confirmPasswordController,
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              validator: viewModel.validateConfirmPassword,
            ),
            const Hbox(20),
            Row(
              children: [
                AppText(
                  "Unlock with Touch Id",
                  style: Ts.regular14(color: AppColor.black),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Obx(() => CustomSwitch(
                  value: viewModel.enableTouchId.value,
                  onChanged: (value) => viewModel.enableTouchId.value = value,
                )),
              ],
            ),
            const Hbox(20),
            Obx(() => AppButton(
              onPressed: viewModel.isLoading.value 
                ? null 
                : viewModel.createAccount,
              text: viewModel.isLoading.value ? "Creating..." : "Continue",
              horizontalPadding: 40,
              textColor: AppColor.white,
            )),
            const Hbox(20),
            SocialLoginWidget(
              onAppleTap: () {},
              onFacebookTap: () {},
              onGoogleTap: () {},
            )
          ],
        ),
      ),
    ),
  );
}
 Widget _buildSuccessStep() {
  return Center(child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
     crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset(AppImage.check,height: 150,)),
        const Hbox(20),
    Center(child: AppText("Your account has been successfully created!",style: Ts.bold24(color: AppColor.black),textAlign: TextAlign.center,)),
    const Hbox(30),
    AppText("Congratulations your account is ready to use, now you can start using our app",style: Ts.regular18(color: AppColor.black),textAlign: TextAlign.center,),
    const Spacer(),
    AppButton(
    onPressed: () =>  Get.offNamed(AppRoute.navigationbar),
    text: "Continue",
    horizontalPadding: 40,
    textColor: AppColor.white,
    ),
    const Spacer()
        ]
    ),
  )
  ,);
}
}


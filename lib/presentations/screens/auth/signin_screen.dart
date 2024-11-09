import 'package:camdell/presentations/screens/auth/forget_password_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/app_switch.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/presentations/widgets/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:camdell/meta/utils/ts.dart';

enum AuthRoute { email, phone, none }

class SignInController extends GetxController with GetTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  Rx<AuthRoute> authRoute = AuthRoute.none.obs;
  RxBool switchValue = false.obs;
  RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    ever(authRoute, (_) {
      if (authRoute.value != AuthRoute.none) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });

    // Check for arguments passed from WelcomeScreen
    final args = Get.arguments;
    if (args != null && args['authRoute'] != null) {
      authRoute.value = args['authRoute'];
    }

    // Check if there was a previous login with Touch ID enabled
    _checkPreviousLogin();
  }

  Future<void> _checkPreviousLogin() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final userData = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();
      
      if (userData.exists && userData.data()?['enableTouchId'] == true) {
        switchValue.value = true;
      }
    }
  }

  void toggleSwitch(bool value) {
    switchValue.value = value;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number cannot be empty";
    }
    // Remove any spaces or special characters
    final cleanPhone = value.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Check if it's a valid phone number format
    if (!cleanPhone.startsWith('+')) {
      return "Phone number must start with country code (+)";
    }
    if (cleanPhone.length < 10 || cleanPhone.length > 15) {
      return "Enter a valid phone number";
    }
    return null;
  }

  String formatPhoneNumber(String number) {
    final cleanPhone = number.replaceAll(RegExp(r'[^\d+]'), '');
    if (!cleanPhone.startsWith('+')) {
      return '+$cleanPhone';
    }
    return cleanPhone;
  }

  Future<void> signIn() async {
    String? phoneNumber;
    
    // Validate input based on auth route
    if (authRoute.value == AuthRoute.phone) {
      final validation = validatePhoneNumber(phoneController.text);
      if (validation != null) {
        Get.snackbar('Error', validation);
        return;
      }
      phoneNumber = formatPhoneNumber(phoneController.text);
    } else if (authRoute.value == AuthRoute.email) {
      if (!GetUtils.isEmail(emailController.text)) {
        Get.snackbar('Error', 'Please enter a valid email');
        return;
      }
    }

    // Validate password
    if (passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Password cannot be empty');
      return;
    }

    isLoading.value = true;
    try {
      if (phoneNumber != null) {
        // Check if user exists in Firestore
        final querySnapshot = await _firestore
            .collection('users')
            .where('phoneNumber', isEqualTo: phoneNumber)
            .get();

        if (querySnapshot.docs.isEmpty) {
          throw Exception('No account found with this phone number');
        }

        // Sign in using email (phone number) and password
        await _auth.signInWithEmailAndPassword(
          email: "$phoneNumber@placeholder.com",
          password: passwordController.text,
        );

        // Update Touch ID preference if changed
        if (querySnapshot.docs.first.data()['enableTouchId'] != switchValue.value) {
          await _firestore
              .collection('users')
              .doc(querySnapshot.docs.first.id)
              .update({'enableTouchId': switchValue.value});
        }
      } else {
        // Regular email sign in
        await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      }

      Get.snackbar(
        'Success', 
        'Signed in successfully',
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      // Navigate to home screen
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this account';
          break;
        case 'wrong-password':
          errorMessage = 'Invalid password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later';
          break;
      }

      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign in: $e',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void forgotPassword() async {
    String? contact;
    
    if (authRoute.value == AuthRoute.phone) {
      final validation = validatePhoneNumber(phoneController.text);
      if (validation != null) {
        Get.snackbar('Error', validation);
        return;
      }
      contact = formatPhoneNumber(phoneController.text);
    } else if (authRoute.value == AuthRoute.email) {
      if (!GetUtils.isEmail(emailController.text)) {
        Get.snackbar('Error', 'Please enter a valid email');
        return;
      }
      contact = emailController.text;
    }

    if (contact == null) {
      Get.snackbar('Error', 'Please enter your email or phone number');
      return;
    }

    wBottomsheet();
  }

void wBottomsheet() {
  Get.bottomSheet(
    ForgotPasswordBottomSheet(),
    isScrollControlled: true,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}
  @override
  void onClose() {
    animationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImage.logo, height: 100),
                AppText(
                  "Login to your Account",
                  style: Ts.bold32(color: AppColor.secondary),
                  textAlign: TextAlign.center,
                ),
                const Hbox(10),
                Obx(() => SlideTransition(
                      position: controller.slideAnimation,
                      child: _buildAuthField(),
                    )),
                const Hbox(10),
                AppTextfield(
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  label: "Password",
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters long";
                    }
                    return null;
                  },
                ),
                const Hbox(10),
                AppText(
                  isRich: true,
                  "Forget Your Password?",
                  style: Ts.regular14(color: AppColor.black),
                  spans: [
                    TextSpan(
                      text: "Click here",
                      style: Ts.semiBold14(color: AppColor.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => controller.forgotPassword(),
                    ),
                  ],
                ),
                const Hbox(10),
                Row(
                  children: [
                    AppText(
                      "Unlock with Touch Id",
                      style: Ts.regular14(color: AppColor.black),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Obx(() => CustomSwitch(
                          value: controller.switchValue.value,
                          onChanged: controller.toggleSwitch,
                        )),
                  ],
                ),
                const Hbox(14),
                Obx(() => AppButton(
                      text: controller.isLoading.value ? "Signing In..." : "SignIn",
                      onPressed: controller.isLoading.value ? null : controller.signIn,
                      isFullWidth: true,
                      textColor: AppColor.white,
                    )),
                const Hbox(80),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 1, color: AppColor.grey),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: AppText('or continue with'),
                    ),
                    Expanded(
                      child: Divider(thickness: 1, color: AppColor.grey),
                    ),
                  ],
                ),
                const Hbox(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(AppImage.facebook),
                    const Wbox(15),
                    _socialButton(AppImage.apple),
                    const Wbox(15),
                    _socialButton(AppImage.google),
                  ],
                ),
                const Hbox(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthField() {
    switch (controller.authRoute.value) {
      case AuthRoute.email:
        return AppTextfield(
          prefixIcon: Icons.email,
          isPassword: false,
          label: "Email",
          controller: controller.emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email cannot be empty";
            }
            if (!GetUtils.isEmail(value)) {
              return "Please enter a valid email";
            }
            return null;
          },
        );
      case AuthRoute.phone:
        return AppTextfield(
          prefixIcon: Icons.phone,
          isPassword: false,
          label: "Phone Number",
          controller: controller.phoneController,
          validator: controller.validatePhoneNumber,
        );
      case AuthRoute.none:
        return const SizedBox.shrink();
    }
  }

  Widget _socialButton(String images) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(images, height: 24),
    );
  }
   

}
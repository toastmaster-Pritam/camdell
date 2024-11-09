
import 'package:camdell/core/route/routes.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userData = Rx<Map<String, dynamic>>({});
  var isNewUser = false.obs;
  @override
  void onInit() {
    super.onInit();
    _initializeFacebookSDK();
  }


  Future<void> _initializeFacebookSDK() async {
    await FacebookAuth.instance.webAndDesktopInitialize(
      appId: "896039815441169", 
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }
  Future<void> signUpOrLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        this.userData.value = userData;
        
        // Check if the user is new or existing (this is a simplified check)
        isNewUser.value = userData['signed_up_recently'] ?? false;

        if (isNewUser.value) {
          // Perform any additional signup steps here
          await _completeSignUp();
        }

        isLoggedIn.value = true;
        
        // Navigate to the navigation bar screen
        _navigateToHome();
      } else {
        Get.snackbar('Error', result.message ?? 'Facebook authentication failed');
        print(result.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during login: $e');
      print(e);
    }
  }

  void _navigateToHome() {
    // Replace 'NavigationBarScreen' with the actual name of your navigation bar screen
    Get.offAllNamed(AppRoute.navigationbar); // This will remove all previous routes
  }

  Future<void> _completeSignUp() async {
    // Perform any additional signup steps
    // For example, you might want to save additional user info to your own backend
    print('Completing signup for new user: ${userData.value['name']}');
    // Add your signup logic here
  }

  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
    isLoggedIn.value = false;
    userData.value = {};
    isNewUser.value = false;
    Get.offAll(AppRoute.welcome);
  }
}
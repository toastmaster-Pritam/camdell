import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:camdell/core/route/routes.dart';

class GoogleAuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  var isLoggedIn = false.obs;
  var userData = Rx<Map<String, dynamic>>({});
  var isNewUser = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Check if user is already signed in
    checkCurrentUser();
  }

  Future<void> checkCurrentUser() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signInSilently();
      if (account != null) {
        final userData = await _getUserData(account);
        this.userData.value = userData;
        isLoggedIn.value = true;
      }
    } catch (e) {
      print('Error checking current user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUpOrLogin() async {
    isLoading.value = true;
    try {
      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        Get.snackbar(
          'Error',
          'Sign in cancelled',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential authResult = 
          await _auth.signInWithCredential(credential);
      
      // Check if the user is new
      isNewUser.value = authResult.additionalUserInfo?.isNewUser ?? false;

      // Get user data
      final userData = await _getUserData(googleUser);
      this.userData.value = userData;

      if (isNewUser.value) {
        await _completeSignUp(userData);
      }

      isLoggedIn.value = true;
      _navigateToHome();

    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred during sign in: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error during Google sign in: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> _getUserData(GoogleSignInAccount account) async {
    return {
      'id': account.id,
      'email': account.email,
      'displayName': account.displayName,
      'photoUrl': account.photoUrl,
      'serverAuthCode': account.serverAuthCode,
    };
  }

  Future<void> _completeSignUp(Map<String, dynamic> userData) async {
    try {
      // Add any additional signup logic here
      // For example, creating a user profile in your backend
      print('Completing signup for new user: ${userData['displayName']}');
      
      // You might want to make an API call to your backend
      // await _apiService.createUserProfile(userData);
      
    } catch (e) {
      print('Error completing signup: $e');
      // Handle error appropriately
    }
  }

  void _navigateToHome() {
    Get.offAllNamed(AppRoute.navigationbar);
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        _auth.signOut(),
      ]);
      
      isLoggedIn.value = false;
      userData.value = {};
      isNewUser.value = false;
      
      Get.offAllNamed(AppRoute.welcome);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error during logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error during logout: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
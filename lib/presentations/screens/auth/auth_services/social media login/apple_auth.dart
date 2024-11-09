import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:camdell/core/route/routes.dart';

class AppleAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  var isLoggedIn = false.obs;
  var userData = Rx<Map<String, dynamic>>({});
  var isNewUser = false.obs;
  var isLoading = false.obs;

  // Replace these with your actual values
  static const String webClientId = 'your.web.client.id';
  static const String redirectUrl = 'your-redirect-url';
  
  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signUpOrLogin() async {
    // Check platform first
    if (!Platform.isIOS) {
      Get.snackbar(
        'Notice',
        'Apple Sign In is only available on iOS devices',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {
      // Generate nonce for secure authentication
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
        webAuthenticationOptions: Platform.isAndroid 
            ? WebAuthenticationOptions(
                clientId: webClientId,
                redirectUri: Uri.parse(redirectUrl),
              )
            : null,
      );

      // Create an OAuthCredential from the Apple credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in to Firebase with the Apple OAuth credential
      final authResult = await _auth.signInWithCredential(oauthCredential);
      
      // Check if user is new
      isNewUser.value = authResult.additionalUserInfo?.isNewUser ?? false;

      // Process user data
      await _processUserData(authResult.user, appleCredential);

      if (isNewUser.value) {
        await _completeSignUp();
      }

      isLoggedIn.value = true;
      _navigateToHome();

    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _processUserData(User? firebaseUser, AuthorizationCredentialAppleID appleCredential) async {
    if (firebaseUser == null) return;

    final Map<String, dynamic> userDataMap = {
      'uid': firebaseUser.uid,
      'email': firebaseUser.email ?? appleCredential.email,
      'displayName': firebaseUser.displayName,
    };

    if (appleCredential.givenName != null || appleCredential.familyName != null) {
      final String fullName = [
        appleCredential.givenName ?? '',
        appleCredential.familyName ?? ''
      ].where((name) => name.isNotEmpty).join(' ');

      if (fullName.isNotEmpty) {
        userDataMap['displayName'] = fullName;
        
        if (firebaseUser.displayName == null || firebaseUser.displayName!.isEmpty) {
          await firebaseUser.updateDisplayName(fullName);
        }
      }
    }

    userData.value = userDataMap;
  }

  Future<void> _completeSignUp() async {
    try {
      print('Completing signup for new user: ${userData.value['displayName']}');
    } catch (e) {
      print('Error completing signup: $e');
    }
  }

  void _navigateToHome() {
    Get.offAllNamed(AppRoute.navigationbar);
  }

  void _handleError(dynamic error) {
    String errorMessage = 'An error occurred during Apple sign in';
    
    if (error is SignInWithAppleAuthorizationException) {
      switch (error.code) {
        case AuthorizationErrorCode.canceled:
          errorMessage = 'Sign in was cancelled';
          break;
        case AuthorizationErrorCode.invalidResponse:
          errorMessage = 'Invalid response received';
          break;
        case AuthorizationErrorCode.notHandled:
          errorMessage = 'Sign in not handled';
          break;
        default:
          errorMessage = 'Authorization error: ${error.code}';
          break;
      }
    }

    Get.snackbar(
      'Error',
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
    );
    print('Detailed error: $error');
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
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
    } finally {
      isLoading.value = false;
    }
  }
}
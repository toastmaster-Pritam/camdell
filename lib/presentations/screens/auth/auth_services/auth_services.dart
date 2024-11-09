import 'dart:async';
import 'package:camdell/core/route/routes.dart';
import 'package:camdell/presentations/screens/auth/auth_services/firebase_auth.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class PhoneAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  final RxBool isCodeSent = false.obs;

 // Send OTP via Firebase Phone Auth
  Future<void> sendOTP(String phoneNumber) async {
    try {
      final completer = Completer<void>();

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification if Android supports it
          await _auth.signInWithCredential(credential);
          completer.complete();
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(Exception(e.message));
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          isCodeSent.value = true;
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
        timeout: const Duration(seconds: 60),
      );

      await completer.future; // Wait for the verification process to complete
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  // Verify OTP
  Future<bool> verifyOTP(String otp) async {
    try {
      if (_verificationId == null || !isCodeSent.value) {
        throw Exception('Please request OTP first');
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user != null;
    } catch (e) {
      if (e.toString().contains('invalid-verification-code')) {
        throw Exception('Invalid OTP code');
      }
      throw Exception('Failed to verify OTP: $e');
    }
  }

  // Reset the service state
  void reset() {
    _verificationId = null;
    isCodeSent.value = false;
  }
}
class AddMailViewModel extends GetxController {
  final PhoneAuthService _authService = PhoneAuthService();
  final FirebaseAuthService _firebaseauth = FirebaseAuthService();
  final LocalAuthentication _localAuth = LocalAuthentication();
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxInt resendTimer = 0.obs;
  Timer? _timer;
  final RxString selectedCountryCode = '+1'.obs;
  final RxBool enableTouchId = false.obs;
  final RxBool isBiometricAvailable = false.obs;
  final RxInt currentStep = 1.obs;
  final prefixIcon = Icons.email.obs;
  final RxBool isLoading = false.obs;
  final RxString verificationMessage = ''.obs;
  final RxBool isEmailValid = false.obs;
  final RxList<String> otpDigits = List.generate(6, (index) => '').obs;
  final List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_updatePrefixIcon);
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final bool canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
      
      if (canAuthenticate) {
        final List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();
        isBiometricAvailable.value = availableBiometrics.isNotEmpty;
        if (!isBiometricAvailable.value) {
          enableTouchId.value = false;
        }
      } else {
        isBiometricAvailable.value = false;
        enableTouchId.value = false;
      }
    } catch (e) {
      isBiometricAvailable.value = false;
      enableTouchId.value = false;
    }
  }

 void _updatePrefixIcon() {
    final text = emailController.text.trim();
    
    if (text.isEmpty) {
      prefixIcon.value = Icons.email;
      isEmailValid.value = false;
      return;
    }

    if (isValidPhoneNumber(text)) {
      prefixIcon.value = Icons.phone;
      isEmailValid.value = true;
    } else {
      prefixIcon.value = Icons.email;
      isEmailValid.value = false;
    }
  }

  // Update country code when changed in picker
  void updateCountryCode(CountryCode countryCode) {
    selectedCountryCode.value = countryCode.dialCode ?? '+1';
  }

  bool isValidPhoneNumber(String text) {
    // Only validate the 10 digits, since country code is handled separately
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(text);
  }

  String getFullPhoneNumber() {
    // Combine country code with phone number
    return '${selectedCountryCode.value}${emailController.text.trim()}';
  }

  Future<void> sendOTP() async {
    final phoneNumber = emailController.text.trim();
    
    if (!isValidPhoneNumber(phoneNumber)) {
      Get.snackbar(
        'Error', 
        'Please enter a valid 10-digit phone number',
        duration: const Duration(seconds: 5),
      );
      return;
    }

    if (resendTimer.value > 0) {
      Get.snackbar(
        'Wait',
        'Please wait before requesting a new code',
        backgroundColor: Colors.orange.withOpacity(0.1),
        colorText: Colors.orange,
      );
      return;
    }

    isLoading.value = true;
    try {
      final fullPhoneNumber = getFullPhoneNumber();
      
      // Check if phone number already exists
      final bool exists = await _firebaseauth.phoneNumberExists(fullPhoneNumber);
      if (exists) {
        Get.snackbar('Error', 'This phone number is already registered');
        return;
      }

      await _authService.sendOTP(fullPhoneNumber);
      startResendTimer();
      
      Get.snackbar(
        'Success', 
        'OTP sent to $fullPhoneNumber',
        duration: const Duration(seconds: 5),
      );
      incrementStep();
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP: $e');
    } finally {
      isLoading.value = false;
    }
  }
    Future<void> verifyOTP() async {
    final otp = otpDigits.join();
    if (otp.length != 6) {
      Get.snackbar('Error', 'Please enter valid 6-digit OTP');
      return;
    }

    isLoading.value = true;
    try {
      final verified = await _authService.verifyOTP(otp);

      if (verified) {
        verificationMessage.value = 'Phone number verified successfully';
        incrementStep();
      } else {
        verificationMessage.value = 'Invalid OTP';
        Get.snackbar('Error', 'Invalid OTP');
      }
    } catch (e) {
      verificationMessage.value = 'Verification error: $e';
      Get.snackbar('Error', 'Verification failed: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> signIn() async {
    final phoneNumber = emailController.text.trim();
    
    if (!isValidPhoneNumber(phoneNumber)) {
      Get.snackbar('Error', 'Please enter a valid 10-digit phone number');
      return;
    }

    isLoading.value = true;
    try {
      final fullPhoneNumber = getFullPhoneNumber();
      
      // Check if phone exists before attempting sign in
      final bool exists = await _firebaseauth.phoneNumberExists(fullPhoneNumber);
      if (!exists) {
        Get.snackbar('Error', 'No account found with this phone number');
        return;
      }

      // Check if biometric auth is enabled and available
      if (await _firebaseauth.isBiometricEnabled()) {
        final bool authenticated = await _firebaseauth.authenticateWithBiometrics();
        if (!authenticated) {
          Get.snackbar('Error', 'Biometric authentication failed');
          return;
        }
      }

      await _firebaseauth.signInWithPhoneAndPassword(
        phoneNumber: fullPhoneNumber,
        password: passwordController.text,
      );
      
      Get.snackbar(
        'Success', 
        'Signed in successfully!',
        duration: const Duration(seconds: 3),
      );
      
      Get.offAllNamed(AppRoute.navigationbar);
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> createAccount() async {
    if (validatePassword(passwordController.text) != null) {
      Get.snackbar('Error', 'Please enter a valid password');
      return;
    }
    if (validateConfirmPassword(confirmPasswordController.text) != null) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading.value = true;
    try {
      final fullPhoneNumber = getFullPhoneNumber();
      
      // Double-check phone number uniqueness before creating account
      final bool exists = await _firebaseauth.phoneNumberExists(fullPhoneNumber);
      if (exists) {
        Get.snackbar('Error', 'This phone number is already registered');
        return;
      }

      // Only enable Touch ID if device supports it
      final bool touchIdEnabled = enableTouchId.value && isBiometricAvailable.value;
      
      await _firebaseauth.createUserWithPhoneAndPassword(
        phoneNumber: fullPhoneNumber,
        password: passwordController.text,
        enableTouchId: touchIdEnabled,
      );
      
      Get.snackbar(
        'Success', 
        'Account created successfully!',
        duration: const Duration(seconds: 3),
      );
      
      Get.offAllNamed(AppRoute.navigationbar);
    } catch (e) {
      Get.snackbar('Error', 'Failed to create account: $e');
    } finally {
      isLoading.value = false;
    }
  }
  // Rest of the existing methods remain the same
  void startResendTimer() {
    resendTimer.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void onOTPDigitChanged(String value, int index) {
    if (value.length == 1) {
      otpDigits[index] = value;
      if (index < 5) {
        otpFocusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty && index > 0) {
      otpDigits[index] = '';
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least 1 uppercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least 1 number";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least 1 special character";
    }
    return null;
  }
   void incrementStep() {
    if (currentStep.value < 5) {
      currentStep.value++;
    }
  }

  void decrementStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  void onClose() {
    emailController.removeListener(_updatePrefixIcon);
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _timer?.cancel();
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
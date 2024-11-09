import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocalAuthentication _localAuth = LocalAuthentication();
  
  // Key for storing biometric preference
  static const String _biometricKey = 'biometric_enabled';
  static const String _userPhoneKey = 'user_phone';

  // Create user with phone and password
  Future<void> createUserWithPhoneAndPassword({
    required String phoneNumber,
    required String password,
    required bool enableTouchId,
  }) async {
    try {
      // Check if phone number already exists
      final bool exists = await phoneNumberExists(phoneNumber);
      if (exists) {
        throw Exception('This phone number is already registered');
      }

      // Get current user (should exist after OTP verification)
      final User? user = _auth.currentUser;
      if (user == null) throw Exception('No authenticated user found');

      // Create password credential
      final credential = EmailAuthProvider.credential(
        email: "$phoneNumber@placeholder.com",
        password: password,
      );

      // Link password credential to phone auth
      await user.linkWithCredential(credential);

      // Store additional user data in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'phoneNumber': phoneNumber,
        'enableTouchId': enableTouchId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // If touch ID is enabled, store the preference
      if (enableTouchId) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_biometricKey, true);
        await prefs.setString(_userPhoneKey, phoneNumber);
      }

    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // Sign in with phone and password
  Future<UserCredential> signInWithPhoneAndPassword({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Check if biometric auth is enabled for this user
      final prefs = await SharedPreferences.getInstance();
      final bool biometricEnabled = prefs.getBool(_biometricKey) ?? false;
      final String? storedPhone = prefs.getString(_userPhoneKey);

      // If biometric is enabled and it's the same user
      if (biometricEnabled && storedPhone == phoneNumber) {
        final bool authenticated = await authenticateWithBiometrics();
        if (!authenticated) {
          throw Exception('Biometric authentication failed');
        }
      }

      // Query Firestore to get user with phone number
      final querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('No user found with this phone number');
      }

      // Sign in using email (phone number) and password
      return await _auth.signInWithEmailAndPassword(
        email: "$phoneNumber@placeholder.com",
        password: password,
      );

    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Check if phone number exists
  Future<bool> phoneNumberExists(String phoneNumber) async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  // Authenticate using biometrics
  Future<bool> authenticateWithBiometrics() async {
    try {
      // Check if biometric authentication is available
      final bool canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      if (!canAuthenticate) {
        throw Exception('Biometric authentication not available');
      }

      // Get available biometrics
      final List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        throw Exception('No biometrics enrolled on this device');
      }

      // Authenticate
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to sign in',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      return didAuthenticate;
    } catch (e) {
      throw Exception('Biometric authentication failed: $e');
    }
  }

  // Toggle biometric authentication
  Future<void> toggleBiometricAuth(bool enable, String phoneNumber) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_biometricKey, enable);
      if (enable) {
        await prefs.setString(_userPhoneKey, phoneNumber);
      } else {
        await prefs.remove(_userPhoneKey);
      }

      // Update Firestore
      final User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'enableTouchId': enable,
        });
      }
    } catch (e) {
      throw Exception('Failed to toggle biometric authentication: $e');
    }
  }

  // Check if biometric auth is enabled
  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricKey) ?? false;
  }
}
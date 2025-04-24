import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LinkPhoneController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isOtpSent = false;
  bool isLoading = false;
  String? _verificationId;

  void reset() {
    isOtpSent = false;
    isLoading = false;
    _verificationId = null;
    update();
  }

  Future<void> sendOtp(BuildContext context, String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      _showSnackbar(context, 'Phone number cannot be empty');
      return;
    }

    isLoading = true;
    update();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Optionally handle automatic verification
        debugPrint('Auto verification completed');
      },
      verificationFailed: (FirebaseAuthException e) {
        _showSnackbar(context, 'OTP send failed: ${e.message}');
        isLoading = false;
        update();
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        isOtpSent = true;
        isLoading = false;
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<bool> verifyOtp(BuildContext context, String otp) async {
    if (_verificationId == null) {
      _showSnackbar(context, 'OTP not sent yet');
      return false;
    }

    if (otp.isEmpty) {
      _showSnackbar(context, 'Please enter the OTP');
      return false;
    }

    isLoading = true;
    update();

    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      // No sign-in yet, just link
      final user = _auth.currentUser;
      if (user == null) {
        _showSnackbar(context, 'User not logged in');
        isLoading = false;
        update();
        return false;
      }

      await user.linkWithCredential(credential);
      

      _showSnackbar(context, 'Phone number linked successfully');
      isLoading = false;
      update();
      return true;
    } on FirebaseAuthException catch (e) {
      _showSnackbar(context, 'OTP verification failed: ${e.message}');
      isLoading = false;
      update();
      return false;
    }
  }

  Future<void> linkPhoneNumber(BuildContext context) async {
    // Already handled in verifyOtp
    // This function is kept for any additional future logic
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

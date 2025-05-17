import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webkit/controller/my_controller.dart';

class ForgotPassword2Controller extends MyController {
  bool loading = false;
  String? errorMessage;

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      loading = true;
      errorMessage = null;
      update();
      
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      
      Get.snackbar(
        'Success',
        'Password reset email sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/auth/login2');
    } on FirebaseAuthException catch (e) {
      errorMessage = _getErrorMessage(e.code);
    } finally {
      loading = false;
      update();
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'invalid-email':
        return 'Please enter a valid email address';
      case 'too-many-requests':
        return 'Too many requests. Try again later';
      default:
        return 'Failed to send reset email. Please try again';
    }
  }

  void gotoLogIn() {
    Get.toNamed('/auth/login2');
  }
}
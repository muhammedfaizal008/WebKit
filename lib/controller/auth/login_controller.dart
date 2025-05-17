import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webkit/controller/my_controller.dart';

class LoginController extends MyController {
  String email = '';
  String password = '';

  void setEmail(String value) => email = value
      ;
  void setPassword(String value) => password = value;

  bool showPassword = false, loading = false, isChecked = false;

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? false;
    update();
  }

  Future<void> onLogin() async {

    loading = true;
    update();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        "Login Success",
        "Login Success",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
        Get.toNamed('/');
          

      // Get.toNamed("/dashboard");
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Login Failed",
        e.message ?? "Unknown error",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );

    } finally {
      loading = false;
      update();
    }
  }



  void goToForgotPassword() => Get.toNamed('/auth/forgot_password1');
  void gotoRegister() => Get.offAndToNamed('/auth/register');
}

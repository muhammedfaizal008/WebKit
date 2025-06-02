import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/auth/login_controller.dart'; // Keep using the same controller
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/images.dart';
import 'package:webkit/views/layouts/auth_layout_2.dart';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2>
    with SingleTickerProviderStateMixin, UIMixin {
  late LoginController controller; // Using the same controller
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoginController());
  }



  @override
  Widget build(BuildContext context) {
    return AuthLayout2(
      child: GetBuilder<LoginController>(
        init: controller,
        builder: (controller) {
          return MyContainer(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   Images.logoIcon,
                      //   height: 24,
                      //   color: contentTheme.primary,
                      // ),
                      // MySpacing.width(16),
                      MyText.bodyMedium(
                        "Matrimony App",
                        fontSize: 24,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  Center(
                    child: Column(
                      children: [
                        MyText.bodyLarge(
                          "Sign In",
                          fontSize: 20,
                          fontWeight: 600,
                        ),
                        // MySpacing.height(8),
                        // MyText.bodyMedium(
                        //   "Stay updated on your professional world",
                        //   fontSize: 12,
                        //   fontWeight: 600,
                        //   xMuted: true,
                        // )
                      ],
                    ),
                  ),
                  MySpacing.height(20),
                  MyText.labelMedium("Email Address"),
                  MySpacing.height(8),
                  TextFormField(
                    onChanged: controller.setEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: MyTextStyle.bodySmall(),
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      prefixIcon: const Icon(LucideIcons.mail, size: 20),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }
                      if (!GetUtils.isEmail(value.trim())) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  MySpacing.height(20),
                  MyText.labelMedium("Password"),
                  MySpacing.height(8),
                    TextFormField(
                    onChanged: controller.setPassword,
                    obscureText: !controller.showPassword,
                    style: MyTextStyle.bodySmall(),
                    onFieldSubmitted: (_) {
                      if (!controller.loading) {
                      if (_formKey.currentState?.validate() ?? false) {
                        controller.onLogin();
                      }
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      prefixIcon: const Icon(LucideIcons.lock, size: 20),
                      suffixIcon: InkWell(
                      onTap: controller.onChangeShowPassword,
                      child: Icon(
                        controller.showPassword
                          ? LucideIcons.eye
                          : LucideIcons.eyeOff,
                        size: 20,
                      ),
                      ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                      return "Password is required";
                      }
                      return null;
                    },
                    ),
                  MySpacing.height(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // InkWell(
                      //   onTap: () => controller
                      //       .onChangeCheckBox(!controller.isChecked),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //         onChanged: controller.onChangeCheckBox,
                      //         value: controller.isChecked,
                      //         materialTapTargetSize:
                      //             MaterialTapTargetSize.shrinkWrap,
                      //         visualDensity: getCompactDensity,
                      //       ),
                      //       MySpacing.width(16),
                      //       MyText.bodyMedium("Remember Me"),
                      //     ],
                      //   ),
                      // ),
                      MyButton.text(
                        onPressed: controller.goToForgotPassword,
                        elevation: 0,
                        padding: MySpacing.xy(8, 0),
                        splashColor: contentTheme.secondary.withOpacity(0.1),
                        child: MyText.labelSmall(
                          'Forgot Password?',
                          color: contentTheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  MySpacing.height(16),
                  Center(
                    child: MyButton.rounded(
                      onPressed: controller.loading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                controller.onLogin();
                              }
                            },
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: contentTheme.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.loading)
                            SizedBox(
                              height: 14,
                              width: 14,
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.onPrimary,
                                strokeWidth: 1.2,
                              ),
                            ),
                          if (controller.loading) MySpacing.width(16),
                          MyText.bodySmall(
                            'Login',
                            color: contentTheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  MySpacing.height(20),
                  // Center(
                  //   child: MyButton.text(
                  //     onPressed: controller.gotoRegister,
                  //     elevation: 0,
                  //     padding: MySpacing.x(16),
                  //     splashColor: contentTheme.secondary.withOpacity(0.1),
                  //     child: MyText.labelMedium(
                  //       "Don't have a account?",
                  //       color: contentTheme.secondary,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
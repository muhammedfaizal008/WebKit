import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/auth/forgot_password_2_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/images.dart';
import 'package:webkit/views/layouts/auth_layout_2.dart';

class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({super.key});

  @override
  State<ForgotPassword2> createState() => _ForgotPassword2State();
}

class _ForgotPassword2State extends State<ForgotPassword2>
    with SingleTickerProviderStateMixin, UIMixin {
  late ForgotPassword2Controller controller;
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = Get.put(ForgotPassword2Controller());
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout2(
      child: GetBuilder<ForgotPassword2Controller>(
        init: controller,
        builder: (controller) {
          return MyContainer(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.logoIcon,
                        height: 24,
                        color: contentTheme.primary,
                      ),
                      MySpacing.width(16),
                      MyText.bodyMedium(
                        "Matrimony App",
                        fontSize: 24,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  Column(
                    children: [
                      MyText.bodyLarge(
                        "Forgot Password",
                        fontSize: 20,
                        fontWeight: 600,
                      ),
                      MySpacing.height(12),
                      MyText.bodyMedium(
                        "Enter your email and we'll send you instructions to reset your password",
                        textAlign: TextAlign.center,
                        fontSize: 12,
                        fontWeight: 600,
                        xMuted: true,
                      ),
                      MySpacing.height(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium("Email Address"),
                          MySpacing.height(8),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!GetUtils.isEmail(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              labelStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: const Icon(
                                LucideIcons.mail,
                                size: 20,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                          ),
                          if (controller.errorMessage != null)
                            Padding(
                              padding: MySpacing.top(8),
                              child: MyText.bodySmall(
                                controller.errorMessage!,
                                color: contentTheme.danger,
                              ),
                            ),
                        ],
                      ),
                      MySpacing.height(20),
                      Column(
                        children: [
                          MyButton.rounded(
                            onPressed: controller.loading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.sendPasswordResetEmail(
                                          _emailController.text.trim());
                                    }
                                  },
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.loading
                                    ? SizedBox(
                                        height: 14,
                                        width: 14,
                                        child: CircularProgressIndicator(
                                          color: theme.colorScheme.onPrimary,
                                          strokeWidth: 1.2,
                                        ),
                                      )
                                    : Container(),
                                if (controller.loading) MySpacing.width(16),
                                MyText.bodySmall(
                                  'Send Reset Link',
                                  color: contentTheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          MySpacing.height(12),
                          MyButton.text(
                            onPressed: controller.gotoLogIn,
                            elevation: 0,
                            padding: MySpacing.x(16),
                            splashColor:
                                contentTheme.secondary.withOpacity(0.1),
                            child: MyText.labelMedium(
                              'Back to login',
                              color: contentTheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
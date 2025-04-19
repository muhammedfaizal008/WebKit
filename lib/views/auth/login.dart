    import 'package:flutter/material.dart';
    import 'package:get/get_state_manager/get_state_manager.dart';
  import 'package:get/get_utils/src/get_utils/get_utils.dart';
    import 'package:get/instance_manager.dart';
    import 'package:lucide_icons/lucide_icons.dart';
    import 'package:webkit/controller/auth/login_controller.dart';
    import 'package:webkit/helpers/extensions/string.dart';
    import 'package:webkit/helpers/theme/app_theme.dart';
    import 'package:webkit/helpers/utils/ui_mixins.dart';
    import 'package:webkit/helpers/widgets/my_button.dart';
    import 'package:webkit/helpers/widgets/my_flex.dart';
    import 'package:webkit/helpers/widgets/my_flex_item.dart';
    import 'package:webkit/helpers/widgets/my_responsiv.dart';
    import 'package:webkit/helpers/widgets/my_spacing.dart';
    import 'package:webkit/helpers/widgets/my_text.dart';
    import 'package:webkit/helpers/widgets/my_text_style.dart';
    import 'package:webkit/helpers/widgets/responsive.dart';
    import 'package:webkit/images.dart';
import 'package:webkit/views/dashboard.dart';
    import 'package:webkit/views/layouts/auth_layout.dart';

  // unchanged imports ...
  class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage>
      with SingleTickerProviderStateMixin, UIMixin {
    late LoginController controller;
    final _formKey = GlobalKey<FormState>();


    @override
    void initState() {
      super.initState();
      controller = Get.put(LoginController());  
    }

    @override
    Widget build(BuildContext context) {
      return AuthLayout(
        child: GetBuilder<LoginController>(
          init: controller,
          builder: (controller) {
            return Padding(
              padding: MySpacing.all(16),
              child: MyFlex(
                contentPadding: false,
                children: [
                  // 📷 Image (Unchanged)
                  MyFlexItem(
                    sizes: "lg-6",
                    child: MyResponsive(
                      builder: (_, __, type) {
                        return type.index <= MyScreenMediaType.lg.index
                            ? Image.asset(
                                Images.login[3],
                                fit: BoxFit.cover,
                                height: 500,
                              )
                            : const SizedBox();
                      },
                    ),
                  ),

                  // 🔐 Login Form
                  MyFlexItem(
                    sizes: "lg-6",
                    child: Padding(
                      padding: MySpacing.y(28),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: MyText.titleLarge(
                                "Welcome",
                                fontWeight: 600,
                                fontSize: 24,
                              ),
                            ),
                            Center(
                              child: MyText.bodyMedium(
                                "Login to your account",
                                fontSize: 16,
                              ),
                            ),
                            MySpacing.height(40),

                            // 📧 Email Field
                            MyText.bodyMedium("Your Email"),
                            MySpacing.height(8),
                            TextFormField(
                              onChanged: controller.setEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                prefixIcon: const Icon(LucideIcons.mail),
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


                            MySpacing.height(16),

                            // 🔒 Password Field
                            MyText.labelMedium("Password"),
                            MySpacing.height(8),
                            TextFormField(
                              onChanged: controller.setPassword,
                              obscureText: !controller.showPassword,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: const Icon(LucideIcons.lock),
                                suffixIcon: InkWell(
                                  onTap: controller.onChangeShowPassword,
                                  child: Icon(
                                    controller.showPassword ? LucideIcons.eye : LucideIcons.eyeOff,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Password is required";
                                }
                                if (value.length < 6 || value.length > 10) {
                                  return "Password must be 6–10 characters";
                                }
                                return null;
                              },
                            ),


                            // 🔘 Remember Me + Forgot
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => controller
                                      .onChangeCheckBox(!controller.isChecked),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        onChanged: controller.onChangeCheckBox,
                                        value: controller.isChecked,
                                        activeColor: theme.colorScheme.primary,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: getCompactDensity,
                                      ),
                                      MySpacing.width(16),
                                      MyText.bodyMedium("Remember Me"),
                                    ],
                                  ),
                                ),
                                MyButton.text(
                                  onPressed: controller.goToForgotPassword,
                                  elevation: 0,
                                  padding: MySpacing.xy(8, 0),
                                  splashColor:
                                      contentTheme.secondary.withOpacity(0.1),
                                  child: MyText.labelSmall(
                                    'Forgot Password?',
                                    color: contentTheme.secondary,
                                  ),
                                ),
                              ],
                            ),

                            MySpacing.height(40),

                            // ▶ Login Button
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
                                  mainAxisSize: MainAxisSize.min,
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

                            // 📝 Register CTA
                            Center(
                              child: MyButton.text(
                                onPressed: controller.gotoRegister,
                                elevation: 0,
                                padding: MySpacing.x(16),
                                splashColor:
                                    contentTheme.secondary.withOpacity(0.1),
                                child: MyText.labelMedium(
                                  "Don't have an account?",
                                  color: contentTheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

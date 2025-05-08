import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_member_controller.dart';
import 'package:webkit/controller/apps/members/link_phone_controller.dart';
import 'package:webkit/helpers/extensions/extensions.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';

class PhoneRegistrationScreen extends StatelessWidget {
  const PhoneRegistrationScreen({
    super.key,
    required this.phoneNumberController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.otpController,
    required this.context,
    required this.contentTheme,
    required this.defaultTabController,
  });

  final TextEditingController phoneNumberController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController otpController;
  final BuildContext context;
  final ContentTheme contentTheme;
  final TabController defaultTabController;

  @override
  Widget build(BuildContext context) {
    late AddMemberController addMemberController =
        Get.find<AddMemberController>();
    return MyFlexItem(
      sizes: "lg-7",
      child: MyContainer.bordered(
        paddingAll: 0,
        child: GetBuilder<LinkPhoneController>(
          builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: MySpacing.x(8),
                  child: MyContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(LucideIcons.toggleRight, size: 16),
                        MySpacing.width(12),
                        MyText.titleMedium(
                          "Phone Registration".tr().capitalizeWords,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: MySpacing.nTop(flexSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium("Phone Number".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          hintText: "Enter your Phone Number",
                          hintStyle: MyTextStyle.bodySmall(xMuted: true),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: focusedInputBorder,
                          contentPadding: MySpacing.all(16),
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      MySpacing.height(20),

                      // Show OTP field if sent
                      if (controller.isOtpSent) ...[
                        MyText.labelMedium("Enter OTP".tr()),
                        MySpacing.height(8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter OTP",
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          keyboardType: TextInputType.number,
                          controller: otpController,
                        ),
                        MySpacing.height(20),
                      ],

                      // Buttons
                      if (!controller.isLoading)
                        Row(
                          children: [
                            if (!controller.isOtpSent)
                              MyButton(
                                onPressed: () async {
                                  await controller.sendOtp(
                                    context,
                                    phoneNumberController.text,
                                  );
                                },
                                elevation: 0,
                                padding: MySpacing.xy(20, 16),
                                backgroundColor: contentTheme.primary,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: MyText.bodySmall(
                                  'Send Otp'.tr().capitalizeWords,
                                  color: contentTheme.onPrimary,
                                ),
                              ),
                            if (controller.isOtpSent)
                              MyButton(
                                onPressed: () async {
                                  // Step 1: Verify the OTP
                                  bool verified = await controller.verifyOtp(
                                      context, otpController.text);

                                  // Step 2: If verified, link the number
                                  if (verified) {
                                    await controller.linkPhoneNumber(context);
                                    await addMemberController.savePhoneNumber(
                                        phoneNumberController.text);
                                    Get.snackbar(
                                      "Success",
                                      "Phone Number Linked Successfully",
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    );
                                    controller.reset();

                                    defaultTabController.animateTo(2);
                                    // Navigate to the next screen or perform any other action
                                  }
                                },
                                elevation: 0,
                                padding: MySpacing.xy(20, 16),
                                backgroundColor: contentTheme.primary,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: MyText.bodySmall(
                                  'Verify & Link'.tr().capitalizeWords,
                                  color: contentTheme.onPrimary,
                                ),
                              ),
                          ],
                        ),

                      if (controller.isLoading)
                        const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

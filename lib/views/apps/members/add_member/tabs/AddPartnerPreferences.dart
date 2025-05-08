import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_member_controller.dart';
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

class AddPartnerPreferences extends StatelessWidget {
  const AddPartnerPreferences({
    super.key,
    required this.agePartnerController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.locationPartnerController,
    required this.professionPartnerController,
    required this.educationPartnerController,
    required this.formKey,
    required this.controller,
    required this.contentTheme,
  });

  final TextEditingController agePartnerController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController locationPartnerController;
  final TextEditingController professionPartnerController;
  final TextEditingController educationPartnerController;
  final GlobalKey<FormState> formKey;
  final AddMemberController controller;
  final ContentTheme contentTheme;

  @override
  Widget build(BuildContext context) {
    return MyFlexItem(
      sizes: "lg-7",
      child: MyContainer.bordered(
        paddingAll: 0,
        child: Column(
          children: [
            Padding(
              padding: MySpacing.x(8),
              child: MyContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      LucideIcons.toggleRight,
                      size: 16,
                    ),
                    MySpacing.width(12),
                    MyText.titleMedium(
                      "partner_preferences".tr().capitalizeWords,
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                              "Partners Age".tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your partners age";
                                }
                                final age = int.tryParse(value);
                                if (age == null || age < 18 || age > 120) {
                                  return "Enter a valid age (18-120)";
                                }
                                return null;
                              },
                              controller: agePartnerController,
                              decoration: InputDecoration(
                                  hintText: "Enter your Partners Age",
                                  hintStyle:
                                      MyTextStyle.bodySmall(xMuted: true),
                                  border: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: focusedInputBorder,
                                  contentPadding: MySpacing.all(16),
                                  isCollapsed: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never),
                            ),
                          ],
                        ),
                      ),
                      MySpacing.width(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                              "partners location".tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your partners location";
                                }
                                return null;
                              },
                              controller: locationPartnerController,
                              decoration: InputDecoration(
                                  hintText: "Enter your partners location",
                                  hintStyle:
                                      MyTextStyle.bodySmall(xMuted: true),
                                  border: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: focusedInputBorder,
                                  contentPadding: MySpacing.all(16),
                                  isCollapsed: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  MySpacing.height(20),
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium(
                            "partners Profession".trim().tr().capitalizeWords,
                          ),
                          MySpacing.height(8),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your partners profession";
                              }
                              return null;
                            },
                            controller: professionPartnerController,
                            decoration: InputDecoration(
                                hintText: "Enter your partners profession",
                                hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: focusedInputBorder,
                                contentPadding: MySpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never),
                          ),
                        ],
                      ),
                    ),
                    MySpacing.width(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium(
                            "partners education".trim().tr().capitalizeWords,
                          ),
                          MySpacing.height(8),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your partners education";
                              }
                              return null;
                            },
                            controller: educationPartnerController,
                            decoration: InputDecoration(
                                hintText: "Enter your partners education",
                                hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: focusedInputBorder,
                                contentPadding: MySpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  MySpacing.height(16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MyButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await controller.savePartnerPreferences(
                              agePartnerController.text,
                              locationPartnerController.text,
                              professionPartnerController.text,
                              educationPartnerController.text);
                          Get.snackbar(
                            "Success",
                            "Profile Created Successfully",
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                          Get.offNamed("/");
                        }
                      },
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: contentTheme.primary,
                      borderRadiusAll: AppStyle.buttonRadius.medium,
                      child: MyText.bodySmall(
                        'Submit'.tr().capitalizeWords,
                        color: contentTheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
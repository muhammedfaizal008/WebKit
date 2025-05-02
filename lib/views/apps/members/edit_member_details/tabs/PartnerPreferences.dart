import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:webkit/controller/apps/members/edit_members_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

class PartnerPreferences extends StatefulWidget {
  const PartnerPreferences({
    super.key,
    required this.uid,
    required this.ageController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.locationController,
    required this.professionController,
    required this.educationController,
    required this.formKey,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final String uid;
  final TextEditingController ageController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController locationController;
  final TextEditingController professionController;
  final TextEditingController educationController;
  final GlobalKey<FormState> formKey;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  State<PartnerPreferences> createState() => _PartnerPreferencesState();
}

class _PartnerPreferencesState extends State<PartnerPreferences> {
  late EditMembersController controller;
  @override
  void initState() {
    controller=Get.put<EditMembersController>(EditMembersController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "Partner age".tr().capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return 'Please enter your Partner age';
                      }
                      return null;
                    },
                    controller: widget.ageController,
                    decoration: InputDecoration(
                        hintText: "Partner age",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder:
                            widget.outlineInputBorder,
                        focusedBorder:
                            widget.focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                            fontSize: 10)),
                  ),
                ],
              ),
            ),
            MySpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "partners location".tr().capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return 'Please enter your partners location ';
                      }
                      return null;
                    },
                    controller: widget.locationController,
                    decoration: InputDecoration(
                        hintText: "Partners location",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder:
                            widget.outlineInputBorder,
                        focusedBorder:
                            widget.focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                            fontSize: 10)),
                  ),
                ],
              ),
            ),
          ],
        ),
        MySpacing.height(16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "Partners Profession"
                        .tr()
                        .capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return 'Please enter your Partners Profession';
                      }
                      return null;
                    },
                    controller:
                        widget.professionController,
                    decoration: InputDecoration(
                        hintText: "Partners Profession",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder:
                            widget.outlineInputBorder,
                        focusedBorder:
                            widget.focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                            fontSize: 10)),
                  ),
                ],
              ),
            ),
            MySpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "Partners Education"
                        .tr()
                        .capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return 'Please enter your Partners Education';
                      }
                      return null;
                    },
                    controller: widget.educationController,
                    decoration: InputDecoration(
                        hintText: "Partners Education",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder:
                            widget.outlineInputBorder,
                        focusedBorder:
                            widget.focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                            fontSize: 10)),
                  ),
                ],
              ),
            ),
          ],
        ),
        MySpacing.height(18),
        Align(
          alignment: Alignment.centerRight,
          child: MyButton(
            onPressed: () async {
              if (widget.formKey.currentState!.validate()) {
                await controller.savePartnerPrefereneces(
                  uid: widget.uid,
                  partnerAge: widget.ageController.text,
                  partnerEducation: widget.educationController.text,
                  partnerLocation: widget.locationController.text,
                  partnerProfession: widget.professionController.text,
                );
                
                Get.offNamedUntil("/user/free_members", (route) => false,);
                Get.snackbar(
                  'Success',
                  'User Deatils updated',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              }
            },
            elevation: 0,
            padding: MySpacing.xy(20, 16),
            backgroundColor: widget.contentTheme.primary,
            borderRadiusAll:
                AppStyle.buttonRadius.medium,
            child: MyText.bodySmall(
              'Submit'.tr().capitalizeWords,
              color: widget.contentTheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

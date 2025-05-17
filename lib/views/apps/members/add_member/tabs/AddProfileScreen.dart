import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_member_controller.dart';
import 'package:webkit/helpers/extensions/extensions.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';

class AddProfileScreen extends StatelessWidget {
  const AddProfileScreen({
    super.key,
    required this.context,
    required this.controller,
    required this.dobController,
    required this.ageController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.heightController,
    required this.professionController,
    required this.educationController,
    required this.locationController,
    required this.casteController,
    required this.aboutMeController,
    required this.religionController,
    required this.weightController,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final BuildContext context;
  final AddMemberController controller;
  final TextEditingController dobController;
  final TextEditingController ageController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController heightController;
  final TextEditingController professionController;
  final TextEditingController educationController;
  final TextEditingController locationController;
  final TextEditingController casteController;
  final TextEditingController aboutMeController;
  final TextEditingController religionController;
  final TextEditingController weightController;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    // Define a smaller error text style
    final errorTextStyle = MyTextStyle.bodySmall(fontSize: 10, xMuted: true);

    return SingleChildScrollView(
      child: MyFlexItem(
        sizes: "lg-7",
        child: MyContainer.bordered(
          paddingAll: 0,
          child: Form(
            key: formKey,
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
                          "profile_details".tr().capitalizeWords,
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
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "Date of Birth".tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                  GestureDetector(
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2000),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );

                                      if (pickedDate != null) {
                                        final age = controller.calculateAge(pickedDate);

                                        if (age >= 18 && age <= 120) {
                                          // Set formatted DOB and computed age
                                          dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                          ageController.text = age.toString(); // If age needed separately
                                        } else {
                                          Get.snackbar("Invalid Age", "Age must be between 18 and 120 years");
                                          dobController.clear();
                                          ageController.clear();
                                        }
                                      }
                                    },
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: dobController,
                                        decoration: InputDecoration(
                                          hintText: "Select Date of Birth",
                                          hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                          border: outlineInputBorder,
                                          enabledBorder: outlineInputBorder,
                                          focusedBorder: focusedInputBorder,
                                          contentPadding: MySpacing.all(12),
                                          isCollapsed: true,
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          errorStyle: errorTextStyle,
                                          errorMaxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),

                              ],
                            ),
                          ),
                          MySpacing.width(8), // Reduced spacing
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "height".tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                TextFormField(
                                  controller: heightController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your height";
                                    }
                                    final height = double.tryParse(value);
                                    if (height == null ||
                                        height < 100 ||
                                        height > 300) {
                                      return "Enter a valid height (100-300 cm)";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter your height",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding:
                                        MySpacing.all(12), // Reduced padding
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    errorStyle: errorTextStyle,
                                    errorMaxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(16), // Reduced from 20
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "Profession".trim().tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return controller.professionCategoryList.map((category) {
                                      return PopupMenuItem<String>(
                                        value: category.name,
                                        height: 32,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: MyText.bodySmall(
                                            category.name,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 0),
                                  onSelected: controller.onProfessionSelectedSize,
                                  color: theme.cardTheme.color,
                                  child: MyContainer.bordered(
                                    paddingAll: 8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.labelMedium(
                                          controller.professionStatus.isEmpty
                                              ? "Select profession Status"
                                              : controller.professionStatus,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          LucideIcons.chevronDown,
                                          size: 22,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MySpacing.width(8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "Profession in Detail".trim().tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                TextFormField(
                                  controller: professionController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your Profession in Detail";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter your Profession in Detail",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(12),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    errorStyle: errorTextStyle,
                                    errorMaxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(16), // Reduced from 20
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                MyText.labelMedium(
                                  "Education Category".trim().tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return controller.educationCategoryList.map((category) {
                                      return PopupMenuItem<String>(
                                        value: category.name,
                                        height: 32,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: MyText.bodySmall(
                                            category.name,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 0),
                                  onSelected: controller.onEducationSelectedSize,
                                  color: theme.cardTheme.color,
                                  child: MyContainer.bordered(
                                    paddingAll: 8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.labelMedium(
                                          controller.educationStatus.isEmpty
                                              ? "Select Education Status"
                                              : controller.educationStatus,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          LucideIcons.chevronDown,
                                          size: 22,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          MySpacing.width(8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "education in detail".trim().tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                TextFormField(
                                  controller: educationController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your education";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter your Education",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(12),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    errorStyle: errorTextStyle,
                                    errorMaxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(12), // Reduced from 16
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                    "Marital Status".tr().capitalizeWords),
                                MySpacing.height(8),
                                PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return controller.maritalStatusList.map((behavior) {
                                      return PopupMenuItem<String>(
                                        value: behavior.status,
                                        height: 32,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: MyText.bodySmall(
                                            behavior.status,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 0),
                                  onSelected: controller.onSelectedmaritalStatus,
                                  color: theme.cardTheme.color,
                                  child: MyContainer.bordered(
                                    paddingAll: 8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.labelMedium(
                                          controller.maritalStatus.isEmpty ? "Select Marital status" : controller.maritalStatus,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          LucideIcons.chevronDown,
                                          size: 22,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MySpacing.width(8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "Location".trim().tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                TextFormField(
                                  controller: locationController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your location";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter your Location",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(12),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    errorStyle: errorTextStyle,
                                    errorMaxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      MySpacing.height(8),
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "Weight".trim().tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                TextFormField(
                                  controller: weightController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your Weight";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter your Weight",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(12),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    errorStyle: errorTextStyle,
                                    errorMaxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MySpacing.width(8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                MyText.labelMedium(
                                  "Physical Status".trim().tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                PopupMenuButton<String>(
                                  
                                  itemBuilder: (BuildContext context) {
                                    return controller.physicalStatusList.map((physicalstatus) {
                                      return PopupMenuItem<String>(
                                        value: physicalstatus.status,
                                        height: 32,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: MyText.bodySmall(
                                            physicalstatus.status,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 0),
                                  onSelected: controller.onPhysicalStatusSelectedSize,
                                  color: theme.cardTheme.color,
                                  child: MyContainer.bordered(
                                    paddingAll: 8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.labelMedium(
                                            controller.physicalstatus.isEmpty ? "Select Physical status" : controller.physicalstatus,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          LucideIcons.chevronDown,    
                                          size: 22,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(16),
                      MyText.labelMedium(
                        "About me".trim().tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      TextFormField(
                        controller: aboutMeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter something about yourself";
                          }
                          if (value.length < 10) {
                            return "About me should be at least 10 characters long";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "About Me ...",
                          hintStyle: MyTextStyle.bodySmall(xMuted: true),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: focusedInputBorder,
                          contentPadding: MySpacing.all(12),
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorStyle: errorTextStyle,
                          errorMaxLines: 1,
                        ),
                      ),
                      MySpacing.height(16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MyButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await controller.saveProfile(
                                dobController.text,
                                ageController.text,
                                locationController.text,
                                professionController.text,
                                educationController.text,
                                heightController.text,
                                aboutMeController.text,
                                religionController.text,
                                casteController.text,
                                weightController.text 
                              );
                              defaultTabController.animateTo(3);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
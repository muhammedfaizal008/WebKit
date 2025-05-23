import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_member_controller.dart';
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

class AddFamilyLifestyleInfo extends StatelessWidget {
  const AddFamilyLifestyleInfo({
    super.key,
    required this.controller,
    required this.noOfBrothersController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.noOfSistersController,
    required this.fathersOccupationController,
    required this.mothersOccupationController,
    required this.formKey,
    required this.contentTheme,
    required this.defaultTabController,
  });

  final AddMemberController controller;
  final TextEditingController noOfBrothersController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController noOfSistersController;
  final TextEditingController fathersOccupationController;
  final TextEditingController mothersOccupationController;
  final GlobalKey<FormState> formKey;
  final ContentTheme contentTheme;
  final TabController defaultTabController;

  @override
  Widget build(BuildContext context) {
    return MyFlexItem(
      sizes: "lg-7",
      child: MyContainer.bordered(
        paddingAll: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                          "Family Details".tr().capitalizeWords,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: MySpacing.nTop(flexSpacing),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                                "family values".tr().capitalizeWords),
                            MySpacing.height(8),
                            PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return controller.familyValuesList.map((familyValue) {
                                  return PopupMenuItem<String>(
                                    value: familyValue.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: MyText.bodySmall(
                                        familyValue.name,
                                        color: theme.colorScheme.onSurface, 
                                        fontWeight: 600,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: controller.onFamilyValuesSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectedFamilyValue.isEmpty
                                          ? (controller.familyValuesError == true
                                              ? "Please select family value "
                                              : "Select family value")
                                          : controller.selectedFamilyValue,
                                      color: controller.selectedFamilyValue.isNotEmpty
                                          ? Colors.black
                                          : (controller.familyValuesError == true
                                              ? Colors.red
                                              : theme.colorScheme.onSurface),
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
                      MySpacing.width(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                                "family status".tr().capitalizeWords),
                            MySpacing.height(8),
                            PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return controller.familyStatus.map((familyStatus) {
                                  return PopupMenuItem<String>(
                                    value: familyStatus.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: MyText.bodySmall(
                                        familyStatus.name,
                                        color: theme.colorScheme.onSurface, 
                                        fontWeight: 600,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: controller.onFamilyStatusSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectedFamilyStatus.isEmpty
                                          ? (controller.familyStatusError == true
                                              ? "Please Family Status"
                                              : "Select Family Status")
                                          : controller.selectedFamilyStatus,
                                      color: controller.selectedFamilyStatus.isNotEmpty
                                          ? Colors.black
                                          : (controller.familyStatusError == true
                                              ? Colors.red
                                              : theme.colorScheme.onSurface),
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
                      MySpacing.width(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                                "family type".tr().capitalizeWords),
                            MySpacing.height(8),
                            PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return controller.familyTypeList.map((familyType) {
                                  return PopupMenuItem<String>(
                                    value: familyType.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: MyText.bodySmall(
                                        familyType.name,
                                        color: theme.colorScheme.onSurface, 
                                        fontWeight: 600,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: controller.onFamilyTypeSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectedFamilyType.isEmpty
                                          ? (controller.familyTypeError == true
                                              ? "Please select family type"
                                              : "Select family type")
                                          : controller.selectedFamilyType,
                                      color: controller.selectedFamilyType.isNotEmpty
                                          ? Colors.black
                                          : (controller.familyTypeError == true
                                              ? Colors.red
                                              : theme.colorScheme.onSurface),
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
                   
                ),
                Padding(
                  padding: MySpacing.nTop(flexSpacing),
                    child: Row(
                    children: [
                      Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium("number of brothers".tr().capitalizeWords),
                          MySpacing.height(8),
                          TextFormField(
                            controller: noOfBrothersController,
                            validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter number of brothers';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                            hintText: "No. of Brothers",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      ),
                      MySpacing.width(16),
                      Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium(
                                "number of sisters".tr().capitalizeWords),
                          MySpacing.height(8),
                          TextFormField(
                            controller: noOfSistersController,
                            validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter number of sisters';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                            hintText: "No. of Sisters",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      ),
                    ],
                    ),
                ),
                Padding(
                  padding: MySpacing.nTop(flexSpacing),
                  child: Row(
                  children: [
                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      MyText.labelMedium(
                        "Father's Occupation".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        controller: fathersOccupationController, 
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter father\'s occupation';
                        }
                        return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                        hintText: "Father's Occupation",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorStyle: TextStyle(fontSize: 10),
                        ),
                      ),
                      ],
                    ),
                    ),
                    MySpacing.width(16),
                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      MyText.labelMedium(
                        "Mother's Occupation".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        controller: mothersOccupationController, 
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mother\'s occupation';
                        }
                        return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                        hintText: "Mother's Occupation",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorStyle: TextStyle(fontSize: 10),
                        ),
                      ),
                      ],
                    ),
                    ),
                  ],
                  ),
                ),
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
                          "lifestyle Details".tr().capitalizeWords,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                  ),
                ),
                // Eating Habits
                Padding(
                  padding: MySpacing.nTop(flexSpacing),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium("Eating Habit".tr().capitalizeWords),
                            MySpacing.height(8),
                            PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return controller.eatingHabitsList.map((habit) {
                                  return PopupMenuItem<String>(
                                    value: habit.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: MyText.bodySmall(
                                        habit.name,
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: 600,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: controller.onEatingHabitsSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectedEatingHabits.isEmpty
                                          ? "Select Eating Habit"
                                          : controller.selectedEatingHabits,
                                      color: controller.selectedEatingHabits.isNotEmpty
                                          ? Colors.black
                                          : theme.colorScheme.onSurface,
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
                      MySpacing.width(16),
                      // Drinking Habits
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium("Drinking Habit".tr().capitalizeWords),
                            MySpacing.height(8),
                            PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return controller.drinkingHabitsList.map((habit) {
                                  return PopupMenuItem<String>(
                                    value: habit.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: MyText.bodySmall(
                                        habit.name,
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: 600,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: controller.onDrinkingHabitsSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectedDrinkingHabits.isEmpty
                                          ? "Select Drinking Habit"
                                          : controller.selectedDrinkingHabits,
                                      color: controller.selectedDrinkingHabits.isNotEmpty
                                          ? Colors.black
                                          : theme.colorScheme.onSurface,
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
                      MySpacing.width(16),
                      // Smoking Habits
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium("Smoking Habit".tr().capitalizeWords),
                            MySpacing.height(8),
                            PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return controller.smokingHabitsList.map((habit) {
                                  return PopupMenuItem<String>(
                                    value: habit.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: MyText.bodySmall(
                                        habit.name,
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: 600,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: controller.onSmokingHabitsSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectedSmokingHabits.isEmpty
                                          ? "Select Smoking Habit"
                                          : controller.selectedSmokingHabits,
                                      color: controller.selectedSmokingHabits.isNotEmpty
                                          ? Colors.black
                                          : theme.colorScheme.onSurface,
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
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.saveFamilyLifestyleInfo(fathersOccupationController.text, mothersOccupationController.text, noOfBrothersController.text, noOfSistersController.text);
                          }
                        },
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: contentTheme.primary,
                        borderRadiusAll: AppStyle.buttonRadius.medium,
                        child: MyText.bodySmall(
                          'Save'.tr().capitalizeWords,
                          color: contentTheme.onPrimary,
                        ),
                      ),
                      MySpacing.width(16),
                      MyButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.saveFamilyLifestyleInfo(fathersOccupationController.text, mothersOccupationController.text, noOfBrothersController.text, noOfSistersController.text);
                          }
                          defaultTabController.animateTo(5);
                        },
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: contentTheme.primary,
                        borderRadiusAll: AppStyle.buttonRadius.medium,
                        child: MyText.bodySmall(
                          'Save & Next'.tr().capitalizeWords,
                          color: contentTheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

class AddFamilyLifestyleInfo extends StatefulWidget {
  const AddFamilyLifestyleInfo({
    super.key,
    required this.controller,
    required this.agePartnerController,
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
  final TextEditingController agePartnerController;
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
  State<AddFamilyLifestyleInfo> createState() => _AddFamilyLifestyleInfoState();
}

class _AddFamilyLifestyleInfoState extends State<AddFamilyLifestyleInfo> {
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
                                return widget.controller.familyValuesList.map((familyValue) {
                                  return PopupMenuItem<String>(
                                    value: familyValue.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: MyText.bodySmall(
                                        familyValue.name,
                                        color: theme.colorScheme.onSurface, 
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: widget.controller.onFamilyValuesSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 10,
                                border: Border.all(
                                  color: widget.controller.familyValuesError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.bodySmall(
                                      widget.controller.selectedFamilyValue.isEmpty
                                          ? (widget.controller.familyValuesError == true
                                              ? "Please select family value "
                                              : "Select family value")
                                          : widget.controller.selectedFamilyValue,
                                      color: widget.controller.selectedFamilyValue.isNotEmpty
                                          ? Colors.black
                                          : (widget.controller.familyValuesError == true
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
                            if (widget.controller.familyValuesError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  widget.controller.familyValuesError!,
                                  style: TextStyle(color: Colors.red, fontSize: 12),
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
                                return widget.controller.familyStatus.map((familyStatus) {
                                  return PopupMenuItem<String>(
                                    value: familyStatus.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: MyText.bodySmall(
                                        familyStatus.name,
                                        color: theme.colorScheme.onSurface, 
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: widget.controller.onFamilyStatusSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 10,
                                  border: Border.all(
                                    color: widget.controller.familyStatusError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                  ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.bodySmall(
                                      widget.controller.selectedFamilyStatus.isEmpty
                                          ? (widget.controller.familyStatusError == true
                                              ? "Please Family Status"
                                              : "Select Family Status")
                                          : widget.controller.selectedFamilyStatus,
                                      color: widget.controller.selectedFamilyStatus.isNotEmpty
                                          ? Colors.black
                                          : (widget.controller.familyStatusError == true
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
                            if (widget.controller.familyStatusError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  widget.controller.familyStatusError!,
                                  style: TextStyle(color: Colors.red, fontSize: 12),
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
                                return widget.controller.familyTypeList.map((familyType) {
                                  return PopupMenuItem<String>(
                                    value: familyType.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: MyText.bodySmall(
                                        familyType.name,
                                        color: theme.colorScheme.onSurface, 
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: widget.controller.onFamilyTypeSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 10,
                                  border: Border.all(
                                    color: widget.controller.familyTypeError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                  ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.bodySmall(
                                      widget.controller.selectedFamilyType.isEmpty
                                          ? (widget.controller.familyTypeError == true
                                              ? "Please select family type"
                                              : "Select family type")
                                          : widget.controller.selectedFamilyType,
                                      color: widget.controller.selectedFamilyType.isNotEmpty
                                          ? Colors.black
                                          : (widget.controller.familyTypeError == true
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
                              if (widget.controller.familyTypeError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      widget.controller.familyTypeError!,
                                      style: TextStyle(color: Colors.red, fontSize: 12),
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
                            controller: widget.noOfBrothersController,
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
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
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
                            controller: widget.noOfSistersController,
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
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
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
                        controller: widget.fathersOccupationController, 
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
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: widget.focusedInputBorder,
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
                        controller: widget.mothersOccupationController, 
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
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: widget.focusedInputBorder,
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
                                return widget.controller.eatingHabitsList.map((habit) {
                                  return PopupMenuItem<String>(
                                    value: habit.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: MyText.bodySmall(
                                        habit.name,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: widget.controller.onEatingHabitsSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 10,
                                  border: Border.all(
                                    color: widget.controller.eatingHabitsError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                  ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.bodySmall(
                                      widget.controller.selectedEatingHabits.isEmpty
                                          ? "Select Eating Habit"
                                          : widget.controller.selectedEatingHabits,
                                      color: widget.controller.selectedEatingHabits.isNotEmpty
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
                            if (widget.controller.eatingHabitsError != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    widget.controller.eatingHabitsError!,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
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
                                return widget.controller.drinkingHabitsList.map((habit) {
                                  return PopupMenuItem<String>(
                                    value: habit.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: MyText.bodySmall(
                                        habit.name,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: widget.controller.onDrinkingHabitsSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 10,
                                  border: Border.all(
                                    color: widget.controller.drinkingHabitsError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                  ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.bodySmall(
                                      widget.controller.selectedDrinkingHabits.isEmpty
                                          ? "Select Drinking Habit"
                                          : widget.controller.selectedDrinkingHabits,
                                      color: widget.controller.selectedDrinkingHabits.isNotEmpty
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
                            if (widget.controller.drinkingHabitsError != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    widget.controller.drinkingHabitsError!,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
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
                                return widget.controller.smokingHabitsList.map((habit) {
                                  return PopupMenuItem<String>(
                                    value: habit.name,
                                    height: 32,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: MyText.bodySmall(
                                        habit.name,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: widget.controller.onSmokingHabitsSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 10,
                                  border: Border.all(
                                    color: widget.controller.smokingHabitsError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                  ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.bodySmall(
                                      widget.controller.selectedSmokingHabits.isEmpty
                                          ? "Select Smoking Habit"
                                          : widget.controller.selectedSmokingHabits,
                                      color: widget.controller.selectedSmokingHabits.isNotEmpty
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
                            if (widget.controller.smokingHabitsError != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    widget.controller.smokingHabitsError!,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
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
                          final isFormValid = widget.formKey.currentState!.validate();
                            final isDropdownValid = widget.controller.validateLifestyleInfo();
                          if (isFormValid && isDropdownValid) {
                            widget.controller.saveFamilyLifestyleInfo(widget.agePartnerController.text, widget.fathersOccupationController.text, widget.mothersOccupationController.text, widget.noOfBrothersController.text, widget.noOfSistersController.text);
                          }
                        },
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: widget.contentTheme.primary,
                        borderRadiusAll: AppStyle.buttonRadius.medium,
                        child: MyText.bodySmall(
                          'Save'.tr().capitalizeWords,
                          color: widget.contentTheme.onPrimary,
                        ),
                      ),
                      MySpacing.width(16),
                      MyButton(
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            widget.controller.saveFamilyLifestyleInfo(widget.agePartnerController.text,widget.fathersOccupationController.text, widget.mothersOccupationController.text, widget.noOfBrothersController.text, widget.noOfSistersController.text);
                          }
                          widget.defaultTabController.animateTo(5);
                        },
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: widget.contentTheme.primary,
                        borderRadiusAll: AppStyle.buttonRadius.medium,
                        child: MyText.bodySmall(
                          'Save & Next'.tr().capitalizeWords,
                          color: widget.contentTheme.onPrimary,
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

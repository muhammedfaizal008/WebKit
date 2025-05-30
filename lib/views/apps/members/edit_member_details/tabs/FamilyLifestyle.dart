import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/edit_members_controller/edit_members_controller.dart';
import 'package:webkit/helpers/extensions/extensions.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

class FamilyLifestyle extends StatefulWidget {
  const FamilyLifestyle({
    super.key,
    required this.uid,
    required this.formkey,
    required this.contentTheme,
    required this.defaultTabController,
    required this.familyValuesController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.familyStatusController,
    required this.familyTypeController,
    required this.eatingHabitController,
    required this.drinkingHabitController,
    required this.smokingHabitController,
    required this.noOfBrothersController,
    required this.noOfSistersController,
    required this.fathersOccupationController,
    required this.mothersOccupationController,
  });
  final String uid;
  final GlobalKey formkey;
  final ContentTheme contentTheme;
  final TabController defaultTabController;
  final TextEditingController familyValuesController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController familyStatusController;
  final TextEditingController familyTypeController;
  final TextEditingController eatingHabitController;
  final TextEditingController drinkingHabitController;
  final TextEditingController smokingHabitController;
  final TextEditingController noOfBrothersController;
  final TextEditingController noOfSistersController;
  final TextEditingController fathersOccupationController;
  final TextEditingController mothersOccupationController;

  @override
  State<FamilyLifestyle> createState() => _FamilyLifestyleState();
}

class _FamilyLifestyleState extends State<FamilyLifestyle> {
  late EditMembersController controller;
  final OutlineInputBorder focusedInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(
      color: Colors.blue,
      width: 1.5,
    ),
  );
  @override
  void initState() {
    controller = Get.put<EditMembersController>(EditMembersController());
    super.initState();
  }
  Future<void> _showSelectionMenu({
    required GlobalKey key,
    required List<String> items,
    required Function(String) onSelected,
    required TextEditingController controller,
  }) async {
    if (this.controller.isLoading.value) return;
    
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + renderBox.size.height,
      offset.dx + renderBox.size.width,
      offset.dy,
    );

      final selectedItem = await showMenu<String>(
  context: context,
  position: position,
  items: items.map((item) => PopupMenuItem<String>(
    value: item,
    child: Text(item),
  )).toList(), 
);

    
    if (selectedItem != null) {
      onSelected(selectedItem);
      controller.text = selectedItem;
    }
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey _familyValuesKey= GlobalKey();
    final GlobalKey _familytypeKey= GlobalKey();
    final GlobalKey _familyStatusKey= GlobalKey();
    final GlobalKey _eatinghabitKey= GlobalKey();
    final GlobalKey _drinkinghabitKey= GlobalKey();
    final GlobalKey _smokinghabitKey= GlobalKey(); 
    return MyContainer.bordered(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    LucideIcons.edit,
                    size: 16,
                  ),
                  MySpacing.width(12),
                  MyText.titleMedium(
                    "Family & Lifestyle".tr().capitalizeWords,
                    fontWeight: 600,
                  ),
                ],
              ),
              MySpacing.height(15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Family Values".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _familyValuesKey,
                            readOnly: true,
                            controller: widget.familyValuesController,
                            onTap: () => _showSelectionMenu(
                              key: _familyValuesKey,
                              items: controller.familyValues,
                              onSelected: controller.setSelectedFamilyValue,
                              controller: widget.familyValuesController,  
                            ),
                            decoration: InputDecoration(
                              hintText: "Select family values",
                              hintStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: widget.outlineInputBorder,
                              enabledBorder: widget.outlineInputBorder,
                              focusedBorder: widget.focusedInputBorder,
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              errorStyle: TextStyle(fontSize: 10),
                            ),
                          );
                        },
                  )
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Family Status".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _familyStatusKey,
                                readOnly: true,
                                controller: widget.familyStatusController,
                                onTap: () => _showSelectionMenu(
                                  key: _familyStatusKey,
                                  items: controller.familyStatuses,
                                  onSelected: controller.setSelectedFamilyStatus,
                                  controller: widget.familyStatusController,  
                                ),
                                decoration: InputDecoration(
                                  hintText: "Select family status",
                                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                  border: widget.outlineInputBorder,
                                  enabledBorder: widget.outlineInputBorder,
                                  focusedBorder: widget.focusedInputBorder,
                                  contentPadding: MySpacing.all(16),
                                  isCollapsed: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  errorStyle: TextStyle(fontSize: 10),
                                ),
                              );
                            },
                      )
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Family Type".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _familytypeKey,
                                readOnly: true,
                                controller: widget.familyTypeController,
                                onTap: () => _showSelectionMenu(
                                  key: _familytypeKey,
                                  items: controller.familyTypes,
                                  onSelected: controller.setSelectedFamilyType,
                                  controller: widget.familyTypeController,  
                                ),
                                decoration: InputDecoration(
                                  hintText: "Select family type",
                                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                  border: widget.outlineInputBorder,
                                  enabledBorder: widget.outlineInputBorder,
                                  focusedBorder: widget.focusedInputBorder,
                                  contentPadding: MySpacing.all(16),
                                  isCollapsed: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  errorStyle: TextStyle(fontSize: 10),
                                ),
                              );
                            },
                      )
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Eating Habit".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _eatinghabitKey,
                                readOnly: true,
                                controller: widget.eatingHabitController,
                                onTap: () => _showSelectionMenu(
                                  key: _eatinghabitKey,
                                  items: controller.eatingHabits,
                                  onSelected: controller.setSelectedEatingHabit,
                                  controller: widget.eatingHabitController,  
                                ),
                                decoration: InputDecoration(
                                  hintText: "Select eating habit",
                                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                  border: widget.outlineInputBorder,
                                  enabledBorder: widget.outlineInputBorder,
                                  focusedBorder: widget.focusedInputBorder,
                                  contentPadding: MySpacing.all(16),
                                  isCollapsed: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  errorStyle: TextStyle(fontSize: 10),
                                ),
                              );
                            },
                      )
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Drinking Habit".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _drinkinghabitKey,
                                readOnly: true,
                                controller: widget.drinkingHabitController,
                                onTap: () => _showSelectionMenu(
                                  key: _drinkinghabitKey,
                                  items: controller.drinkingHabits,
                                  onSelected: controller.setSelectedDrinkingHabit,
                                  controller: widget.drinkingHabitController,  
                                ),
                                decoration: InputDecoration(
                                  hintText: "Select drinking habit",
                                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                  border: widget.outlineInputBorder,
                                  enabledBorder: widget.outlineInputBorder,
                                  focusedBorder: widget.focusedInputBorder,
                                  contentPadding: MySpacing.all(16),
                                  isCollapsed: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  errorStyle: TextStyle(fontSize: 10),
                                ),
                              );
                            },
                      )
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Smoking Habit".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _smokinghabitKey,
                                readOnly: true,
                                controller: widget.smokingHabitController,
                                onTap: () => _showSelectionMenu(
                                  key: _smokinghabitKey,
                                  items: controller.smokingHabits,
                                  onSelected: controller.setSelectedSmokingHabit,
                                  controller: widget.smokingHabitController,  
                                ),
                                decoration: InputDecoration(
                                  hintText: "Select smoking habit",
                                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                  border: widget.outlineInputBorder,
                                  enabledBorder: widget.outlineInputBorder,
                                  focusedBorder: widget.focusedInputBorder,
                                  contentPadding: MySpacing.all(16),
                                  isCollapsed: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  errorStyle: TextStyle(fontSize: 10),
                                ),
                              );
                            },
                      )
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("No. of Brothers".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          controller: widget.noOfBrothersController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter number of brothers';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "e.g., 2",
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
                        MyText.labelMedium("No. of Sisters".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          controller: widget.noOfSistersController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter number of sisters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "e.g., 1",
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
              MySpacing.height(16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Father's Occupation".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          controller: widget.fathersOccupationController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter father's occupation";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Engineer / Businessman",
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
                        MyText.labelMedium("Mother's Occupation".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          controller: widget.mothersOccupationController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter mother's occupation";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Homemaker / Teacher",
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
              MySpacing.height(10),
            Align(  
              alignment: Alignment.centerRight,
              child: MyButton(
                onPressed: () async { 
                  controller.saveFamilyLifestyleInfo(uid: widget.uid,
                    drinkingHabit:widget.drinkingHabitController.text,brothers:widget.noOfBrothersController.text,eatingHabit: widget.eatingHabitController.text,familyStatus: widget.familyStatusController.text,
                    familyType: widget.familyTypeController.text,familyValues: widget.familyValuesController.text,fathersOccupation: widget.fathersOccupationController.text,mothersOcccupation: widget.mothersOccupationController.text,
                    sisters: widget.noOfSistersController.text,smokingHabit: widget.smokingHabitController.text, 
                  );
                    
                    widget.defaultTabController.animateTo(4);
                },
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor:widget.contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: MyText.bodySmall(
                  'Submit'.tr().capitalizeWords,
                  color: widget.contentTheme.onPrimary,
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}


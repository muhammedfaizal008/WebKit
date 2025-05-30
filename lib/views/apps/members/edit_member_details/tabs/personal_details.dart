import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/edit_members_controller/edit_members_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

class PersonalDetails extends StatefulWidget {
  PersonalDetails({
    super.key,
    required this.uid,
    required this.theme,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.aboutMeController,
    required this.dobController,
    required this.professionController,
    required this.professionInDetailController,
    required this.educationController,
    required this.educationInDetailController,
    required this.maritalStatusController,
    required this.physicalStatusController, 
    required this.citizenshipController,
    required this.formKey,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final ThemeData theme;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder; 
  final String uid;
  final TextEditingController aboutMeController;
  final TextEditingController dobController;
  final TextEditingController professionInDetailController;
  final TextEditingController educationInDetailController;
  final TextEditingController maritalStatusController;
  final TextEditingController physicalStatusController;
  final TextEditingController professionController;
  final TextEditingController educationController;
  final TextEditingController citizenshipController;
  final GlobalKey<FormState> formKey;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
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
    final GlobalKey _citizenshipKey=GlobalKey();
    final GlobalKey _professionKey =GlobalKey();
    final GlobalKey _educationKey =GlobalKey();
    final GlobalKey _maritalStatusKey =GlobalKey();
    final GlobalKey _physicalStatusKey =GlobalKey();
    return MyContainer.bordered(
      child: SingleChildScrollView(
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
                  "Personal Details".tr().capitalizeWords,
                  fontWeight: 600,
                ),
              ],
            ),
            MySpacing.height(15),
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
                                  widget.dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
                                
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select your date of birth';
                                  }
                                  return null; 
                                },
                                style: MyTextStyle.bodySmall(),
                                controller: widget.dobController,
                                decoration: InputDecoration(
                                  hintText: "Select Date of Birth",
                                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                  border: widget.outlineInputBorder,
                                  enabledBorder: widget.outlineInputBorder,
                                  focusedBorder: widget.focusedInputBorder,
                                  contentPadding: MySpacing.all(12),
                                  isCollapsed: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  errorStyle: TextStyle(fontSize: 12),
                                  errorMaxLines: 1,
                                ),
                              ),
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
                          "citizenship".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _citizenshipKey,
                                readOnly: true,
                                controller: widget.citizenshipController,
                                onTap: () => _showSelectionMenu(
                                  key: _citizenshipKey,
                                  items: controller.citizenship,
                                  onSelected: controller.setselectcitizen,
                                  controller: widget.citizenshipController,
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select citizenship",
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
              MySpacing.height(10),
            Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium(
                          "profession category".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _professionKey,
                                readOnly: true,
                                controller: widget.professionController,
                                onTap: () => _showSelectionMenu(
                                  key: _professionKey,
                                  items: controller.professions,
                                  onSelected: controller.setselectprofession,
                                  controller: widget.professionController,
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select profession",
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
                        MyText.labelMedium(
                          "profession In Detail".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter profession in detail';
                            }
                            return null;
                          },
                          style: MyTextStyle.bodySmall(),
                          controller: widget.professionInDetailController,
                          decoration: InputDecoration(
                              hintText: "profession in detail",
                              hintStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: widget.outlineInputBorder,
                              enabledBorder: widget.outlineInputBorder,
                              focusedBorder: widget.focusedInputBorder,
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              errorStyle: TextStyle(fontSize: 10)),
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
                        MyText.labelMedium(
                          "education category".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _educationKey,
                                readOnly: true,
                                controller: widget.educationController,
                                onTap: () => _showSelectionMenu(
                                  key: _educationKey,
                                  items: controller.educations,
                                  onSelected: controller.setselectEducation,
                                  controller: widget.educationController,
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select education",
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
                        MyText.labelMedium(
                          "education In Detail".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter education in detail';
                            }
                            return null;
                          },
                          style: MyTextStyle.bodySmall(),
                          controller: widget.educationInDetailController,
                          decoration: InputDecoration(
                              hintText: "education In Detail",
                              hintStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: widget.outlineInputBorder,
                              enabledBorder: widget.outlineInputBorder,
                              focusedBorder: widget.focusedInputBorder,
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              errorStyle: TextStyle(fontSize: 10)),
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
                        MyText.labelMedium(
                          "marital Status".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _maritalStatusKey,
                                readOnly: true,
                                controller: widget.maritalStatusController,
                                onTap: () => _showSelectionMenu(
                                  key: _maritalStatusKey,
                                  items: controller.maritalStatuses,
                                  onSelected: controller.setselectMaritalstatus,
                                  controller: widget.maritalStatusController,
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select marital status",
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
                        MyText.labelMedium(
                          "physical Status".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _physicalStatusKey,
                                readOnly: true,
                                controller: widget.physicalStatusController,
                                onTap: () => _showSelectionMenu(
                                  key: _physicalStatusKey,
                                  items: controller.physicalStatuses,
                                  onSelected: controller.setselectPhysicalStatus,
                                  controller: widget.physicalStatusController,
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select physical status",
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
            Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium(
                        "About Me".tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your About Me';
                          }
                          return null;
                        },
                        maxLines: 3,
                        controller: widget.aboutMeController,
                        style: MyTextStyle.bodySmall(),
                        decoration: InputDecoration(
                            hintText: "About Me",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                  MySpacing.height(18),
            MySpacing.height(18),
            Align(
              alignment: Alignment.centerRight,
              child: MyButton(
                onPressed: () async {
                  if (widget.formKey.currentState!.validate()) {
                    await controller.savePersonalData(
                      uid: widget.uid,
                      aboutMe: widget.aboutMeController.text,citizenship: widget.citizenshipController.text,dob: widget.dobController.text,
                      educationCategory: widget.educationController.text,educationInDetail: widget.educationInDetailController.text,maritalStatus: widget.maritalStatusController.text,
                      physicalStatus: widget.physicalStatusController.text,professionCategory: widget.professionController.text,professionInDetail: widget.professionInDetailController.text
                    );
                    widget.defaultTabController.animateTo(2);
                  }
                },
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: widget.contentTheme.primary,
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
    );
  }
}

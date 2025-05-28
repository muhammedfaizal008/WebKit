import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/edit_members_controller.dart';
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
    controller.fetchLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select citizenship';
                        }
                        return null;
                      },
                      controller: widget.citizenshipController,
                      decoration: InputDecoration(
                          hintText: "citizenship",
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      controller: widget.professionController,
                      decoration: InputDecoration(
                          hintText: "profession",
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      controller: widget.educationController,
                      decoration: InputDecoration(
                          hintText: "education",
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a marital Status';
                        }
                        return null;
                      },
                      controller: widget.maritalStatusController,
                      decoration: InputDecoration(
                          hintText: "marital Status",
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
              MySpacing.width(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.labelMedium(
                      "physical Status".tr().capitalizeWords,
                    ),
                    MySpacing.height(8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select physical status';
                        }
                        return null;
                      },
                      controller: widget.physicalStatusController,
                      decoration: InputDecoration(
                          hintText: "Physical status",
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
        
        
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     MyText.labelMedium(
        //       "caste".tr().capitalizeWords,
        //     ),
        //     MySpacing.height(8),
        //     TextFormField(
        //       validator: (value) {
        //         if (value == null || value.isEmpty) {
        //           return 'Please enter your caste ';
        //         }
        //         return null;
        //       },
        //       controller: widget.casteController,
        //       decoration: InputDecoration(
        //           hintText: "caste",
        //           hintStyle: MyTextStyle.bodySmall(xMuted: true),
        //           border: widget.outlineInputBorder,
        //           enabledBorder: widget.outlineInputBorder,
        //           focusedBorder: focusedInputBorder,
        //           contentPadding: MySpacing.all(16),
        //           isCollapsed: true,
        //           floatingLabelBehavior: FloatingLabelBehavior.never,
        //           errorStyle: TextStyle(fontSize: 10)),
        //     ),
        //   ],
        // ),
        MySpacing.height(18),
        Align(
          alignment: Alignment.centerRight,
          child: MyButton(
            onPressed: () async {
              if (widget.formKey.currentState!.validate()) {
                await controller.savePersonalData(
                  uid: widget.uid,
                  religion: "",
                  caste: "",
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
    );
  }
}

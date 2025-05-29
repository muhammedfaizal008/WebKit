import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webkit/controller/apps/members/edit_members_controller/edit_members_controller.dart';
import 'package:webkit/helpers/extensions/extensions.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/widgets/my_container.dart';

import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

  class PartnerPreferences extends StatefulWidget {
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final String uid;
  final GlobalKey formkey;
  final TabController defaultTabController;

  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController citizenshipController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController professionController;
  final TextEditingController educationController;
  final TextEditingController motherTongueController;
  final TextEditingController casteController;
  final TextEditingController starController;
  final TextEditingController religionController;
  final TextEditingController maritalStatusController;
  final TextEditingController incomeController;
  final TextEditingController doshamController;
  final TextEditingController eatingHabitController;
  final TextEditingController smokingHabitController;
  final TextEditingController drinkingHabitController;


  const PartnerPreferences({
    super.key,
    required this.uid,
    required this.formkey,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.defaultTabController,
    required this.ageController,
    required this.heightController,
    required this.citizenshipController,
    required this.stateController,
    required this.countryController,
    required this.professionController,
    required this.educationController,
    required this.motherTongueController,
    required this.casteController,
    required this.starController,
    required this.religionController,
    required this.maritalStatusController,
    required this.incomeController,
    required this.doshamController,
    required this.eatingHabitController,
    required this.smokingHabitController,
    required this.drinkingHabitController,
  });

  @override
  State<PartnerPreferences> createState() => _PartnerPreferencesState();
}


  class _PartnerPreferencesState extends State<PartnerPreferences> {
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
    final GlobalKey _partnerCitizenshipKey=GlobalKey();
    final GlobalKey _partnerReligionKey=GlobalKey();
    final GlobalKey _partnerMaritalStatusKey =GlobalKey();
    final GlobalKey _partnerIncomeKey =GlobalKey();
    final GlobalKey _partnerDoshamKey =GlobalKey();
    return SingleChildScrollView(
      child: MyContainer.bordered(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              // Age and Height Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Age".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter partner age';
                            }
                            return null;
                          },
                          controller: widget.ageController,
                          decoration: InputDecoration(
                            hintText: "25-30",
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
                        MyText.labelMedium("Partner Height".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter partner height';
                            }
                            return null;
                          },
                          controller: widget.heightController,
                          decoration: InputDecoration(
                            hintText: "120-200",
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
          
              // Citizenship and State Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Citizenship".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _partnerCitizenshipKey,
                            readOnly: true,
                            controller: widget.citizenshipController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerCitizenshipKey,
                              items: controller.citizenship,
                              onSelected: controller.setSelectedPartnerCitizenShip,
                              controller: widget.citizenshipController,
                            ),
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
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner State".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select state';
                            }
                            return null;
                          },
                          controller: widget.stateController,
                          decoration: InputDecoration(
                            hintText: "Select state",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showStatePopup(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(16),
          
              // Country and Religion Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Country".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select country';
                            }
                            return null;
                          },
                          controller: widget.countryController,
                          decoration: InputDecoration(
                            hintText: "Select country",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showCountryPopup(),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Religion".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _partnerReligionKey,
                            readOnly: true,
                            controller: widget.religionController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerReligionKey,
                              items: controller.religions,
                              onSelected: controller.setSelectedPartnerReligion,
                              controller: widget.religionController,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select religion",
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
          
              // Profession and Education Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Profession".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select profession';
                            }
                            return null;
                          },
                          controller: widget.professionController,
                          decoration: InputDecoration(
                            hintText: "Select profession",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showProfessionPopup(),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Education".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select education';
                            }
                            return null;
                          },
                          controller: widget.educationController,
                          decoration: InputDecoration(
                            hintText: "Select education",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showEducationPopup(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(16),
          
              // Marital Status and Annual Income Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Marital Status".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _partnerMaritalStatusKey,
                            readOnly: true,
                            controller: widget.maritalStatusController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerMaritalStatusKey,
                              items: controller.maritalStatuses,
                              onSelected: controller.setSelectedPartnerMaritalStatus,
                              controller: widget.maritalStatusController,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select partner Marital Status",
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
                        MyText.labelMedium("Annual Income".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _partnerIncomeKey,
                            readOnly: true,
                            controller: widget.incomeController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerIncomeKey,
                              items: controller.annualIncomes,
                              onSelected: controller.setSelectedPartnerIncome,
                              controller: widget.incomeController,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select partner Income",
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
          
              // Mother Tongue and Caste Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Mother Tongue".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select mother tongue';
                            }
                            return null;
                          },
                          controller: widget.motherTongueController,
                          decoration: InputDecoration(
                            hintText: "Select mother tongue",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showMotherTonguePopup(),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Caste".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select caste';
                            }
                            return null;
                          },
                          controller: widget.casteController,
                          decoration: InputDecoration(
                            hintText: "Select caste",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showCastePopup(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(16),
          
              // Star and Dosham Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Star".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select star';
                            }
                            return null;
                          },
                          controller: widget.starController,
                          decoration: InputDecoration(
                            hintText: "Select star",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showStarPopup(),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium("Chovva Dosham".tr().capitalizeWords),
                          MySpacing.height(8),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Chovva Dosham';
                              }
                              return null;
                            },
                            controller: widget.doshamController,
                            decoration: InputDecoration(
                              hintText: "Select Chovva Dosham",
                              hintStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: widget.outlineInputBorder,
                              enabledBorder: widget.outlineInputBorder,
                              focusedBorder: widget.focusedInputBorder,
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              errorStyle: TextStyle(fontSize: 10),
                            ),
                            readOnly: true,
                            onTap: () => _showDoshamPopup(),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              MySpacing.height(20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      MyText.labelMedium("Eating Habit".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select eating habit';
                        }
                        return null;
                        },
                        controller: widget.eatingHabitController,
                        decoration: InputDecoration(
                        hintText: "Select eating habit",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: widget.focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorStyle: TextStyle(fontSize: 10),
                        ),
                        readOnly: true,
                        onTap: () => _showDoshamPopup(),
                      ),
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
                      TextFormField(
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select smoking habit';
                        }
                        return null;
                        },
                        controller: widget.smokingHabitController,
                        decoration: InputDecoration(
                        hintText: "Select smoking habit",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: widget.focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorStyle: TextStyle(fontSize: 10),
                        ),
                        readOnly: true,
                        onTap: () => _showStarPopup(),
                      ),
                      ],
                    ),
                    ),
                    MySpacing.width(16),
                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      MyText.labelMedium("Drinking Habit".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select drinking habit';
                        }
                        return null;
                        },
                        controller: widget.drinkingHabitController,
                        decoration: InputDecoration(
                        hintText: "Select drinking habit",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: widget.focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorStyle: TextStyle(fontSize: 10),
                        ),
                        readOnly: true,
                        onTap: () => _showStarPopup(),
                      ),
                      ],
                    ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Popup methods (to be implemented)
  void _showCitizenshipPopup() {}
  void _showStatePopup() {}
  void _showCountryPopup() {}
  void _showReligionPopup() {}
  void _showProfessionPopup() {}
  void _showEducationPopup() {}
  void _showMaritalStatusPopup() {}
  void _showIncomePopup() {}
  void _showMotherTonguePopup() {}
  void _showCastePopup() {}
  void _showStarPopup() {}
  void _showDoshamPopup() {}
}
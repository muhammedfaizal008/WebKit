import 'package:flutter/material.dart';
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
  });

  @override
  State<PartnerPreferences> createState() => _PartnerPreferencesState();
}


  class _PartnerPreferencesState extends State<PartnerPreferences> {

  @override
  Widget build(BuildContext context) {
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
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select citizenship';
                            }
                            return null;
                          },
                          controller: widget.citizenshipController,
                          decoration: InputDecoration(
                            hintText: "Select citizenship",
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
                          onTap: () => _showCitizenshipPopup(),
                        ),
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
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select religion';
                            }
                            return null;
                          },
                          controller: widget.religionController,
                          decoration: InputDecoration(
                            hintText: "Select religion",
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
                          onTap: () => _showReligionPopup(),
                        ),
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
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select marital status';
                            }
                            return null;
                          },
                          controller: widget.maritalStatusController,
                          decoration: InputDecoration(
                            hintText: "Select marital status",
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
                          onTap: () => _showMaritalStatusPopup(),
                        ),
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
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select annual income';
                            }
                            return null;
                          },
                          controller: widget.incomeController,
                          decoration: InputDecoration(
                            hintText: "Select income range",
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
                          onTap: () => _showIncomePopup(),
                        ),
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
                        MyText.labelMedium("Dosham".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select dosham option';
                            }
                            return null;
                          },
                          controller: widget.doshamController,
                          decoration: InputDecoration(
                            hintText: "Select dosham option",
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
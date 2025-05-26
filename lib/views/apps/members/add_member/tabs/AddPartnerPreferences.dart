import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_member_controller.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_preferences_controller.dart';
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


class AddPartnerPreferences extends StatefulWidget {
  const AddPartnerPreferences({
    super.key,
    required this.castePartnerController,
    required this.starPartnerController,
    required this.heightPartnerController,
    required this.motherTonguePartnerController,
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
  final TextEditingController starPartnerController;
  final TextEditingController heightPartnerController;
  final TextEditingController motherTonguePartnerController;
  final TextEditingController castePartnerController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController locationPartnerController;
  final TextEditingController professionPartnerController;
  final TextEditingController educationPartnerController;
  final GlobalKey<FormState> formKey;
  final AddMemberController controller;
  final ContentTheme contentTheme;

  @override
  State<AddPartnerPreferences> createState() => _AddPartnerPreferencesState();
}

class _AddPartnerPreferencesState extends State<AddPartnerPreferences> {
  late AddPreferencesController controller;
  final TextEditingController PartnerEatinghabitsController = TextEditingController();
  final TextEditingController PartnerSmokinghabitsController =TextEditingController();
  final TextEditingController PartnerDrinkinghabitsController =TextEditingController();
  final TextEditingController partnerCitizenshipController = TextEditingController();


  @override
  void initState() {
    controller = Get.put(AddPreferencesController());
    controller.fetchMaritalStatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MyFlexItem(
      sizes: "lg-7",
      child: MyContainer.bordered(
        paddingAll: 0,
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
                                controller: widget.agePartnerController,
                                decoration: InputDecoration(
                                    hintText: "25-30",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: widget.outlineInputBorder,
                                    enabledBorder: widget.outlineInputBorder,
                                    focusedBorder: widget.focusedInputBorder,
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
                                GestureDetector(
                                onTap: () async {
                                  await _showLocationPopup(context, controller,widget.locationPartnerController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedLocations.isEmpty) {
                                        return "Please select at least one location";
                                      }
                                      return null;
                                    },
                                    controller: widget.locationPartnerController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedLocations.isEmpty
                                          ? "Enter your partners location"
                                          : controller.selectedLocations.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedLocations.isNotEmpty
                                          ? controller.tempSelectedLocations.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
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
                              "partners Residing state".trim().tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            GestureDetector(
                                onTap: () async {
                                  await _showProfessionPopup(context, controller,widget.professionPartnerController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedProfessions.isEmpty) {
                                        return "Please select at least one profession";
                                      }
                                      return null;
                                    },
                                    controller: widget.professionPartnerController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedProfessions.isEmpty
                                          ? "Enter your partners profession"
                                          : controller.selectedProfessions.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedLocations.isNotEmpty
                                          ? controller.tempSelectedLocations.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
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
                              "partners Citizenship".trim().tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            GestureDetector(
                                onTap: () async {
                                  await _showcitizenshipPopup(context, controller,partnerCitizenshipController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
          
                                    validator: (value) {
                                      if (controller.selectedcitizenShip.isEmpty) {
                                        return "Please select at least one citizenship";
                                      }
                                      return null;
                                    },
                                    controller: partnerCitizenshipController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedcitizenShip.isEmpty
                                          ? "select partners citizenship"
                                          : controller.selectedcitizenShip.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedCitizenship.isNotEmpty
                                          ? controller.tempSelectedCitizenship.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ]),
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
                            GestureDetector(
                                onTap: () async {
                                  await _showProfessionPopup(context, controller,widget.professionPartnerController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedProfessions.isEmpty) {
                                        return "Please select at least one profession";
                                      }
                                      return null;
                                    },
                                    controller: widget.professionPartnerController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedProfessions.isEmpty
                                          ? "Enter your partners profession"
                                          : controller.selectedProfessions.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedProfessions.isNotEmpty
                                          ? controller.tempSelectedProfessions.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
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
                            GestureDetector(
                                onTap: () async {
                                  await _showEducationPopup(context, controller,widget.educationPartnerController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
          
                                    validator: (value) {
                                      if (controller.selectedEducation.isEmpty) {
                                        return "Please select at least one education";
                                      }
                                      return null;
                                    },
                                    controller: widget.educationPartnerController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedEducation.isEmpty
                                          ? "Enter your partners education"
                                          : controller.selectedEducation.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedEducation.isNotEmpty
                                          ? controller.tempSelectedEducation.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ]),
                    MySpacing.height(20),
                    Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                              "partners height".trim().tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your partners height";
                                  }
                                  
                                },
                                controller: widget.heightPartnerController  ,
                                decoration: InputDecoration(
                                    hintText: "120-200",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: widget.outlineInputBorder,
                                    enabledBorder: widget.outlineInputBorder,
                                    focusedBorder: widget.focusedInputBorder,
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
                              "partners mother tongue".trim().tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            GestureDetector(
                                onTap: () async {
                                  await _showMotherTonguePopup(context, controller,widget.motherTonguePartnerController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedMotherTongues.isEmpty) {
                                        return "Please select at least one mother tongue";
                                      }
                                      return null;
                                    },
                                    controller: widget.motherTonguePartnerController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedMotherTongues.isEmpty
                                          ? "Enter your partners mother tongue"
                                          : controller.selectedMotherTongues.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedMotherTongues.isNotEmpty
                                          ? controller.tempSelectedMotherTongues.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
                              )
          
                          ],
                        ),
                      ),
                    ]),
                    MySpacing.height(20),
                    Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            GetBuilder<AddPreferencesController>(
                              builder: (controller) =>  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium(
                                    "partners marital Status".trim().tr().capitalizeWords,
                                  ),
                                  MySpacing.height(8),
                                  PopupMenuButton<String>(
                                          itemBuilder: (BuildContext context) {
                                            return controller.maritalStatusList.map((behavior) {
                                              return PopupMenuItem<String>(
                                                value: behavior.status,
                                                height: 32,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width *0.6,
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
                                            paddingAll: 10,
                                            border: Border.all(
                                              color: controller.maritalStatusError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                MyText(
                                                  controller.maritalStatus.isEmpty ? "Select Marital status" : controller.maritalStatus,
                                                  color: theme.colorScheme.onSurface,
                                                  style: MyTextStyle.bodySmall(xMuted: true),
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
                                        if (controller.maritalStatusError != null)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            controller.maritalStatusError!,
                                            style: TextStyle(color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      MySpacing.width(10),
                      Expanded(
                        child: GetBuilder<AddPreferencesController>(
                          builder: (controller) =>  Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium(
                                    "partners annual Income".trim().tr().capitalizeWords,
                                  ),
                                  MySpacing.height(8),
                                  PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                            // Add "Any" option at the top
                                            final items = [
                                              PopupMenuItem<String>(
                                              value: "Any",
                                              height: 32,
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                child: MyText.bodySmall(
                                                "Any",
                                                color: theme.colorScheme.onSurface,
                                                fontWeight: 600,
                                                ),
                                              ),
                                              ),
                                              ...controller.annualIncomeList.map((behavior) {
                                              return PopupMenuItem<String>(
                                                value: behavior.range,
                                                height: 32,
                                                child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                child: MyText.bodySmall(
                                                  behavior.range,
                                                  color: theme.colorScheme.onSurface,
                                                  fontWeight: 600,
                                                ),
                                                ),
                                              );
                                              })
                                            ];
                                            return items;
                                            },
                                          position: PopupMenuPosition.under,
                                          offset: const Offset(0, 0),
                                          onSelected: controller.onSelectedannualIncome,
                                          color: theme.cardTheme.color,
                                          child: MyContainer.bordered(
                                            paddingAll: 10,
                                            border: Border.all(
                                              color: controller.annualIncomeError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                MyText(
                                                  controller.annualIncome.isEmpty ? "Select Annual Income" : controller.annualIncome,
                                                  color: theme.colorScheme.onSurface,
                                                  style: MyTextStyle.bodySmall(xMuted: true),
                                                ),
                                                SizedBox(width: 4),
                                                Icon(
                                                  LucideIcons.chevronDown,
                                                  size: 22,
                                                  color: theme.colorScheme.onSurface,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (controller.annualIncomeError != null)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            controller.annualIncomeError!,
                                            style: TextStyle(color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    MySpacing.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          LucideIcons.toggleRight,
                          size: 16,
                        ),
                        MySpacing.width(12),
                        MyText.titleMedium(
                          "religious preferences".tr().capitalizeWords,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                    MySpacing.height(16),
                    Row(children: [
                      Expanded(
                        child: Column( 
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<AddPreferencesController>(
                              builder: (controller) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium("Partner's Religion"),
                                  MySpacing.height(8),
                                  PopupMenuButton<String>(
                                    itemBuilder: (context) {
                                      return controller.religionList.map((religion) {
                                        return PopupMenuItem<String>(
                                          value: religion.name,
                                          child: Text(religion.name),
                                        );
                                      }).toList();
                                    },
                                    position: PopupMenuPosition.under,
                                          offset: const Offset(0, 0),
                                          onSelected: controller.onSelectedReligion,
                                          color: theme.cardTheme.color,
                                    child: MyContainer.bordered(
                                      paddingAll: 10,
                                            border: Border.all(
                                              color: controller.religionError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                            ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(controller.selectedReligion.isEmpty
                                              ? "Select religion"
                                              : controller.selectedReligion,style: MyTextStyle.bodySmall(xMuted: true),
                                              ),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (controller.religionError != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        controller.religionError!,
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                      
                      MySpacing.width(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                              "partners caste".trim().tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            GestureDetector(
                                onTap: () async {
                                  await _showcastePopup(context, controller,widget.castePartnerController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedMotherTongues.isEmpty) {
                                        return "Please select at least one partners caste";
                                      }
                                      return null;
                                    },
                                    controller: widget.castePartnerController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedCastes.isEmpty
                                          ? "Select partners caste"
                                          : controller.selectedCastes.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedCastes.isNotEmpty
                                          ? controller.tempSelectedCastes.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ]),
                    MySpacing.height(20), 
                    Row(children: [
                      Expanded(
                        child: Column( 
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<AddPreferencesController>(
                              builder: (controller) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium("Partner's star"),
                                  MySpacing.height(8),
                                  GestureDetector(
                                onTap: () async {
                                  await _showstarPopup(context, controller,widget.starPartnerController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedStar.isEmpty) {
                                        return "Please select at least one partners star";
                                      }
                                      return null;
                                    },
                                    controller: widget.castePartnerController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedStar.isEmpty
                                          ? "Select partners star"
                                          : controller.selectedStar.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedStar.isNotEmpty
                                          ? controller.tempSelectedStar.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
                              )
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                      
                      MySpacing.width(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<AddPreferencesController>(
                              builder: (controller) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium("Partner's Chovva Dosham"),
                                  MySpacing.height(8),
                                  PopupMenuButton<String>(
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem<String>(
                                          value: "Matters",
                                          child: Text("Matters"),
                                        ),
                                        PopupMenuItem<String>(
                                          value: "Doesn't Matter",
                                          child: Text("Doesn't Matter"),
                                        ),
                                      ];
                                    },
                                    position: PopupMenuPosition.under,
                                          offset: const Offset(0, 0),
                                          onSelected: controller.onSelectedChovvaDosham,
                                          color: theme.cardTheme.color,
                                    child: MyContainer.bordered(
                                      paddingAll: 10,
                                            border: Border.all(
                                              color: controller.ChovvaDoshamError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                            ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(controller.selectedChovvaDosham.isEmpty
                                              ? "Select an option"
                                              : controller.selectedChovvaDosham,style: MyTextStyle.bodySmall(xMuted: true),
                                              ),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (controller.religionError != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        controller.religionError!,
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                ],
                              ),
                            )
                            
                          ],
                        ),
                      ),
                    ]),
                    MySpacing.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          LucideIcons.toggleRight,
                          size: 16,
                        ),
                        MySpacing.width(12),
                        MyText.titleMedium(
                          "Lifestyle  preferences".tr().capitalizeWords,
                          fontWeight: 600,
                        ),
                      ],
                    ),
                    MySpacing.height(16),
                    Row(children: [
                      MySpacing.width(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                              "Eating habits".trim().tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            GestureDetector(
                                onTap: () async {
                                  await _showEatinghabitsPopup(context, controller,PartnerEatinghabitsController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedeatingHabits.isEmpty) {
                                        return "Please select at least one Eating habits";
                                      }
                                      return null;
                                    },
                                    controller: PartnerEatinghabitsController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedeatingHabits.isEmpty
                                          ? "Select Eating habits"
                                          : controller.selectedeatingHabits.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedEatingHabits.isNotEmpty
                                          ? controller.tempSelectedEatingHabits.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      
                      MySpacing.width(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                              "Smoking habits".trim().tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            GestureDetector(
                                onTap: () async {
                                  await _showSmokinghabitsPopup(context, controller,PartnerSmokinghabitsController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedSmokingHabits.isEmpty) {
                                        return "Please select at least one Smoking habits";
                                      }
                                      return null;
                                    },
                                    controller: PartnerSmokinghabitsController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedSmokingHabits.isEmpty
                                          ? "Select Smoking habits"
                                          : controller.selectedSmokingHabits.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedSmokingHabits.isNotEmpty
                                          ? controller.tempSelectedSmokingHabits.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      MySpacing.width(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                              "Drinking habits".trim().tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            GestureDetector(
                                onTap: () async {
                                  await _showDrinkinghabitsPopup(context, controller,PartnerDrinkinghabitsController);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (controller.selectedDrinkingHabits.isEmpty) {
                                        return "Please select at least one Drinking habits";
                                      }
                                      return null;
                                    },
                                    controller: PartnerDrinkinghabitsController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: controller.selectedDrinkingHabits.isEmpty
                                          ? "Select Drinking habits"
                                          : controller.selectedCastes.join(', '),
                                      // Show temp selections when dialog is open
                                      labelText: controller.tempSelectedDrinkingHabits.isNotEmpty
                                          ? controller.tempSelectedDrinkingHabits.join(', ')
                                          : null,
                                      labelStyle: MyTextStyle.bodySmall(),
                                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                      border: widget.outlineInputBorder,
                                      enabledBorder: widget.outlineInputBorder,
                                      focusedBorder: widget.focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ]),
                    MySpacing.height(16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: MyButton(
                        onPressed: () async {
                        final isFormValid = widget.formKey.currentState!.validate();
                          final isDropdownValid = controller.validateSelections();

                          if (isFormValid && isDropdownValid) {
                            await widget.controller.savePartnerPreferences(
                              widget.agePartnerController.text,
                              widget.locationPartnerController.text,
                              widget.professionPartnerController.text,
                              widget.educationPartnerController.text,
                            );

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
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showcitizenshipPopup(
  BuildContext context,
  AddPreferencesController controller,
  TextEditingController citizenshipController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Citizenship',
    allItems: controller.citizenshipList.map((citizen) => citizen.name).toList(),
    selectedItems: controller.selectedcitizenShip,
    tempSelectedItems: controller.tempSelectedCitizenship,
    textController: citizenshipController,
    itemToString: (item) => item,
  );
}

Future<void> _showSmokinghabitsPopup(
  BuildContext context, 
  AddPreferencesController controller,
  TextEditingController SmokingHabitsController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Smoking Habits',
    allItems: controller.smokingHabitsList.map((habit) => habit.name).toList(),
    selectedItems: controller.selectedSmokingHabits,
    tempSelectedItems: controller.tempSelectedSmokingHabits,
    textController: SmokingHabitsController,
    itemToString: (item) => item,
  );
}

Future<void> _showDrinkinghabitsPopup(
  BuildContext context, 
  AddPreferencesController controller,
  TextEditingController DrinkingHabitsController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Drinking Habits',
    allItems: controller.drinkingHabitsList.map((habit) => habit.name).toList(),
    selectedItems: controller.selectedDrinkingHabits,
    tempSelectedItems: controller.tempSelectedDrinkingHabits, 
    textController: DrinkingHabitsController,
    itemToString: (item) => item,
  );
}


Future<void> _showEatinghabitsPopup(
  BuildContext context, 
  AddPreferencesController controller,
  TextEditingController eatingHabitsController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Eating Habits',
    allItems: ['Any', ...controller.eatingHabitsList.map((habit) => habit.name)],
    selectedItems: controller.selectedeatingHabits,
    tempSelectedItems: controller.tempSelectedEatingHabits,
    textController: eatingHabitsController,
    itemToString: (item) => item,
  );
}

Future<void>_showstarPopup(
  BuildContext context, 
  AddPreferencesController controller,
  TextEditingController starPartnerController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Stars',
    allItems: ['Any', ...controller.starsList .map((star) => star.name)],
    selectedItems: controller.selectedStar,
    tempSelectedItems: controller.tempSelectedStar,
    textController: starPartnerController,
    itemToString: (item) => item,
  );
}


Future<void> _showcastePopup(
  BuildContext context, 
  AddPreferencesController controller,
  TextEditingController castePartnerController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Castes',
    allItems: ['Any',...controller.casteList.map((caste) => caste.name)],
    selectedItems: controller.selectedCastes,
    tempSelectedItems: controller.tempSelectedCastes,
    textController: castePartnerController,
    itemToString: (item) => item,
  );
}

Future<void> _showMotherTonguePopup(
  BuildContext context, 
  AddPreferencesController controller,
  TextEditingController motherTonguePartnerController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Mother Tongues',
    allItems: ['Any', ...controller.allMotherTongues.map((lang) => lang.name)],
    selectedItems: controller.selectedMotherTongues,
    tempSelectedItems: controller.tempSelectedMotherTongues,
    textController: motherTonguePartnerController,
    itemToString: (item) => item,
  );
}

Future<void> _showLocationPopup(
  BuildContext context, 
  AddPreferencesController controller,
  TextEditingController locationPartnerController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Locations',
    allItems: controller.allLocations.map((loc) => loc.name).toList(),
    selectedItems: controller.selectedLocations,
    tempSelectedItems: controller.tempSelectedLocations,
    textController: locationPartnerController,
    itemToString: (item) => item,
  );
}
  Future<void>_showEducationPopup(
    BuildContext context, 
  AddPreferencesController controller,
  TextEditingController educationPartnerController,
  ) async {
    await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Education',
    allItems: controller.allEducation.map((edu) => edu.name).toList(),
    selectedItems: controller.selectedEducation,
    tempSelectedItems: controller.tempSelectedEducation     ,
    textController: educationPartnerController,
    itemToString: (item) => item,
  );
  }

Future<void> _showProfessionPopup(
  BuildContext context, 
  AddPreferencesController controller,
  TextEditingController professionPartnerController,
) async {
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Professions',
    allItems: controller.allProfessions.map((prof) => prof.name).toList(),
    selectedItems: controller.selectedProfessions,
    tempSelectedItems: controller.tempSelectedProfessions,
    textController: professionPartnerController,
    itemToString: (item) => item,
  );
}
Future<void> _showMultiSelectPopup<T>({
  required BuildContext context,
  required AddPreferencesController controller,
  required String title,
  required List<T> allItems,
  required List<T> selectedItems,
  required List<T> tempSelectedItems,
  required TextEditingController textController,
  required String Function(T) itemToString,
}) async {
  // Initialize temp selections
  tempSelectedItems.clear();
  tempSelectedItems.addAll(selectedItems);
  controller.update();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: MyText.labelLarge(title),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  final item = allItems[index];
                  return CheckboxListTile(
                    title: MyText.labelMedium(itemToString(item)),
                    value: tempSelectedItems.contains(item),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedItems.add(item);
                        } else {
                          tempSelectedItems.remove(item);
                        }
                        controller.update();
                      });
                    },
                    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.blue; 
                      }
                      return Colors.white; 
                    }),
                  );
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: MyText.bodyMedium('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: MyText.bodyMedium('OK'),
                onPressed: () {
                  selectedItems.clear();
                  selectedItems.addAll(tempSelectedItems);
                  textController.text = selectedItems.map(itemToString).join(', ');
                  controller.update();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_member_controller.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_preferences_controller.dart';
import 'package:webkit/helpers/extensions/extensions.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';

class AddPartnerPreferences extends StatefulWidget {
  const   AddPartnerPreferences({
    super.key,
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

  @override
  void initState() {
    controller = Get.put(AddPreferencesController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MyFlexItem(
      sizes: "lg-7",
      child: MyContainer.bordered(
        paddingAll: 0,
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
                                  hintText: "Enter your Partners Age",
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
                                    if (controller.selectedProfessions.isEmpty) {
                                      return "Please select at least one education";
                                    }
                                    return null;
                                  },
                                  controller: widget.educationPartnerController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: controller.selectedEducation.isEmpty
                                        ? "Enter your partners education"
                                        : controller.selectedProfessions.join(', '),
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
                  MySpacing.height(16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MyButton(
                      onPressed: () async {
                        if (widget.formKey.currentState!.validate()) {
                          await widget.controller.savePartnerPreferences(
                              widget.agePartnerController.text,
                              widget.locationPartnerController.text,
                              widget.professionPartnerController.text,
                              widget.educationPartnerController.text);
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
    );
  }
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

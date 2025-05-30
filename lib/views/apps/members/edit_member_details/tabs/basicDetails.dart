import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/edit_members_controller/edit_members_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

class BasicDetails extends StatefulWidget {
  const BasicDetails({
    super.key,
    required this.uid,
    required this.annualIncomeController,
    required this.subsriptionController,      
    required this.forwhomController,
    required this.motherTongueController,
    required this.weightController,
    required this.nameController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.ageController,
    required this.locationController,
    required this.stateController,
    required this.professionController,
    required this.educationController,
    required this.heightController,
    required this.aboutMeController,
    required this.formKey,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final String uid;
  final TextEditingController annualIncomeController;
  final TextEditingController subsriptionController;
  final TextEditingController forwhomController;
  final TextEditingController motherTongueController;
  final TextEditingController weightController;
  final TextEditingController stateController;
  final TextEditingController nameController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController ageController;
  final TextEditingController locationController;
  final TextEditingController professionController;
  final TextEditingController educationController;
  final TextEditingController heightController;
  final TextEditingController aboutMeController;
  final GlobalKey<FormState> formKey;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  late EditMembersController controller;
  final GlobalKey _countryKey = GlobalKey();
  final GlobalKey _stateKey = GlobalKey();
  final GlobalKey _languageKey = GlobalKey();
  final GlobalKey _forWhomKey= GlobalKey();
  final GlobalKey _subscriptionKey= GlobalKey();
  final GlobalKey _incomeKey=GlobalKey();

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
      color: Colors.white,
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
                    "Basic Details".tr().capitalizeWords,
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
                      MyText.labelMedium("Full name".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        controller: widget.nameController,
                        style: MyTextStyle.bodySmall(),
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          hintStyle: MyTextStyle.bodySmall(xMuted: true),
                          border: widget.outlineInputBorder,
                          enabledBorder: widget.outlineInputBorder,
                          focusedBorder: widget.focusedInputBorder,
                          contentPadding: MySpacing.all(16),
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorStyle: TextStyle(fontSize: 10)),)
                    ],
                  ),
                ),
                MySpacing.width(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium("Age".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }
                          final age = int.tryParse(value);
                          if (age == null) {
                            return 'Please enter a valid number';
                          }
                          if (age < 0 || age > 100) {
                            return 'Please enter a valid age ';
                          }
                          return null;
                        },
                        controller: widget.ageController,
                        style: MyTextStyle.bodySmall(),
                        decoration: InputDecoration(
                          hintText: "Age",
                          hintStyle: MyTextStyle.bodySmall(xMuted: true),
                          border: widget.outlineInputBorder,
                          enabledBorder: widget.outlineInputBorder,
                          focusedBorder: widget.focusedInputBorder,
                          contentPadding: MySpacing.all(16),
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorStyle: TextStyle(fontSize: 10)),)
                    ],
                  ),
                ),
              ],
            ),
            MySpacing.height(16),
            Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.labelMedium("height".tr().capitalizeWords),
                    MySpacing.height(8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        final height = int.tryParse(value);
                        if (height == null) {
                          return 'Please enter a valid height';
                        }
                        if (height < 100 ) {
                          return 'Please enter a valid height ';
                        }
                        return null;
                      },
                      controller: widget.heightController,
                      style: MyTextStyle.bodySmall(),
                      decoration: InputDecoration(
                        hintText: "height",
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
                )),
                MySpacing.width(16),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.labelMedium("weight".tr().capitalizeWords),
                    MySpacing.height(8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        final weight = int.tryParse(value);
                        if (weight == null) {
                          return 'Please enter a valid weight';
                        }
                        if (weight < 20 ) {
                          return 'Please enter a valid weight ';
                        }
                        return null;
                      },
                      controller: widget.weightController,
                      style: MyTextStyle.bodySmall(),
                      decoration: InputDecoration(
                        hintText: "weight",
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
                ))
              ],
            ),
            MySpacing.height(10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium("Country".tr().capitalizeWords),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _countryKey,
                            readOnly: true,
                            controller: widget.locationController,
                            onTap: () => _showSelectionMenu(
                              key: _countryKey,
                              items: controller.countries,
                              onSelected: (country) {
                                controller.setSelectedPartnerCountry(country);
                                widget.locationController.text = country;
                              },
                              controller: widget.locationController,
                            ),
                            style: MyTextStyle.bodySmall(),
                            decoration: InputDecoration(
                              hintText: "Select Country",
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
                      MyText.labelMedium("State".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        key: _stateKey,
                        readOnly: true,
                        onTap: () => _showSelectionMenu(
                          key: _stateKey,
                          items: controller.states,
                          onSelected: controller.setSelectedstate, 
                          controller: widget.stateController,
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your state' : null,
                        controller: widget.stateController,
                        style: MyTextStyle.bodySmall(),
                        decoration: InputDecoration(
                          hintText: "State",
                          hintStyle: MyTextStyle.bodySmall(xMuted: true),
                          border: widget.outlineInputBorder,
                          enabledBorder: widget.outlineInputBorder,
                          focusedBorder: widget.focusedInputBorder,
                          contentPadding: MySpacing.all(16),
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorStyle: const TextStyle(fontSize: 10),
                        ),
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
                      MyText.labelMedium("mother tongue".tr().capitalizeWords),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _languageKey,
                            readOnly: true,
                            controller: widget.motherTongueController,
                            onTap: () => _showSelectionMenu(
                              key: _languageKey,
                              items: controller.languages,
                              onSelected: (value) {}, // No specific action needed for language
                              controller: widget.motherTongueController,
                            ),
                            style: MyTextStyle.bodySmall(),
                            decoration: InputDecoration(
                              hintText: "Select Mother tongue",
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
                      MyText.labelMedium("for whom".tr().capitalizeWords),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _forWhomKey,
                            readOnly: true,
                            controller: widget.forwhomController,
                            onTap: () => _showSelectionMenu(
                              key: _forWhomKey,
                              items: controller.forwhom,
                              onSelected: controller.setSelectforWhom,
                              controller: widget.forwhomController,
                            ),
                            style: MyTextStyle.bodySmall(),
                            decoration: InputDecoration(
                              hintText: "Select for whom",
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
                      MyText.labelMedium("Subscription".tr().capitalizeWords),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _subscriptionKey,
                            readOnly: true,
                            controller: widget.subsriptionController,
                            onTap: () => _showSelectionMenu(
                              key: _subscriptionKey,
                              items: controller.subscriptions,
                              onSelected: controller.setselectSubscription,
                              controller: widget.subsriptionController,
                            ),
                            style: MyTextStyle.bodySmall(),
                            decoration: InputDecoration(
                              hintText: "Select Subscription",
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
                MySpacing.width(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium("annual Income".tr().capitalizeWords),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _incomeKey,
                            readOnly: true,
                            controller: widget.annualIncomeController,
                            onTap: () => _showSelectionMenu(
                              key: _incomeKey,
                              items: controller.annualIncomes,
                              onSelected: controller.setselectIncome,
                              controller: widget.annualIncomeController,
                            ),style: MyTextStyle.bodySmall(),
                            decoration: InputDecoration(
                              hintText: "Select Subscription",
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
            
            Align(  
              alignment: Alignment.centerRight,
              child: MyButton(
                onPressed: () async { 
                  if (widget.formKey.currentState!.validate()) {
                    controller.updateBasicData(
                      uid: widget.uid,
                      age: widget.ageController.text,annualIncome: widget.annualIncomeController.text,country: widget.locationController.text,
                      forWhom: widget.forwhomController.text,fullName: widget.nameController.text,height: widget.heightController.text,motherTongue: widget.motherTongueController.text,
                      state: widget.stateController.text,subscription: widget.subsriptionController.text,weight: widget.weightController.text
                    );
        
                    widget.defaultTabController.animateTo(1);
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
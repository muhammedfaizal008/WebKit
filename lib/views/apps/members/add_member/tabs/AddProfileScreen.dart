import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';

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

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({
    super.key,
    required this.formkey,
    required this.context,
    required this.controller,
    required this.dobController,
    required this.ageController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.heightController,
    required this.professionController,
    required this.educationController,
    required this.locationController,
    required this.casteController,
    required this.aboutMeController,
    required this.religionController,
    required this.weightController,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final GlobalKey<FormState> formkey;
  final BuildContext context;
  final AddMemberController controller;
  final TextEditingController dobController;
  final TextEditingController ageController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController heightController;
  final TextEditingController professionController;
  final TextEditingController educationController;
  final TextEditingController locationController;
  final TextEditingController casteController;
  final TextEditingController aboutMeController;
  final TextEditingController religionController;
  final TextEditingController weightController;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
              @override
              Widget build(BuildContext context) {

                // Define a smaller error text style
                final errorTextStyle = MyTextStyle.bodySmall(fontSize: 10, xMuted: true);

                return SingleChildScrollView(
                  child: MyFlexItem(
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
                                    "profile_details".tr().capitalizeWords,
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
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "gender".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.genderList.map((category) {
                                                return PopupMenuItem<String>(
                                                  value: category,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    category,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onSelectedGender,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.genderError!=null? Colors.red:theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.selectedGender.isEmpty
                                                        ? "Select gender"
                                                        : widget.controller.selectedGender,
                                                    color: widget.controller.selectedGender.isNotEmpty
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
                                          if (widget.controller.genderError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.genderError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    MySpacing.width(8 ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "annual income".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.annualIncomeList.map((category) {
                                                return PopupMenuItem<String>(
                                                  value: category,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    category,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onSelectedannualIncome,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.annualIncomeError!=null? Colors.red:theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.selectedAnnualIncome.isEmpty
                                                        ? "Select annual income"
                                                        : widget.controller.selectedAnnualIncome,
                                                    color: widget.controller.selectedAnnualIncome.isNotEmpty
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
                                          if (widget.controller.annualIncomeError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.annualIncomeError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
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
                      
                                                if (pickedDate != null) {
                                                  final age = widget.controller.calculateAge(pickedDate);
                      
                                                  if (age >= 18 && age <= 120) {
                                                    // Set formatted DOB and computed age
                                                    widget.dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                    widget.ageController.text = age.toString(); // If age needed separately
                                                  } else {
                                                    Get.snackbar("Invalid Age", "Age must be between 18 and 120 years");
                                                    widget.dobController.clear();
                                                    widget.ageController.clear();
                                                  }
                                                }
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
                                    MySpacing.width(8), // Reduced spacing
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "height".tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          TextFormField(
                                            controller: widget.heightController,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "Please enter your height";
                                              }
                                              final height = double.tryParse(value);
                                              if (height == null ||
                                                  height < 100 ||
                                                  height > 300) {
                                                return "Enter a valid height (100-300 cm)";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Enter your height",
                                              hintStyle:
                                                  MyTextStyle.bodySmall(xMuted: true),
                                              border: widget.outlineInputBorder,
                                              enabledBorder: widget.outlineInputBorder,
                                              focusedBorder: widget.focusedInputBorder,
                                              contentPadding:
                                                  MySpacing.all(12), // Reduced padding
                                              isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              errorStyle: TextStyle(fontSize: 12),
                                              errorMaxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                MySpacing.height(16), // Reduced from 20
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "Weight".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          TextFormField(
                                            controller: widget.weightController,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "Please enter your Weight";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Enter your Weight",
                                              hintStyle:
                                                  MyTextStyle.bodySmall(xMuted: true),
                                              border: widget.outlineInputBorder,
                                              enabledBorder: widget.outlineInputBorder,
                                              focusedBorder: widget.focusedInputBorder,
                                              contentPadding: MySpacing.all(12),
                                              isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              errorStyle: TextStyle(fontSize: 12),
                                              errorMaxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    MySpacing.width(8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          MyText.labelMedium(
                                            "Physical Status".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.physicalStatusList.map((physicalstatus) {
                                                return PopupMenuItem<String>(
                                                  value: physicalstatus.status,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    physicalstatus.status,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onPhysicalStatusSelectedSize,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.physicalStatusError != null 
                                                    ? Colors.red 
                                                    : theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.physicalstatus.isEmpty 
                                                        ? "Select Physical status" 
                                                        : widget.controller.physicalstatus,
                                                    color: widget.controller.physicalstatus.isNotEmpty
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
                                          if (widget.controller.physicalStatusError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.physicalStatusError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
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
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "Profession".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.professionCategoryList.map((category) {
                                                return PopupMenuItem<String>(
                                                  value: category.name,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    category.name,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onProfessionSelectedSize,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.professionError!=null? Colors.red:theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.professionStatus.isEmpty
                                                        ? "Select profession Status"
                                                        : widget.controller.professionStatus,
                                                    color: widget.controller.professionStatus.isNotEmpty
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
                                          if (widget.controller.professionError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.professionError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    MySpacing.width(8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "Profession in Detail".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          TextFormField(
                                            controller: widget.professionController,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "Please enter your Profession in Detail";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Enter your Profession in Detail",
                                              hintStyle:
                                                  MyTextStyle.bodySmall(xMuted: true),
                                              border: widget.outlineInputBorder,
                                              enabledBorder: widget.outlineInputBorder,
                                              focusedBorder: widget.focusedInputBorder,
                                              contentPadding: MySpacing.all(12),
                                              isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              errorStyle: TextStyle(fontSize: 12),
                                              errorMaxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                MySpacing.height(16), // Reduced from 20
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          MyText.labelMedium(
                                            "Education Category".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.educationCategoryList.map((category) {
                                                return PopupMenuItem<String>(
                                                  value: category.name,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    category.name,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onEducationSelectedSize,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.educationError!=null? Colors.red:theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.educationStatus.isEmpty
                                                        ? "Select Education Status"
                                                        : widget.controller.educationStatus,
                                                    color: widget.controller.educationStatus.isNotEmpty
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
                                          if (widget.controller.educationError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.educationError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    MySpacing.width(8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "education in detail".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          TextFormField(
                                            controller: widget.educationController,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "Please enter your education";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Enter your Education",
                                              hintStyle:
                                                  MyTextStyle.bodySmall(xMuted: true),
                                              border: widget.outlineInputBorder,
                                              enabledBorder: widget.outlineInputBorder,
                                              focusedBorder: widget.focusedInputBorder,
                                              contentPadding: MySpacing.all(12),
                                              isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              errorStyle: TextStyle(fontSize: 12),
                                              errorMaxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                MySpacing.height(12), // Reduced from 16
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                              "Marital Status".tr().capitalizeWords),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.maritalStatusList.map((behavior) {
                                                return PopupMenuItem<String>(
                                                  value: behavior.status,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    behavior.status,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onSelectedmaritalStatus,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.maritalStatusError != null
                                                    ? Colors.red
                                                    : theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.maritalStatus.isEmpty
                                                        ? "Select Marital status"
                                                        : widget.controller.maritalStatus,
                                                    color: widget.controller.maritalStatus.isNotEmpty
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
                                          if (widget.controller.maritalStatusError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.maritalStatusError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    MySpacing.width(8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "Country".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.countryList.map((country) {
                                                return PopupMenuItem<String>(
                                                  value: country.name,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    country.name,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onCountrySelected,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.countryError != null 
                                                    ? Colors.red 
                                                    : theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.selectedCountry.isEmpty 
                                                        ? "Select Country you live in" 
                                                        : widget.controller.selectedCountry,
                                                    color: widget.controller.selectedCountry.isNotEmpty
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
                                          if (widget.controller.countryError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.countryError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                MySpacing.height(12), // Reduced from 16
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                              "State".tr().capitalizeWords),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.statesList.map((behavior) {
                                                return PopupMenuItem<String>(
                                                  value: behavior.name,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    behavior.name,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onStateSelected,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.stateError != null
                                                    ? Colors.red
                                                    : theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.selectedState.isEmpty
                                                        ? "Select the State you live in"
                                                        : widget.controller.selectedState,
                                                    color: widget.controller.selectedState.isNotEmpty
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
                                          if (widget.controller.stateError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.stateError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    MySpacing.width(8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelMedium(
                                            "citizenship".trim().tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          PopupMenuButton<String>(
                                            itemBuilder: (BuildContext context) {
                                              return widget.controller.citizenshipList.map((country) {
                                                return PopupMenuItem<String>(
                                                  value: country.name,
                                                  height: 32,
                                                  child: MyText.bodySmall(
                                                    country.name,
                                                    color: theme.colorScheme.onSurface,
                                                    fontWeight: 600,
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            position: PopupMenuPosition.under,
                                            offset: const Offset(0, 0),
                                            onSelected: widget.controller.onCitizenshipselected,
                                            color: theme.cardTheme.color,
                                            child: MyContainer.bordered(
                                              paddingAll: 10,
                                              border: Border.all(
                                                color: widget.controller.citizenShipError != null 
                                                    ? Colors.red 
                                                    : theme.colorScheme.onSurface.withOpacity(0.2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  MyText.bodySmall(
                                                    widget.controller.selectedcitizenShip.isEmpty 
                                                        ? "Select citizenship" 
                                                        : widget.controller.selectedcitizenShip,
                                                    color: widget.controller.selectedcitizenShip.isNotEmpty
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
                                          if (widget.controller.citizenShipError != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                widget.controller.citizenShipError!,
                                                style: TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                MySpacing.height(8),
                                
                                MyText.labelMedium(
                                  "About me".trim().tr().capitalizeWords,
                                ),
                                MySpacing.height(8),
                                TextFormField(
                                  controller: widget.aboutMeController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter something about yourself";
                                    }
                                    if (value.length < 10) {
                                      return "About me should be at least 10 characters long";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "About Me ...",
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
                                MySpacing.height(16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MyButton(
                                        onPressed: () async {
                                          final isFormValid = widget.formkey.currentState!.validate();
                                          final areDropdownsValid = widget.controller.validateProfile();
                                                            
                                          if (isFormValid && areDropdownsValid) {
                                            await widget.controller.saveProfile(
                                              widget.dobController.text,
                                              widget.ageController.text,
                                              widget.professionController.text,
                                              widget.educationController.text,
                                              widget.heightController.text,
                                              widget.aboutMeController.text,
                                              widget.weightController.text 
                                            );
                                        }
                                        },
                                        elevation: 0,
                                        padding: MySpacing.xy(20, 16),
                                        backgroundColor: widget.contentTheme.primary,
                                        borderRadiusAll: AppStyle.buttonRadius.medium,
                                        child: MyText.bodySmall("Save",color: widget.contentTheme.onPrimary,)),
                                      MySpacing.width(8),   
                                      MyButton(
                                        onPressed: () async {
                                          final isFormValid = widget.formkey.currentState!.validate();
                                          final areDropdownsValid = widget.controller.validateProfile();
                                                            
                                            if (isFormValid && areDropdownsValid) {
                                            await widget.controller.saveProfile(
                                              widget.dobController.text,
                                              widget.ageController.text,
                                              widget.professionController.text,
                                              widget.educationController.text,
                                              widget.heightController.text,
                                              widget.aboutMeController.text,
                                              widget.weightController.text,
                                              
                                            );
                                            widget.defaultTabController.animateTo(3);
                                          }
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
}
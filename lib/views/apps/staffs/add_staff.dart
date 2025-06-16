import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/staffs/add_staff_controller.dart';
import 'package:webkit/controller/apps/staffs/all_staff_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/models/all_staff_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> with UIMixin{
  late AddStaffController controller;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  @override
  void initState() {
    controller = Get.put(AddStaffController());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: AddStaffController(),
        builder: (controller) {
          return Column(
            children: [
              Padding(
              padding: MySpacing.x(flexSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.titleMedium(
                    "Add staff".capitalizeWords,
                    fontSize: 18,
                    fontWeight: 600,
                  ),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: 'Staffs'),
                      MyBreadcrumbItem(name: 'Add staff', active: true),
                    ],
                  ),
                ],
              ),
            ),
            MySpacing.height(flexSpacing),
            Padding(
  padding: MySpacing.x(flexSpacing / 2),
  child: MyFlex(
    children: [
      MyFlexItem(
        sizes: "lg-10 md-12",
        child: MyContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.titleMedium(
                "Add Staff Details".capitalizeWords,
                fontWeight: 600,
              ),
              const Divider(height: 28),
              MySpacing.height(8),

              /// Row 1: Full Name & Email
              MyFlex(
                wrapAlignment: WrapAlignment.start,
                runSpacing: 16,
                children: [
                  MyFlexItem(
                    sizes: "lg-6 md-6 sm-12",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Full Name"),
                        MySpacing.height(8),
                        TextFormField(
                          controller: nameController,
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Enter name' : null,
                          style: MyTextStyle.bodySmall(),
                          decoration: InputDecoration(
                            hintText: "Full Name",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyFlexItem(
                    sizes: "lg-6 md-6 sm-12",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Phone Number"),
                        MySpacing.height(8),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          style: MyTextStyle.bodySmall(),
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
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

              MySpacing.height(16),

              /// Row 2: Password & Phone Number
              MyFlex(
                wrapAlignment: WrapAlignment.start,
                runSpacing: 16,
                children: [
                  MyFlexItem(
                    sizes: "lg-6 md-6 sm-12",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Email"),
                        MySpacing.height(8),
                        TextFormField(
                          controller: emailController,
                          style: MyTextStyle.bodySmall(),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyFlexItem(
                    sizes: "lg-6 md-6 sm-12",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Password"),
                        MySpacing.height(8),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          style: MyTextStyle.bodySmall(),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
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

              MySpacing.height(16),

              /// Role
              MyFlex(
                children: [
                  MyFlexItem(
                    sizes: "lg-6 md-6 sm-12",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Role"),
                        MySpacing.height(8),
                        DropdownButtonFormField<String>(
                          value: roleController.text.isNotEmpty ? roleController.text : null,
                          items: controller.roleList.map((role) {
                            return DropdownMenuItem<String>(
                              value: role,
                              child: MyText.bodySmall(role),
                            );
                          }).toList(),
                          onChanged: controller.onSelectedRole,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true, // Ensure the background is filled
                            hintText: "Select Role",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: const TextStyle(fontSize: 10),
                          ),
                          dropdownColor: Colors.white, // Set dropdown menu color to white
                          style: MyTextStyle.bodySmall(),
                          validator: (value) =>
                            value == null || value.isEmpty ? 'Select role' : null,
                        ),
                      
                      ],
                    ),
                  ),
                ],
              ),

              MySpacing.height(24),

              /// Submit Button
              Align(  
              alignment: Alignment.centerRight,
              child: MyButton(
                onPressed: () async { 
                 controller.createUser(emailController.text, passwordController.text);
                  controller.saveUserData(nameController.text, emailController.text, phoneController.text);
                        
                  Get.snackbar(
      'Basic Details updated',
      '',
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(top: 20, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      backgroundColor: Colors.green[700],
      borderRadius: 8,
      maxWidth: 300,
      messageText: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        Icon(Icons.check_circle, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Flexible(
          child: Text(
          'Basic data updated',
          style: TextStyle(color: Colors.white),
          ),
        ),
        ],
      ),
      titleText: SizedBox(),
      duration: Duration(seconds: 2),
      );
                },
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: MyText.bodySmall(
                  'Submit'.capitalizeWords,
                  color: contentTheme.onPrimary,
                ),
              ),
            )
            ],
          ),
        ),
      ),
    ],
  ),
)

            ],
          );
        },
      ),
    );
  }
}


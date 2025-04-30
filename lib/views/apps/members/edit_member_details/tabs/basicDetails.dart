import 'package:flutter/material.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

class basicDetails extends StatelessWidget {
  const basicDetails({
    super.key,
    required this.nameController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.ageController,
    required this.locationController,
    required this.professionController,
    required this.educationController,
    required this.heightController,
    required this.formKey,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final TextEditingController nameController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController ageController;
  final TextEditingController locationController;
  final TextEditingController professionController;
  final TextEditingController educationController;
  final TextEditingController heightController;
  final GlobalKey<FormState> formKey;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "Full name".tr().capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                                    
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Full Name",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder:
                            outlineInputBorder,
                        focusedBorder:
                            focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                          fontSize: 10  
                        )        
                        ),
                  ),
                ],
              ),
            ),
            MySpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "Age".tr().capitalizeWords,
                  ),
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
                    controller: ageController,
                    decoration: InputDecoration(
                        hintText: "Age",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder:
                            outlineInputBorder,
                        focusedBorder:
                            focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                          fontSize: 10  
                        )        
                        ),
                  ),
                ],
              ),
            ),
            MySpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "location".tr().capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                                    
                    controller: locationController,
                    decoration: InputDecoration(
                        hintText: "Location",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder:
                            outlineInputBorder,
                        focusedBorder:
                            focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                          fontSize: 10  
                        )        
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "Profession".tr().capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Profession';
                      }
                      return null;
                    },
                                    
                    controller: professionController,
                    decoration: InputDecoration(
                        hintText: "Profession",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder:
                            outlineInputBorder,
                        focusedBorder:
                            focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                          fontSize: 10  
                        )        
                        ),
                  ),
                ],
              ),
            ),
            MySpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "Education".tr().capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Education';
                      }
                      return null;
                    },
                                    
                    controller: educationController,
                    decoration: InputDecoration(
                        hintText: "Education",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder:
                            outlineInputBorder,
                        focusedBorder:
                            focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                          fontSize: 10  
                        )        
                        ),
                  ),
                ],
              ),
            ),
            MySpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "Height".tr().capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        final height = double.tryParse(value);
                        if (height == null) {
                          return 'Please enter a valid number';
                        }
                        if (height < 50 || height > 300) {
                          return 'Please enter a height between 50 and 300 cm';
                        }
                        return null;
                      },      
                    controller: heightController,
                    decoration: InputDecoration(
                        hintText: "Height",
                        hintStyle:
                            MyTextStyle.bodySmall(
                                xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder:
                            outlineInputBorder,
                        focusedBorder:
                            focusedInputBorder,
                        contentPadding:
                            MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior:
                            FloatingLabelBehavior
                                .never,
                        errorStyle: TextStyle(
                          fontSize: 10  
                        )        
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        MySpacing.height(16),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
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
              controller: heightController,
              decoration: InputDecoration(
                  hintText: "About Me",
                  hintStyle:
                      MyTextStyle.bodySmall(
                          xMuted: true),
                  border: outlineInputBorder,
                  enabledBorder:
                      outlineInputBorder,
                  focusedBorder:
                      focusedInputBorder,
                  contentPadding:
                      MySpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior:
                      FloatingLabelBehavior
                          .never,
                  errorStyle: TextStyle(
                    fontSize: 10  
                  )        
                  ),
            ),
          ],
        ),
            MySpacing.height(18),   
            Align(
              alignment: Alignment.centerRight,
              child: MyButton(
                onPressed: () async {
                  if(formKey.currentState!.validate()){
                    
                  defaultTabController.animateTo(1);
                  
                  
                  }                                        
                },
                elevation: 0, 
                padding: MySpacing.xy(20, 16),
                backgroundColor: contentTheme.primary,
                borderRadiusAll:
                    AppStyle.buttonRadius.medium,
                child: MyText.bodySmall(
                  'Submit'.tr().capitalizeWords,
                  color: contentTheme.onPrimary,
                ),
              ),
            ),
      ],
    );
  }
}
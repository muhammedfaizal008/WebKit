  import 'package:flutter/material.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:get/get_instance/get_instance.dart';
  import 'package:webkit/controller/apps/members/edit_members_controller.dart';
  import 'package:webkit/helpers/extensions/string.dart';
  import 'package:webkit/helpers/theme/admin_theme.dart';
  import 'package:webkit/helpers/theme/app_style.dart';
  import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
  import 'package:webkit/helpers/widgets/my_spacing.dart';
  import 'package:webkit/helpers/widgets/my_text.dart';
  import 'package:webkit/helpers/widgets/my_text_style.dart';

  class basicDetails extends StatefulWidget {
    const basicDetails({
      super.key,
      required this.uid,
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
    State<basicDetails> createState() => _basicDetailsState();
  }

  class _basicDetailsState extends State<basicDetails> {
    late EditMembersController controller;
    @override
    void initState() {
      controller = Get.put<EditMembersController>(EditMembersController());
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      final GlobalKey _countryKey = GlobalKey();
  final GlobalKey _stateKey = GlobalKey();

      return SingleChildScrollView(
        child: MyContainer.bordered(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          controller: widget.nameController,
                          decoration: InputDecoration(
                              hintText: "Full Name",
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
                          controller: widget.ageController,
                          decoration: InputDecoration(
                              hintText: "Age",
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
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium(
                          "height".tr().capitalizeWords,
                        ),
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
                      MyText.labelMedium(
                        "weight".tr().capitalizeWords,
                        ),
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
                        TextFormField(
                          key: _countryKey,
                          readOnly: true,
                          onTap: () async {
                            final renderBox = _countryKey.currentContext!.findRenderObject() as RenderBox;
                            final offset = renderBox.localToGlobal(Offset.zero);
                            final position = RelativeRect.fromLTRB(
                              offset.dx,
                              offset.dy + renderBox.size.height,
                              offset.dx + renderBox.size.width,
                              offset.dy,
                            );
          
                            final selectedLocation = await showMenu<String>(
                              context: context,
                              position: position,
                              items: const [
                                PopupMenuItem(value: 'USA', child: Text('USA')),
                                PopupMenuItem(value: 'India', child: Text('India')),
                                PopupMenuItem(value: 'Canada', child: Text('Canada')),
                              ],
                            );
          
                            if (selectedLocation != null) {
                              widget.locationController.text = selectedLocation;
                            }
                          },
                          validator: (value) => value == null || value.isEmpty ? 'Please enter your location' : null,
                          controller: widget.locationController,
                          decoration: InputDecoration(
                            hintText: "Country",
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
                          onTap: () async {
                            final renderBox = _stateKey.currentContext!.findRenderObject() as RenderBox;
                            final offset = renderBox.localToGlobal(Offset.zero);
                            final position = RelativeRect.fromLTRB(
                              offset.dx,
                              offset.dy + renderBox.size.height,
                              offset.dx + renderBox.size.width,
                              offset.dy,
                            );
          
                            final selectedState = await showMenu<String>(
                              context: context,
                              position: position,
                              items: const [
                                PopupMenuItem(value: 'California', child: Text('California')),
                                PopupMenuItem(value: 'Texas', child: Text('Texas')),
                                PopupMenuItem(value: 'New York', child: Text('New York')),
                              ],
                            );
          
                            if (selectedState != null) {
                              widget.stateController.text = selectedState; // Use correct controller
                            }
                          },
                          validator: (value) => value == null || value.isEmpty ? 'Please enter your state' : null,
                          controller: widget.stateController, // Use different controller for state
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
                        MyText.labelMedium(
                          "mother tongue".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mother tongue';
                            }
                            return null;
                          },
                          controller: widget.motherTongueController,
                          decoration: InputDecoration(
                              hintText: "mother tongue",
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
                          "for whom".tr().capitalizeWords,
                        ),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select for whom the profile is';
                            }
                            return null;
                          },
                          controller: widget.forwhomController,
                          decoration: InputDecoration(
                              hintText: "for whom",
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
              Row(
                children: [
                  Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.labelMedium(
                              "Subscription".tr().capitalizeWords,
                            ),
                            MySpacing.height(8),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select Subscription';
                                }
                                return null;
                              },
                              controller: widget.subsriptionController,
                              decoration: InputDecoration(
                                  hintText: "Subscription",
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
              Align(  
                alignment: Alignment.centerRight,
                child: MyButton(
                  onPressed: () async { 
                    if (widget.formKey.currentState!.validate()) {
                      controller.updateBasicData(
                        uid: widget.uid,
                        name: widget.nameController.text,
                        age: widget.ageController.text,
                        location: widget.locationController.text,
                        profession: widget.professionController.text,
                        education: widget.educationController.text,
                        height: widget.heightController.text,
                        aboutMe: widget.aboutMeController.text,
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

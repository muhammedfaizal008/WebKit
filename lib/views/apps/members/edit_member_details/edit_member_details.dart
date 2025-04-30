import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:webkit/controller/apps/members/edit_members_controller.dart';
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
import 'package:webkit/models/user_model.dart';
import 'package:webkit/views/apps/members/edit_member_details/tabs/basicDetails.dart';
import 'package:webkit/views/apps/members/edit_member_details/tabs/personal_details.dart';
import 'package:webkit/views/layouts/layout.dart';

class EditMemberDetails extends StatefulWidget {
  const EditMemberDetails({super.key});

  @override
  State<EditMemberDetails> createState() => _EditMemberDetailsState();
}

class _EditMemberDetailsState extends State<EditMemberDetails>
    with SingleTickerProviderStateMixin, UIMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TabController defaultTabController;
  int currentTabIndex = 0;
  late EditMembersController controller;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController maritalStatusController =TextEditingController();
  final TextEditingController motherTongueController = TextEditingController();
  final TextEditingController agePartnerController = TextEditingController();
  final TextEditingController locationPartnerController =TextEditingController();
  final TextEditingController professionPartnerController =TextEditingController();
  final TextEditingController educationPartnerController =TextEditingController();   

  @override
  void initState() {
    super.initState();
    controller = Get.put(EditMembersController());
    defaultTabController =
        TabController(length: 3, vsync: this, initialIndex: currentTabIndex);
    controller.fetchAllUsers();
    log(controller.users.toString());

    final UserModel user = Get.arguments;

  if (user != null) {
    _populateControllers(user);
  }
  }

  void _populateControllers(UserModel user) {
  nameController.text = user.fullName ?? '';
  ageController.text = user.age?.toString() ?? '';
  locationController.text = user.location ?? '';
  professionController.text = user.profession ?? '';
  educationController.text = user.education ?? '';
  heightController.text = user.height?.toString() ?? '';
  religionController.text = user.religion ?? '';
  casteController.text = user.caste ?? '';
  aboutMeController.text = user.aboutMe ?? '';
  phoneNumberController.text = user.phoneNumber ?? '';
  maritalStatusController.text = user.maritalStatus ?? '';
  motherTongueController.text = user.language ?? '';
  agePartnerController.text = user.partnerAge?.toString() ?? '';
  locationPartnerController.text = user.partnerLocation ?? '';
  professionPartnerController.text = user.partnerProfession ?? '';
  educationPartnerController.text = user.partnerEducation ?? '';
}




  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder(
      init: EditMembersController(),
      builder: (controller) => Column(
        children: [
          Padding(
            padding: MySpacing.x(flexSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.titleMedium(
                  "Edit Users Details",
                  fontWeight: 600,
                ),
                MyBreadcrumb(
                  children: [
                    MyBreadcrumbItem(name: "Users"),
                    MyBreadcrumbItem(name: "Edit Users Details", active: true),
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
                  sizes: "lg-8 md-12",
                  child: MyContainer(
                    child: Column(
                      children: [
                        MyText.titleMedium(
                          "Profile Details".tr().capitalizeWords,
                          fontWeight: 600,
                        ),
                        const Divider(height: 28),
                        TabBar(
                          controller: defaultTabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(
                              icon: MyText.bodyMedium(
                                "basic details".tr().capitalizeWords,
                                fontWeight: currentTabIndex == 0 ? 600 : 500,
                                color: currentTabIndex == 0
                                    ? contentTheme.primary
                                    : null,
                              ),
                            ),
                            // Tab(
                            //   icon: MyText.bodyMedium(
                            //     "Phone Registration".tr(),
                            //     fontWeight: currentTabIndex == 1 ? 600 : 500,
                            //     color: currentTabIndex == 1 ? contentTheme.primary : null,
                            //   ),
                            // ),
                            Tab(
                              icon: MyText.bodyMedium(
                                "Personal Details".tr(),
                                fontWeight: currentTabIndex == 1 ? 600 : 500,
                                color: currentTabIndex == 1
                                    ? contentTheme.primary
                                    : null,
                              ),
                            ),

                            Tab(
                              icon: MyText.bodyMedium(
                                "Partner Preferences".tr(),
                                fontWeight: currentTabIndex == 2 ? 600 : 500,
                                color: currentTabIndex == 2
                                    ? contentTheme.primary
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        MySpacing.height(16),
                        SizedBox(
                          height: 600,
                          child: Form(
                            key: formKey,
                            child: TabBarView(
                              controller: defaultTabController,
                              children: [
                                basicDetails(
                                    nameController: nameController,
                                    outlineInputBorder: outlineInputBorder,
                                    focusedInputBorder: focusedInputBorder,
                                    ageController: ageController,
                                    locationController: locationController,
                                    professionController: professionController,
                                    educationController: educationController,
                                    heightController: heightController,
                                    formKey: formKey,
                                    defaultTabController: defaultTabController,
                                    contentTheme: contentTheme),
                                PersonalDetails(
                                    theme: theme,
                                    outlineInputBorder: outlineInputBorder,
                                    religionController: religionController,
                                    casteController: casteController,
                                    professionController: professionController,
                                    educationController: educationController,
                                    formKey: formKey,
                                    defaultTabController: defaultTabController,
                                    contentTheme: contentTheme),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText.labelMedium(
                                                "Partner age".tr().capitalizeWords,
                                              ),
                                              MySpacing.height(8),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your Partner age';
                                                  }
                                                  return null;
                                                },
                                                controller: ageController,
                                                decoration: InputDecoration(
                                                    hintText: "Partner age",
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
                                                        fontSize: 10)),
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
                                                "partners location".tr().capitalizeWords,
                                              ),
                                              MySpacing.height(8),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your partners location ';
                                                  }
                                                  return null;
                                                },
                                                controller: locationController,
                                                decoration: InputDecoration(
                                                    hintText: "Partners location",
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
                                                        fontSize: 10)),
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
                                                "Partners Profession"
                                                    .tr()
                                                    .capitalizeWords,
                                              ),
                                              MySpacing.height(8),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your Partners Profession';
                                                  }
                                                  return null;
                                                },
                                                controller:
                                                    professionController,
                                                decoration: InputDecoration(
                                                    hintText: "Partners Profession",
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
                                                        fontSize: 10)),
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
                                                "Partners Education"
                                                    .tr()
                                                    .capitalizeWords,
                                              ),
                                              MySpacing.height(8),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your Partners Education';
                                                  }
                                                  return null;
                                                },
                                                controller: educationController,
                                                decoration: InputDecoration(
                                                    hintText: "Partners Education",
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
                                                        fontSize: 10)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    MySpacing.height(18),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: MyButton(
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
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
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

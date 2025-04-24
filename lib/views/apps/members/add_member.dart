import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_member_controller.dart';
import 'package:webkit/controller/apps/members/link_phone_controller.dart';
import 'package:webkit/controller/forms/basic_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/app_style.dart';
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
import 'package:webkit/views/layouts/layout.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddMemberController controller;
  late LinkPhoneController linkPhoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int currentTabIndex = 0;

  late TabController defaultTabController;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController motherTongueController = TextEditingController();
  final TextEditingController agePartnerController = TextEditingController();
  final TextEditingController locationPartnerController = TextEditingController();
  final TextEditingController professionPartnerController = TextEditingController();
  final TextEditingController educationPartnerController = TextEditingController();
  final TextEditingController otpController = TextEditingController();


  bool registrationdone = false;

  @override
  void initState() {
    controller = Get.put(AddMemberController());
    linkPhoneController = Get.put(LinkPhoneController());  
    defaultTabController = TabController(length: 4, vsync: this, initialIndex: currentTabIndex);
    defaultTabController.addListener(() {
      if (defaultTabController.index != currentTabIndex) {
        setState(() {
          currentTabIndex = defaultTabController.index;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<AddMemberController>(
        builder: (_) => Column(
          children: [
            Padding(
              padding: MySpacing.x(flexSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.titleMedium(
                    "Add Users".tr().capitalizeWords,
                    fontSize: 18,
                    fontWeight: 600,
                  ),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: 'forms'),
                      MyBreadcrumbItem(name: 'Basic', active: true),
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
                    sizes: "lg-7 md-12",
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
                                  "Registration".tr(),
                                  fontWeight: currentTabIndex == 0 ? 600 : 500,
                                  color: currentTabIndex == 0 ? contentTheme.primary : null,
                                ),
                              ),
                              Tab(
                                icon: MyText.bodyMedium(
                                  "Phone Registration".tr(),
                                  fontWeight: currentTabIndex == 1 ? 600 : 500,
                                  color: currentTabIndex == 1 ? contentTheme.primary : null,
                                ),
                              ),
                              Tab(
                                icon: MyText.bodyMedium(
                                  "profile".tr(),
                                  fontWeight: currentTabIndex == 1 ? 600 : 500,
                                  color: currentTabIndex == 1 ? contentTheme.primary : null,
                                ),
                              ),
                              
                              Tab(
                                icon: MyText.bodyMedium(
                                  "Partner Preferences".tr(),
                                  fontWeight: currentTabIndex == 2 ? 600 : 500,
                                  color: currentTabIndex == 2 ? contentTheme.primary : null,
                                ),
                              ),
                            ],
                          ),
                          MySpacing.height(16),
                          SizedBox(
                            height: 600,
                            child: TabBarView(
                              controller: defaultTabController,
                              children: [
                                registrationdone
                                    ? MyContainer(
                                        paddingAll: 12,
                                        borderRadiusAll: 10,
                                        color: Colors.grey.shade100,
                                        child: Column(
                                          children: [
                                            MyText.bodyMedium(
                                              "Registration Done",
                                              fontWeight: 600,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                              "Enter the other Details ...",
                                              muted: true,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      )
                                    : registrationScreen(),
                                phoneRegistrationScreen(),
                                profileScreen(),
                                partnerPreferences(),
                              ],
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
      ),
    );
  }
  MyFlexItem phoneRegistrationScreen() {
  return MyFlexItem(
    sizes: "lg-7",
    child: MyContainer.bordered(
      paddingAll: 0,
      child: GetBuilder<LinkPhoneController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(8),
                child: MyContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(LucideIcons.toggleRight, size: 16),
                      MySpacing.width(12),
                      MyText.titleMedium(
                        "Phone Registration".tr().capitalizeWords,
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
                    MyText.labelMedium("Phone Number".tr().capitalizeWords),
                    MySpacing.height(8),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: "Enter your Phone Number",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    MySpacing.height(20),

                    // Show OTP field if sent
                    if (controller.isOtpSent) ...[
                      MyText.labelMedium("Enter OTP".tr()),
                      MySpacing.height(8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter OTP",
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: focusedInputBorder,
                          contentPadding: MySpacing.all(16),
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        keyboardType: TextInputType.number,
                        controller: otpController,
                      ),
                      MySpacing.height(20),
                    ],

                    // Buttons
                    if (!controller.isLoading)
                      Row(
                        children: [
                          if (!controller.isOtpSent)
                            MyButton(
                              onPressed: () async {
                                await controller.sendOtp(
                                  context,
                                  phoneNumberController.text,
                                );
                              },
                              elevation: 0,
                              padding: MySpacing.xy(20, 16),
                              backgroundColor: contentTheme.primary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: MyText.bodySmall(
                                'Send Otp'.tr().capitalizeWords,
                                color: contentTheme.onPrimary,
                              ),
                            ),
                          if (controller.isOtpSent)
                              MyButton(
                                onPressed: () async { 
                                  // Step 1: Verify the OTP
                                  bool verified = await controller.verifyOtp(context, otpController.text);

                                  // Step 2: If verified, link the number
                                  if (verified) {
                                    await controller.linkPhoneNumber(context);
                                    controller.reset();

                                    defaultTabController.animateTo(2);
                                  
                                  }
                                  
                                },
                                elevation: 0,
                                padding: MySpacing.xy(20, 16),
                                backgroundColor: contentTheme.primary,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: MyText.bodySmall(
                                  'Verify & Link'.tr().capitalizeWords,
                                  color: contentTheme.onPrimary,
                                ),
                              ),

                        ],
                      ),

                    if (controller.isLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}


    MyFlexItem partnerPreferences() {
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      MyText.labelMedium(
                                                        "Partners Age".tr().capitalizeWords,
                                                      ),
                                                      MySpacing.height(8),
                                                      TextFormField(
                                                        controller: agePartnerController,
                                                        decoration: InputDecoration(
                                                            hintText: "Enter your Partners Age",
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
                                                                    .never),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                MySpacing.width(10),
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
                                                        controller: locationPartnerController,
                                                        decoration: InputDecoration(
                                                            hintText: "Enter your partners location",
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
                                                                    .never),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            MySpacing.height(20),
                                            
                                            Row(
                                              children:[ 
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      MyText.labelMedium(
                                                        "partners Profession".trim().tr().capitalizeWords,
                                                      ),
                                                      MySpacing.height(8),
                                                      TextFormField(
                                                      controller: professionPartnerController,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter your partners profession",
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
                                                                  .never),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                MySpacing.width(10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                  children: [
                                                    MyText.labelMedium(
                                                      "partners education".trim().tr().capitalizeWords,
                                                    ),
                                                    MySpacing.height(8),
                                                    TextFormField(
                                                      controller: educationPartnerController,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter your partners education",
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
                                                                  .never),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ]
                                            ),
                                            MySpacing.height(16),

                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: MyButton(
                                                onPressed: () async {
                                                  await controller.savePartnerPreferences(
                                                    agePartnerController.text, locationPartnerController.text, professionPartnerController.text,
                                                    educationPartnerController.text
                                                  );
                                                  Get.snackbar(
                                                    "Success",
                                                    "Profile Created Successfully",
                                                    backgroundColor: Colors.green,
                                                    colorText: Colors.white,
                                                  );
                                                  Get.offNamed("/"); 
                                                  

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
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
    }

    MyFlexItem profileScreen() {
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
                                                        controller: ageController,
                                                        decoration: InputDecoration(
                                                            hintText: "Enter your Age",
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
                                                                    .never),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                MySpacing.width(10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      MyText.labelMedium(
                                                        "height".tr().capitalizeWords,
                                                      ),
                                                      MySpacing.height(8),
                                                      TextFormField(
                                                        controller: heightController,
                                                        decoration: InputDecoration(
                                                            hintText: "Enter your height",
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
                                                                    .never),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            MySpacing.height(20),
                                            
                                            Row(
                                              children:[ 
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      MyText.labelMedium(
                                                        "Profession".trim().tr().capitalizeWords,
                                                      ),
                                                      MySpacing.height(8),
                                                      TextFormField(
                                                      controller: professionController,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter your Profession",
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
                                                                  .never),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                MySpacing.width(10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                  children: [
                                                    MyText.labelMedium(
                                                      "education".trim().tr().capitalizeWords,
                                                    ),
                                                    MySpacing.height(8),
                                                    TextFormField(
                                                      controller: educationController,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter your Education",
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
                                                                  .never),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ]
                                            ),
                                            MySpacing.height(16),
                                            Row(
                                              children:[
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      MyText.labelMedium(
                                                        "Location".trim().tr().capitalizeWords,
                                                      ),
                                                      MySpacing.height(8),
                                                      TextFormField(
                                                      controller: locationController,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter your Location",
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
                                                                  .never),
                                                      ),
                                                    ],
                                                  ),
                                                ), 
                                                
                                                MySpacing.width(10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                  children: [
                                                    MyText.labelMedium(
                                                      "Marital Status".trim().tr().capitalizeWords,
                                                    ),
                                                    MySpacing.height(8),
                                                    TextFormField(
                                                      controller: maritalStatusController,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter your Marital Status",
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
                                                                  .never),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ]
                                            ),
                                            MySpacing.height(20),
                                            Row(
                                              children:[ 
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      MyText.labelMedium(
                                                        "Religion".trim().tr().capitalizeWords,
                                                      ),
                                                      MySpacing.height(8),
                                                      TextFormField(
                                                      controller: religionController,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter your Religion",
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
                                                                  .never),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                MySpacing.width(10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                  children: [
                                                    MyText.labelMedium(
                                                      "Caste".trim().tr().capitalizeWords,
                                                    ),
                                                    MySpacing.height(8),
                                                    TextFormField(
                                                      controller: casteController,
                                                      decoration: InputDecoration(
                                                          hintText: "Enter your Caste",
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
                                                                  .never),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ]
                                            ),
                                            MySpacing.height(20),
                                            MyText.labelMedium(
                                              "About me".trim().tr().capitalizeWords,
                                            ),
                                            MySpacing.height(8),
                                            TextFormField(
                                              controller: aboutMeController,
                                              keyboardType: TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                  hintText: "About Me ...",
                                                  hintStyle:
                                                      MyTextStyle.bodySmall(xMuted: true),
                                                  border: outlineInputBorder,
                                                  enabledBorder: outlineInputBorder,
                                                  focusedBorder: focusedInputBorder,
                                                  contentPadding: MySpacing.all(16),
                                                  isCollapsed: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior.never),
                                            ),
                                            MySpacing.height(20),

                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: MyButton(
                                                onPressed: () async {
                                                  await controller.saveProfile(
                                                    ageController.text, locationController.text, professionController.text,
                                                    educationController.text, heightController.text, aboutMeController.text,
                                                    maritalStatusController.text, religionController.text, casteController.text
                                                  );
                                                  defaultTabController.animateTo(3);   
                                                  

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
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
    }

    MyFlexItem registrationScreen() {
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
                                                  "registration_details".tr().capitalizeWords,
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        MyText.labelMedium(
                                                          "Full name".tr().capitalizeWords,
                                                        ),
                                                        MySpacing.height(8),
                                                        TextFormField(
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
                                                                      .never),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              MySpacing.height(20),
                                              MyText.labelMedium(
                                                "email address".trim().tr().capitalizeWords,
                                              ),
                                              MySpacing.height(8),
                                              TextFormField(
                                                controller: emailController,
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                    hintText: "demo@gmail.com",
                                                    hintStyle:
                                                        MyTextStyle.bodySmall(xMuted: true),
                                                    border: outlineInputBorder,
                                                    enabledBorder: outlineInputBorder,
                                                    focusedBorder: focusedInputBorder,
                                                    prefixIcon: const Icon(
                                                      LucideIcons.mail,
                                                      size: 20,
                                                    ),
                                                    contentPadding: MySpacing.all(16),
                                                    isCollapsed: true,
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior.never),
                                              ),
                                              MySpacing.height(16),
                                              MyText.labelMedium(
                                                "password".tr().capitalizeWords,
                                              ),
                                              MySpacing.height(8),
                                              TextFormField(
                                                controller: passwordController,
                                                keyboardType: TextInputType.emailAddress,
                                                obscureText: !controller.showPassword,
                                                decoration: InputDecoration(
                                                    hintText: "Password",
                                                    hintStyle:
                                                        MyTextStyle.bodySmall(xMuted: true),
                                                    border: outlineInputBorder,
                                                    enabledBorder: outlineInputBorder,
                                                    focusedBorder: focusedInputBorder,
                                                    prefixIcon: const Icon(
                                                      LucideIcons.lock,
                                                      size: 20,
                                                    ),
                                                    suffixIcon: InkWell(
                                                      onTap:
                                                          controller.onChangeShowPassword,
                                                      child: Icon(
                                                        controller.showPassword
                                                            ? LucideIcons.eye
                                                            : LucideIcons.eyeOff,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    contentPadding: MySpacing.all(16),
                                                    isCollapsed: true,
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior.never),
                                              ),
                                              MySpacing.height(20),
                                              Row(
                                                children: [
                                                  MyText.labelLarge("gender".capitalizeWords),
                                                  MySpacing.width(16),
                                                  Expanded(
                                                    child: Wrap(
                                                        spacing: 16,
                                                        children: Gender.values
                                                            .map(
                                                              (gender) => InkWell(
                                                                onTap: () => controller
                                                                    .onChangeGender(gender),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize.min,
                                                                  children: [
                                                                    Radio<Gender>(
                                                                      value: gender,
                                                                      activeColor:
                                                                          contentTheme
                                                                              .primary,
                                                                      groupValue: controller
                                                                          .selectedGender,
                                                                      onChanged: controller
                                                                          .onChangeGender,
                                                                      visualDensity:
                                                                          getCompactDensity,
                                                                      materialTapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                    ),
                                                                    MySpacing.width(8),
                                                                    MyText.labelMedium(
                                                                        gender.name
                                                                            .capitalize!)
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                            .toList()),
                                                  )
                                                ],
                                              ),
                                              MySpacing.height(8),
                                              MyText.labelMedium(
                                                "Mother Tongue".trim().tr().capitalizeWords,
                                              ),
                                              MySpacing.height(8),
                                              TextFormField(
                                                controller: motherTongueController,
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                    hintText: "Enter your Mother Tongue",
                                                    hintStyle:
                                                        MyTextStyle.bodySmall(xMuted: true),
                                                    border: outlineInputBorder,
                                                    enabledBorder: outlineInputBorder,
                                                    focusedBorder: focusedInputBorder,
                                                    
                                                    contentPadding: MySpacing.all(16),
                                                    isCollapsed: true,
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior.never),
                                              ),
                                              MySpacing.height(8),   
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: MyButton(
                                                  onPressed: () async {
                                                    await controller.createUser(emailController.text,passwordController.text).then(
                                                      (value) => controller.saveUserData(nameController.text, emailController.text,
                                                        motherTongueController.text));
                                                    defaultTabController.animateTo(1      );
                                                    
                                                    setState(() {
                                                      registrationdone = true;
                                                    });
                                                  },
                                                  elevation: 0, 
                                                  padding: MySpacing.xy(20, 16),
                                                  backgroundColor: contentTheme.primary,
                                                  borderRadiusAll:
                                                      AppStyle.buttonRadius.medium,
                                                  child: MyText.bodySmall(
                                                    'Register'.tr().capitalizeWords,
                                                    color: contentTheme.onPrimary,
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



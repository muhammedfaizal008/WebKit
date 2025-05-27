import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_member_controller.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_preferences_controller.dart';
import 'package:webkit/controller/apps/members/link_phone_controller.dart';
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
import 'package:webkit/views/apps/members/add_member/tabs/AddFamilyLifestyleInfo.dart';
import 'package:webkit/views/apps/members/add_member/tabs/AddProfileScreen.dart';
import 'package:webkit/views/apps/members/add_member/tabs/AddPartnerPreferences.dart';
import 'package:webkit/views/apps/members/add_member/tabs/AddPhoneRegistrationScreen.dart';
import 'package:webkit/views/apps/members/add_member/tabs/AddReligiousInformation.dart';
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
  late AddPreferencesController addPreferencesController;
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
  final TextEditingController religionController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController motherTongueController = TextEditingController();
  final TextEditingController agePartnerController = TextEditingController();
  final TextEditingController heightPartnerController = TextEditingController();
  final TextEditingController locationPartnerController =TextEditingController();
  final TextEditingController professionPartnerController =TextEditingController();
  final TextEditingController educationPartnerController =TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController noOfBrothersController = TextEditingController();
  final TextEditingController noOfSistersController = TextEditingController();
  final TextEditingController fathersOccupationController = TextEditingController();
  final TextEditingController mothersOccupationController = TextEditingController();
  final TextEditingController motherTonguePartnerController = TextEditingController();
  final TextEditingController castePartnerController = TextEditingController();
  final TextEditingController starPartnerController = TextEditingController();

  bool registrationdone = false;

  @override
  void initState() {
    controller = Get.put(AddMemberController());
    linkPhoneController = Get.put(LinkPhoneController());
    addPreferencesController = Get.put(AddPreferencesController());
    addPreferencesController.fetchLocations();
    defaultTabController =
        TabController(length: 6
        , vsync: this, initialIndex: currentTabIndex);
    defaultTabController.addListener(() {
      if (defaultTabController.index != currentTabIndex) {
        setState(() {
          currentTabIndex = defaultTabController.index;
        });
      }
    });
    controller.fetchLanguages();
    controller.fetchProfileNames();
    controller.fetchSubscription();
    controller.fetchMaritalStatus();
    controller.fetchReligions();
    controller.fetchLanguages();
    controller.fetchPhysicalStatus();
    controller.fetchZodiacSigns();
    controller.fetchStars();
    controller.fetchEducationCategories();
    controller.fetchProfessionCategories();
    controller.fetchHoroscopeMatch();
    controller.fetchFamilyValues();
    controller.fetchFamilyStatus();
    controller.fetchFamilyType();
    controller.fetchDrinkingHabits();
    controller.fetchSmokingHabits();
    controller.fetchEatingHabits();
    controller.fetchCountry();
    controller.fetchCitizenship();
    addPreferencesController.fetchProfessions();
    addPreferencesController.fetchEducation();
    addPreferencesController.fetchMotherTongues(); 
    addPreferencesController.fetchAnnualIncome();
    addPreferencesController.fetchReligions();
    addPreferencesController.fetchStars();
    addPreferencesController.fetchEatingHabits();
    addPreferencesController.fetchSmokingHabits();
    addPreferencesController.fetchDrinkingHabits();
    addPreferencesController.fetchCitizenship();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final errorTextStyle = MyTextStyle.bodySmall(fontSize: 10, xMuted: true);
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
                    "Add Customers".tr().capitalizeWords,
                    fontSize: 18,
                    fontWeight: 600,
                  ),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: 'All Customers'),
                      MyBreadcrumbItem(name: 'Add Customers', active: true),
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
                        children: [
                          MyText.titleMedium(
                            "Add Customers Details".tr().capitalizeWords,
                            fontWeight: 600,
                          ),
                          const Divider(height: 28),
                          TabBar(
                            controller: defaultTabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [ 
                              Tab(
                                icon: MyText.bodySmall(
                                  "Registration".tr(),
                                  fontWeight: currentTabIndex == 0 ? 600 : 500,
                                  color: currentTabIndex == 0
                                      ? contentTheme.primary
                                      : null,
                                ),
                              ),
                              Tab(
                                icon: MyText.bodySmall(
                                  "Phone Registration".tr(),
                                  fontWeight: currentTabIndex == 1 ? 600 : 500,
                                  color: currentTabIndex == 1
                                      ? contentTheme.primary
                                      : null,
                                ),
                              ),
                              Tab(
                                icon: MyText.bodySmall(
                                  "profile".tr(),
                                  fontWeight: currentTabIndex == 2 ? 600 : 500,
                                  color: currentTabIndex == 2
                                      ? contentTheme.primary
                                      : null,
                                ),
                              ),
                              Tab(
                                icon: MyText.bodySmall(
                                  "Religious Information".tr(),
                                  fontWeight: currentTabIndex == 3 ? 600 : 500,
                                  color: currentTabIndex == 3
                                      ? contentTheme.primary
                                      : null,
                                ),
                              ),
                              Tab(
                                icon: MyText.bodySmall(
                                  "Family and Life Style".tr(),
                                  fontWeight: currentTabIndex == 4 ? 600 : 500,
                                  color: currentTabIndex == 4
                                      ? contentTheme.primary
                                      : null,
                                ),
                              ),
                              Tab(
                                icon: MyText.bodySmall(
                                  "Partner Preferences".tr(),
                                  fontWeight: currentTabIndex == 4 ? 600 : 500,
                                  color: currentTabIndex == 5
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
                                  PhoneRegistrationScreen(
                                      phoneNumberController:
                                          phoneNumberController,
                                      outlineInputBorder: outlineInputBorder,
                                      focusedInputBorder: focusedInputBorder,
                                      otpController: otpController,
                                      context: context,
                                      contentTheme: contentTheme,
                                      defaultTabController:
                                          defaultTabController),
                                  AddProfileScreen(
                                     formkey:formKey,
                                      weightController: weightController,
                                      context: context,
                                      controller: controller,
                                      dobController: dobController,
                                      ageController: ageController,
                                      outlineInputBorder: outlineInputBorder,
                                      focusedInputBorder: focusedInputBorder,
                                      heightController: heightController,
                                      professionController:
                                          professionController,
                                      educationController: educationController,
                                      locationController: locationController,
                                      casteController: casteController,
                                      aboutMeController: aboutMeController,
                                      religionController: religionController,
                                      defaultTabController:
                                          defaultTabController,
                                      contentTheme: contentTheme),

                                  AddReligiousInformation(
                                      controller: controller,
                                      casteController: casteController,
                                      outlineInputBorder: outlineInputBorder,
                                      focusedInputBorder: focusedInputBorder,
                                      errorTextStyle: errorTextStyle,
                                      contentTheme: contentTheme,
                                      defaultTabController:
                                          defaultTabController),
                                  AddFamilyLifestyleInfo(agePartnerController: ageController,controller: controller, noOfBrothersController: noOfBrothersController, outlineInputBorder: outlineInputBorder, focusedInputBorder: focusedInputBorder, noOfSistersController: noOfSistersController, fathersOccupationController: fathersOccupationController, mothersOccupationController: mothersOccupationController, formKey: formKey, contentTheme: contentTheme, defaultTabController: defaultTabController),
                                  AddPartnerPreferences(castePartnerController: castePartnerController,starPartnerController: starPartnerController,
                                    heightPartnerController: heightPartnerController,motherTonguePartnerController: motherTonguePartnerController,
                                  agePartnerController:agePartnerController,outlineInputBorder: outlineInputBorder,
                                      focusedInputBorder: focusedInputBorder,locationPartnerController:locationPartnerController,professionPartnerController:professionPartnerController,
                                      educationPartnerController:educationPartnerController,formKey: formKey,controller: controller,contentTheme: contentTheme),
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
      ),
    );
  }

  MyFlexItem registrationScreen() {
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
                        "registration_details".tr().capitalizeWords,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
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
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      errorStyle: TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(16),
                      MyText.labelMedium(
                        "email address".trim().tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(fontSize: 12),
                            hintText: "demo@gmail.com",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            prefixIcon: const Icon(
                              LucideIcons.mail,
                              size: 20,
                            ),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                      MySpacing.height(16),
                      MyText.labelMedium(
                        "password".tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: !controller.showPassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            prefixIcon: const Icon(
                              LucideIcons.lock,
                              size: 20,
                            ),
                            suffixIcon: InkWell(
                              onTap: controller.onChangeShowPassword,
                              child: Icon(
                                controller.showPassword
                                    ? LucideIcons.eye
                                    : LucideIcons.eyeOff,
                                size: 20,
                              ),
                            ),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 12)),
                      ),
                      MySpacing.height(16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                    "Mother Tongue".tr().capitalizeWords),
                                MySpacing.height(8),
                                PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return controller.languages.map((language) {
                                      return PopupMenuItem<String>(
                                        value: language.name,
                                        height: 32,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.6,
                                          child: MyText.bodySmall(
                                            language.name,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 0),
                                  onSelected: controller.onLanguageSelectedSize,
                                  color: theme.cardTheme.color,
                                  child: MyContainer.bordered(
                                     paddingAll: 10,
                                                border: Border.all(
                                                  color: controller.languageError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                                ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.bodySmall(
                                          controller.language.isEmpty
                                              ? "Select Mother Tongue"
                                              : controller.language,
                                          color:  theme.colorScheme.onSurface,
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
                                if (controller.languageError!= null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    controller.languageError !,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
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
                                MyText.labelLarge("For whom ".tr().capitalizeWords),
                                MySpacing.height(8),
                                PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return controller.profileNames
                                        .map((behavior) {
                                      return PopupMenuItem(
                                        value: behavior,
                                        height: 32,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.8,
                                          child: MyText.bodySmall(
                                            behavior,
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: 600,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 0),
                                  onSelected: controller.onSelectedSize2,
                                  color: theme.cardTheme.color,
                                  child: MyContainer.bordered(
                                    paddingAll: 10,
                                    border: Border.all(
                                      color: controller.selectProperties2Error==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        MyText.bodySmall(
                                          controller.selectProperties2.isEmpty?"Select for whom"
                                              : controller.selectProperties2,
                                          color: theme.colorScheme.onSurface,
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
                                if (controller.selectProperties2Error!= null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    controller.selectProperties2Error !,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
                                  ),
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
                          MyText.labelLarge(
                              "Subscription Type ".tr().capitalizeWords),
                          MySpacing.height(8),
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return controller.Subscription.map((behavior) {
                                return PopupMenuItem(
                                  value: behavior,
                                  height: 32,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: MyText.bodySmall(
                                      behavior,
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: 600,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            position: PopupMenuPosition.under,
                            offset: const Offset(0, 0),
                            onSelected: controller.onSelectedSubscription,
                            color: theme.cardTheme.color,
                            child: MyContainer.bordered(
                               paddingAll: 10,
                                border: Border.all(
                                  color: controller.subscriptionError==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.bodySmall(
                                    controller.subscription.isEmpty
                                        ? "Select Subscription Type"
                                        : controller.subscription,
                                    color: theme.colorScheme.onSurface,
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
                          if (controller.subscriptionError  != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                controller.subscriptionError !,
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      MySpacing.height(8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MyButton(
                          onPressed: () async {
                            // Reset all error flags before validation
                
                            
                
                            // Trigger UI update for showing error labels
                            controller.update();
                
                            // Perform all validation checks
                            final registraionValid =
                                controller.registrationValidate();
                            final formValid = formKey.currentState!.validate();
                
                            print("registraionValid: $registraionValid");
                            print("formValid: $formValid");
                            if (registraionValid && formValid) {
                              controller
                                  .createUser(
                                      emailController.text, passwordController.text)
                                  .then((value) => controller.saveUserData(
                                      nameController.text, emailController.text));
                              defaultTabController.animateTo(1);
                
                              setState(() {
                                registrationdone = true;
                              });
                            }
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: contentTheme.primary,
                          borderRadiusAll: AppStyle.buttonRadius.medium,
                          child: MyText.bodySmall(
                            'Register'.tr().capitalizeWords,
                            color: contentTheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


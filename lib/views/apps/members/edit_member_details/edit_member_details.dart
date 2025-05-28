
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:webkit/controller/apps/members/edit_members_controller.dart';
import 'package:webkit/controller/apps/members/profile_attributes/annual_income_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
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
import 'package:webkit/views/apps/members/edit_member_details/tabs/PartnerPreferences.dart';
import 'package:webkit/views/apps/members/edit_member_details/tabs/basicDetails.dart';
import 'package:webkit/views/apps/members/edit_member_details/tabs/personal_details.dart';
import 'package:webkit/views/apps/members/edit_member_details/tabs/religious_info.dart';
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
  late String uid="";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController forwhomController = TextEditingController();
  final TextEditingController subscriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController stateController=TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController professionInDetailController=TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController educationInDetailController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController motherTongueController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final TextEditingController noOfBrothersController = TextEditingController();
  final TextEditingController noOfSistersController = TextEditingController();
  final TextEditingController fathersOccupationController = TextEditingController();
  final TextEditingController mothersOccupationController = TextEditingController();
  
  final TextEditingController annualIncomeController=TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController physicalStatusController = TextEditingController();
  final TextEditingController citizenshipController=TextEditingController();

  final TextEditingController religionController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController starController=TextEditingController();
  final TextEditingController zodiacSignController=TextEditingController();
  final TextEditingController horoscopeController=TextEditingController();
  final TextEditingController chovvaDoshamController =TextEditingController(); 

  final TextEditingController agePartnerController = TextEditingController();
  final TextEditingController citizenShipPartnerController = TextEditingController();
  final TextEditingController locationPartnerController = TextEditingController();
  final TextEditingController statePartnerController = TextEditingController();
  final TextEditingController professionPartnerController = TextEditingController();
  final TextEditingController educationPartnerController = TextEditingController();
  final TextEditingController heightPartnerController = TextEditingController();
  final TextEditingController motherTonguePartnerController = TextEditingController();
  final TextEditingController maritalStatusPartnerController = TextEditingController();
  final TextEditingController incomePartnerController = TextEditingController();
  final TextEditingController religionPartnerController = TextEditingController();
  final TextEditingController castePartnerController = TextEditingController();
  final TextEditingController starPartnerController = TextEditingController();
  final TextEditingController chovvvadoshamPartnerController = TextEditingController();
  final TextEditingController eatingPartnerController = TextEditingController();
  final TextEditingController smokingPartnerController = TextEditingController();
  final TextEditingController drinkingPartnerController = TextEditingController();

  
  

  
  
   
  
  @override
      void initState() {
        super.initState();
        controller = Get.put(EditMembersController());
        defaultTabController =
            TabController(length: 4, vsync: this, initialIndex: currentTabIndex);
        
        final Map<String, dynamic>? userMap = Get.arguments;
        if (userMap != null) {
          final user = UserModel.fromMap(userMap);
          _populateControllers(user);
        } else {
          print('Get.arguments is null');
          Get.back(); // or handle appropriately
        }

      }

      void _populateControllers(UserModel user) {
        uid = user.uid;
        nameController.text = user.fullName ;
        ageController.text = user.age.toString() ;
        forwhomController.text=user.forWhom??"";
        subscriptionController.text=user.subscription??"";
        locationController.text = user.country;
        stateController.text=user.state??"";
        professionController.text = user.professionCategory ;
        professionInDetailController.text =user.professionInDetail??"";
        educationController.text = user.educationCategory ;
        educationInDetailController.text = user.educationInDetail??"" ;
        heightController.text = user.height.toString() ;
        weightController.text=user.weight??"";
        dobController.text=user.dob??"";
        citizenshipController.text=user.citizenship??"";
        religionController.text = user.religion ;
        casteController.text = user.caste ;
        zodiacSignController.text=user.zodiacSign;
        starController.text=user.star;
        chovvaDoshamController.text=user.chovvaDosham;
        horoscopeController.text=user.horoscope;
        aboutMeController.text = user.aboutMe ;
        phoneNumberController.text = user.phoneNumber ;
        maritalStatusController.text = user.maritalStatus ;
        physicalStatusController.text=user.physicalStatus??"";
        motherTongueController.text = user.language ;

        agePartnerController.text = user.partnerAge?.toString()??"" ;
        citizenShipPartnerController.text=user.partnerCitizenship.toString();
        locationPartnerController.text = user.partnerCountry ;
        statePartnerController.text=user.partnerStates.toString();
        professionPartnerController.text = user.partnerProfessions.toString() ;
        educationPartnerController.text = user.partnerEducationList.toString() ;
        heightPartnerController.text=user.partnersHeight;
        motherTonguePartnerController.text=user.partnerMotherTongue.toString();
        maritalStatusPartnerController.text=user.partnerMaritalStatus.toString();
        incomePartnerController.text=user.partnerAnnualIncome;
        religionPartnerController.text=user.partnerReligion;
        castePartnerController.text=user.partnerCastes.toString();
        starPartnerController.text=user.partnerStars.toString();
        chovvvadoshamPartnerController.text=user.partnerChovvaDosham;
        eatingPartnerController.text=user.partnerEatingHabits.toString();
        smokingPartnerController.text=user.partnerSmokingHabits.toString();
        drinkingPartnerController.text=user.partnerDrinkingHabits.toString();

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
                          "edit Details".tr().capitalizeWords,
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
                                "Religious Details".tr(),
                                fontWeight: currentTabIndex == 2 ? 600 : 500,
                                color: currentTabIndex == 2
                                    ? contentTheme.primary
                                    : null,
                              ),
                            ),
                            Tab(
                              icon: MyText.bodyMedium(
                                "Partner Preferences".tr(),
                                fontWeight: currentTabIndex == 3 ? 600 : 500,
                                color: currentTabIndex == 3
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
                                    uid: uid,
                                    subsriptionController: subscriptionController,
                                    forwhomController: forwhomController,
                                    motherTongueController: motherTongueController,
                                    weightController: weightController,
                                    stateController: stateController,
                                    nameController: nameController,
                                    outlineInputBorder: outlineInputBorder,
                                    focusedInputBorder: focusedInputBorder,
                                    ageController: ageController,
                                    locationController: locationController,
                                    professionController: professionController,
                                    educationController: educationController,
                                    heightController: heightController,
                                    aboutMeController: aboutMeController,
                                    formKey: formKey,
                                    defaultTabController: defaultTabController,
                                    contentTheme: contentTheme),
                                PersonalDetails(
                                  dobController: dobController,
                                  citizenshipController: citizenshipController,
                                  maritalStatusController: maritalStatusController,
                                  physicalStatusController: physicalStatusController,
                                  educationInDetailController: educationInDetailController,
                                  professionInDetailController: professionInDetailController,
                                  focusedInputBorder: focusedInputBorder,
                                    uid: uid,
                                    theme: theme,
                                    outlineInputBorder: outlineInputBorder,

                                    professionController: professionController,
                                    educationController: educationController,
                                    formKey: formKey,
                                    defaultTabController: defaultTabController,
                                    contentTheme: contentTheme),
                                  ReligiousInfo(religionController: religionController, outlineInputBorder: outlineInputBorder, focusedInputBorder: focusedInputBorder, casteController: casteController, zodiacSignController: zodiacSignController, starController: starController, chovvaDoshamController: chovvaDoshamController, horoscopeController: horoscopeController, formKey: formKey, defaultTabController: defaultTabController, contentTheme: contentTheme),  
                                PartnerPreferences(
                                    uid: uid,
                                    ageController: agePartnerController,casteController: castePartnerController,citizenshipController: citizenShipPartnerController,countryController: locationPartnerController,doshamController: chovvvadoshamPartnerController,educationController: educationPartnerController,heightController: heightPartnerController,incomeController: incomePartnerController,maritalStatusController: maritalStatusPartnerController,
                                    motherTongueController: motherTonguePartnerController,professionController: professionPartnerController,religionController: religionPartnerController,starController: starPartnerController,stateController: statePartnerController,
                                    eatingHabitController: eatingPartnerController,drinkingHabitController: drinkingPartnerController,smokingHabitController: smokingPartnerController,
                                    outlineInputBorder: outlineInputBorder,
                                    focusedInputBorder: focusedInputBorder,
                                    formkey: formKey,
                                    defaultTabController: defaultTabController,)
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


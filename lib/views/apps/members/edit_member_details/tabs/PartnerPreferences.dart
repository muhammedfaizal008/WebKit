  import 'package:flutter/material.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
  import 'package:get/get_state_manager/src/simple/get_state.dart';
  import 'package:lucide_icons/lucide_icons.dart';
  import 'package:webkit/controller/apps/members/edit_members_controller/edit_members_controller.dart';
  import 'package:webkit/helpers/extensions/extensions.dart';
  import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
  import 'package:webkit/helpers/widgets/my_container.dart';

  import 'package:webkit/helpers/widgets/my_spacing.dart';
  import 'package:webkit/helpers/widgets/my_text.dart';
  import 'package:webkit/helpers/widgets/my_text_style.dart';

    class PartnerPreferences extends StatefulWidget {
    final OutlineInputBorder outlineInputBorder;
    final OutlineInputBorder focusedInputBorder;
    final String uid;
    final GlobalKey formkey;
    final TabController defaultTabController;
    final ContentTheme contentTheme;

    final TextEditingController ageController;
    final TextEditingController heightController;
    final TextEditingController citizenshipController;
    final TextEditingController stateController;
    final TextEditingController countryController;
    final TextEditingController professionController;
    final TextEditingController educationController;
    final TextEditingController motherTongueController;
    final TextEditingController casteController;
    final TextEditingController starController;
    final TextEditingController religionController;
    final TextEditingController maritalStatusController;
    final TextEditingController incomeController;
    final TextEditingController doshamController;
    final TextEditingController eatingHabitController;
    final TextEditingController smokingHabitController;
    final TextEditingController drinkingHabitController;


    const PartnerPreferences({
      super.key,
      required this.uid,
      required this.formkey,
      required this.contentTheme,
      required this.outlineInputBorder,
      required this.focusedInputBorder,
      required this.defaultTabController,
      required this.ageController,
      required this.heightController,
      required this.citizenshipController,
      required this.stateController,
      required this.countryController,
      required this.professionController,
      required this.educationController,
      required this.motherTongueController,
      required this.casteController,
      required this.starController,
      required this.religionController,
      required this.maritalStatusController,
      required this.incomeController,
      required this.doshamController,
      required this.eatingHabitController,
      required this.smokingHabitController,
      required this.drinkingHabitController,
    });

    @override
    State<PartnerPreferences> createState() => _PartnerPreferencesState();
  }


    class _PartnerPreferencesState extends State<PartnerPreferences> {
    late EditMembersController controller;
    final OutlineInputBorder focusedInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.blue,
        width: 1.5,
      ),
    );
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
          color: Colors.white,
    context: context,
    position: position,
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
      final GlobalKey _partnerCitizenshipKey=GlobalKey();
      final GlobalKey _partnerCountryKey=GlobalKey();
      final GlobalKey _partnerReligionKey=GlobalKey();
      final GlobalKey _partnerMaritalStatusKey =GlobalKey();
      final GlobalKey _partnerIncomeKey =GlobalKey();
      final GlobalKey _partnerDoshamKey =GlobalKey();
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
                    "partner Preferences".tr().capitalizeWords,
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
                        MyText.labelMedium("Partner Age".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter partner age';
                            }
                            return null;
                          },
                          controller: widget.ageController,
                          decoration: InputDecoration(
                            hintText: "25-30",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
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
                        MyText.labelMedium("Partner Height".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter partner height';
                            }
                            return null;
                          },
                          controller: widget.heightController,
                          decoration: InputDecoration(
                            hintText: "120-200",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(16),
          
              // Citizenship and State Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Country".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _partnerCountryKey,
                            readOnly: true,
                            controller: widget.countryController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerCountryKey,
                              items: controller.countries,
                              onSelected: (country) {
                                controller.setSelectedPartnerCountry(country);
                                widget.countryController.text = country;
                              },
                              controller: widget.countryController,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select partner country",
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
                        MyText.labelMedium("Partner State".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select state';
                            }
                            return null;
                          },
                          controller: widget.stateController,
                          decoration: InputDecoration(
                            hintText: "Select state",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showStatePopup(context,controller,widget.stateController),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(16),
          
              // Country and Religion Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Citizenship".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select country';
                            }
                            return null;
                          },
                          controller: widget.citizenshipController,
                          decoration: InputDecoration(
                            hintText: "Select country",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showCitizenshipPopup(context,controller,widget.citizenshipController),
                        ),
                      ],
                    ),
                  ),
                  
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Mother Tongue".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select mother tongue';
                            }
                            return null;
                          },
                          controller: widget.motherTongueController,
                          decoration: InputDecoration(
                            hintText: "Select mother tongue",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showMotherTonguePopup(context,controller,widget.motherTongueController),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
              MySpacing.height(16),
          
              // Profession and Education Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Profession".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select profession';
                            }
                            return null;
                          },
                          controller: widget.professionController,
                          decoration: InputDecoration(
                            hintText: "Select profession",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showProfessionPopup(context,controller,widget.professionController),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Education".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select education';
                            }
                            return null;
                          },
                          controller: widget.educationController,
                          decoration: InputDecoration(
                            hintText: "Select education",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showEducationPopup(
                            context: context,controller: controller,educationPartnerController: widget.educationController
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(16),
          
              // Marital Status and Annual Income Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Marital Status".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _partnerMaritalStatusKey,
                            readOnly: true,
                            controller: widget.maritalStatusController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerMaritalStatusKey,
                              items: controller.maritalStatuses,
                              onSelected: controller.setSelectedPartnerMaritalStatus,
                              controller: widget.maritalStatusController,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select partner Marital Status",
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
                        MyText.labelMedium("Annual Income".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _partnerIncomeKey,
                            readOnly: true,
                            controller: widget.incomeController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerIncomeKey,
                              items: controller.annualIncomes,
                              onSelected: controller.setSelectedPartnerIncome,
                              controller: widget.incomeController,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select partner Income",
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
          
              // Mother Tongue and Caste Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Religion".tr().capitalizeWords),
                        MySpacing.height(8),
                        GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _partnerReligionKey,
                            readOnly: true,
                            controller: widget.religionController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerReligionKey,
                              items: controller.religions,
                              onSelected: controller.setSelectedPartnerReligion,
                              controller: widget.religionController,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select religion",
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
                        MyText.labelMedium("Partner Caste".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select caste';
                            }
                            return null;
                          },
                          controller: widget.casteController,
                          decoration: InputDecoration(
                            hintText: "Select caste",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showCastePopup(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(16),
          
              // Star and Dosham Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Partner Star".tr().capitalizeWords),
                        MySpacing.height(8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select star';
                            }
                            return null;
                          },
                          controller: widget.starController,
                          decoration: InputDecoration(
                            hintText: "Select star",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: widget.outlineInputBorder,
                            enabledBorder: widget.outlineInputBorder,
                            focusedBorder: widget.focusedInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: TextStyle(fontSize: 10),
                          ),
                          readOnly: true,
                          onTap: () => _showstarPopup(context,controller,widget.starController),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium("Chovva Dosham".tr().capitalizeWords),
                          MySpacing.height(8),
                          GetBuilder<EditMembersController>(
                          builder: (controller) {
                          return TextFormField(
                            key: _partnerDoshamKey,
                            readOnly: true,
                            controller: widget.doshamController,
                            onTap: () => _showSelectionMenu(
                              key: _partnerDoshamKey,
                              items: ["Matters","Doesn't Matters"],
                              onSelected: controller.setSelectedPartnerdosham,
                              controller: widget.doshamController,
                            ),
                            decoration: InputDecoration(
                              hintText: "Select Chovvadosham",
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
                      ),
                        ],
                      ),
                    ),
                ],
              ),
              MySpacing.height(20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      MyText.labelMedium("Eating Habit".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select eating habit';
                        }
                        return null;
                        },
                        controller: widget.eatingHabitController,
                        decoration: InputDecoration(
                        hintText: "Select eating habit",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: widget.focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorStyle: TextStyle(fontSize: 10),
                        ),
                        readOnly: true,
                        onTap: () => _showEatinghabitsPopup(context,controller,widget.eatingHabitController),
                      ),
                      ],
                    ),
                    ),
                    MySpacing.width(16),
                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      MyText.labelMedium("Smoking Habit".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select smoking habit';
                        }
                        return null;
                        },
                        controller: widget.smokingHabitController,
                        decoration: InputDecoration(
                        hintText: "Select smoking habit",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: widget.focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorStyle: TextStyle(fontSize: 10),
                        ),
                        readOnly: true,
                        onTap: () => _showSmokinghabitsPopup(context,controller,widget.smokingHabitController),
                      ),
                      ],
                    ),
                    ),
                    MySpacing.width(16),
                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      MyText.labelMedium("Drinking Habit".tr().capitalizeWords),
                      MySpacing.height(8),
                      TextFormField(
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select drinking habit';
                        }
                        return null;
                        },
                        controller: widget.drinkingHabitController,
                        decoration: InputDecoration(
                        hintText: "Select drinking habit",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: widget.focusedInputBorder,
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorStyle: TextStyle(fontSize: 10),
                        ),
                        readOnly: true,
                        onTap: () => _showDrinkinghabitsPopup(context,controller,widget.drinkingHabitController),
                      ),
                      ],
                    ),
                    ),
                ],
              ),
              MySpacing.height(10),
            Align(  
              alignment: Alignment.centerRight,
              child: MyButton(
                onPressed: () async {                 
                    controller.savePartnerPreferences(uid: widget.uid,partnerDosham: widget.doshamController.text,partnerReligion: widget.religionController.text,
                    annualIncome: widget.incomeController.text, citizenShips: [widget.citizenshipController.text],partnerDrinkingHabits: [widget.drinkingHabitController.text],
                    partnerEatingHabits: [widget.eatingHabitController.text],partnerEducation: [widget.educationController.text],partnerHeight: widget.heightController.text,
                    partnerMotherTongue: [widget.motherTongueController.text],partnerProfession: [widget.professionController.text],partnerSmokingHabits: [widget.smokingHabitController.text]
                    ,partnerStars: [widget.starController.text],partnersCastes: [widget.casteController.text],partnersCountry: widget.countryController.text,
                    partnersage: widget.ageController.text,partnersmaritalStatus: widget.maritalStatusController.text,states: [widget.stateController.text],
                    );
                    Get.offNamedUntil('/user/free_members', (route) => false);  
                    },
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor:widget.contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: MyText.bodySmall(
                  'Save'.tr().capitalizeWords,
                  color: widget.contentTheme.onPrimary,
                ),
              ),
            ),
            ],
          ),
        ),
      );
    }

    // Popup methods (to be implemented)
    void _showStatePopup(
      BuildContext context, 
      EditMembersController controller,
      TextEditingController StateController,
    ) async {
      await _showMultiSelectPopup<String>(
        context: context,
        controller: controller,
        title: 'Select state',
        allItems: controller.states.map((states) => states).toList(),
        selectedItems: controller.selectedPartnerStates,
        tempSelectedItems: controller.tempSelectedPartnerStates, 
        textController: StateController,
        itemToString: (item) => item,
      );
    }
    void _showCitizenshipPopup(
      BuildContext context, 
      EditMembersController controller,
      TextEditingController CitizenPartnerController) async {
      await _showMultiSelectPopup<String>(
      context: context,
      controller: controller,
      title: 'Select Citizenship',
      allItems: controller.citizenship.map((citizenship) => citizenship).toList(),
      selectedItems: controller.selectedPartnerCitizenShip,
      tempSelectedItems: controller.tempSelectedProfessions,
      textController: CitizenPartnerController,
      itemToString: (item) => item,
    );
    }
    Future<void> _showProfessionPopup(
    BuildContext context, 
    EditMembersController controller,
    TextEditingController professionPartnerController,
  ) async {
    await _showMultiSelectPopup<String>(
      context: context,
      controller: controller,
      title: 'Select Professions',
      allItems: controller.professions.map((prof) => prof).toList(),
      selectedItems: controller.selectedProfessions,
      tempSelectedItems: controller.tempSelectedProfessions,
      textController: professionPartnerController,
      itemToString: (item) => item,
    );
  }
    Future<void>_showEducationPopup({
    required  BuildContext context, 
    required EditMembersController controller,
    required TextEditingController educationPartnerController,}
    ) async {
      await _showMultiSelectPopup<String>(
      context: context,
      controller: controller,
      title: 'Select Education',
      allItems: controller.educations.map((edu) => edu).toList(),
      selectedItems: controller.selectedEducation,
      tempSelectedItems: controller.tempSelectedEducation     ,
      textController: educationPartnerController,
      itemToString: (item) => item,
    );
    }
    Future<void> _showMotherTonguePopup(
    BuildContext context, 
    EditMembersController controller,
    TextEditingController motherTonguePartnerController,
  ) async {
    await _showMultiSelectPopup<String>(
      context: context,
      controller: controller,
      title: 'Select Mother Tongues',
      allItems: ['Any', ...controller.languages.map((lang) => lang)],
      selectedItems: controller.selectedMotherTongues,
      tempSelectedItems: controller.tempSelectedMotherTongues,
      textController: motherTonguePartnerController,
      itemToString: (item) => item,
    );
  }
    void _showCastePopup() async {
  // Check if religion is selected first
  if (controller.selectedPartnerReligion.value.isEmpty) {
    Get.snackbar('Info', 'Please select a religion first');
    return;
  }

  // Show loading if castes are being fetched
  if (controller.isLoading.value) {
    return;
  }

  // Show caste selection popup
  await _showMultiSelectPopup<String>(
    context: context,
    controller: controller,
    title: 'Select Caste',
    allItems: controller.castes,
    selectedItems: controller.selectedPartnerCastes,
    tempSelectedItems: controller.tempSelectedPartnerCastes,
    textController: widget.casteController,
    itemToString: (item) => item,
  );
}

  
  Future<void> _showSmokinghabitsPopup(
    BuildContext context, 
    EditMembersController controller,
    TextEditingController smokingHabitsController,
  ) async {
    await _showMultiSelectPopup<String>(
      context: context,
      controller: controller,
      title: 'Select Smoking Habits',
      allItems: controller.smokingHabits.map((habit) => habit).toList(),
      selectedItems: controller.selectedSmokingHabits,
      tempSelectedItems: controller.tempSelectedSmokingHabits, 
      textController: smokingHabitsController,
      itemToString: (item) => item,
    );
  }

  Future<void> _showDrinkinghabitsPopup(
    BuildContext context, 
    EditMembersController controller,
    TextEditingController DrinkingHabitsController,
  ) async {
    await _showMultiSelectPopup<String>(
      context: context,
      controller: controller,
      title: 'Select Drinking Habits',
      allItems: controller.drinkingHabits.map((habit) => habit).toList(),
      selectedItems: controller.selectedDrinkingHabits,
      tempSelectedItems: controller.tempSelectedDrinkingHabits, 
      textController: DrinkingHabitsController,
      itemToString: (item) => item,
    );
  }


  Future<void> _showEatinghabitsPopup(
    BuildContext context, 
    EditMembersController controller,
    TextEditingController eatingHabitsController,
  ) async {
    await _showMultiSelectPopup<String>(
      context: context,
      controller: controller,
      title: 'Select Eating Habits',
      allItems: ['Any', ...controller.eatingHabits.map((habit) => habit)],
      selectedItems: controller.selectedeatingHabits,
      tempSelectedItems: controller.tempSelectedEatingHabits,
      textController: eatingHabitsController,
      itemToString: (item) => item,
    );
  }

  Future<void>_showstarPopup(
    BuildContext context, 
    EditMembersController controller,
    TextEditingController starPartnerController,
  ) async {
    await _showMultiSelectPopup<String>(
      context: context,
      controller: controller,
      title: 'Select Stars',
      allItems: ['Any', ...controller.stars .map((star) => star)],
      selectedItems: controller.selectedStar,
      tempSelectedItems: controller.tempSelectedStar,
      textController: starPartnerController,
      itemToString: (item) => item,
    );
  }

  }
  Future<void> _showMultiSelectPopup<T>({
    required BuildContext context,
    required EditMembersController controller,
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
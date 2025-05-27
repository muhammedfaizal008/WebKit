import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_member_controller.dart';
import 'package:webkit/helpers/extensions/extensions.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart' show theme;
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';

class AddReligiousInformation extends StatelessWidget {
  const AddReligiousInformation({
    super.key,
    required this.controller,
    required this.casteController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.errorTextStyle,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final AddMemberController controller;
  final TextEditingController casteController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextStyle errorTextStyle;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return MyFlexItem(
        sizes: "lg-7",
        child: MyContainer.bordered(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium(
                            "Religion".trim().tr().capitalizeWords,
                          ),
                          MySpacing.height(8),
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return controller.religionList.map((religion) {
                                return PopupMenuItem<String>(
                                  value: religion.name,
                                  height: 32,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: MyText.bodySmall(
                                      religion.name,
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: 600,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            position: PopupMenuPosition.under,
                            offset: const Offset(0, 0),
                            onSelected: controller.onReligionSelectedSize,
                            color: theme.cardTheme.color,
                            child: MyContainer.bordered(
                              paddingAll: 10,
                                border: Border.all(
                                  color: controller.religionError  ==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.bodySmall(
                                    controller.religion.isEmpty ? "Select Religion" : controller.religion,
                                    color: controller.religion.isNotEmpty 
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
                          if (controller.religionError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                controller.religionError!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12),
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
                            "Caste".trim().tr().capitalizeWords,
                          ),
                          MySpacing.height(8),
                          PopupMenuButton<String>(
                            enabled: controller.religion.isNotEmpty,
                            itemBuilder: (BuildContext context) {
                              return controller.casteList.map((caste) {
                                return PopupMenuItem<String>(
                                  value: caste.name,
                                  height: 32,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: MyText.bodySmall(
                                      caste.name,
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: 600,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            position: PopupMenuPosition.under,
                            offset: const Offset(0, 0),
                            onSelected: controller.oncasteSelectedSize,
                            color: theme.cardTheme.color,
                            child: MyContainer.bordered(
                              paddingAll: 10,
                                border: Border.all(
                                  color: controller.casteError  ==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.bodySmall(
                                    controller.castestatus.isEmpty ? "Select caste" : controller.castestatus,
                                    color: controller.castestatus.isNotEmpty 
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
                          if (controller.casteError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                controller.casteError!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12),
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
                            "Zodiac Sign".trim().tr().capitalizeWords,
                          ),
                          MySpacing.height(8),
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return controller.zodiacList.map((zodiacSign) {
                                return PopupMenuItem<String>(
                                  value: zodiacSign.name,
                                  height: 32,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: MyText.bodySmall(
                                      zodiacSign.name,
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: 600,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            position: PopupMenuPosition.under,
                            offset: const Offset(0, 0),
                            onSelected: controller.onZodiacSignSelectedSize,
                            color: theme.cardTheme.color,
                            child: MyContainer.bordered(
                              paddingAll: 10,
                                border: Border.all(
                                  color: controller.zodiacError  ==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.bodySmall(
                                    controller.zodiacstatus.isEmpty ? "Select Zodiac Sign" : controller.zodiacstatus,
                                    color: controller.zodiacstatus.isNotEmpty 
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
                          if (controller.zodiacError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                controller.zodiacError!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12),
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
                            "Star/Raasi".trim().tr().capitalizeWords,
                          ),
                          MySpacing.height(8),
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  enabled: false,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 200),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: controller.starsList.map((stars) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              controller.onStarsSelectedSize(stars.name);
                                            },
                                            child: Container(
                                              height: 32,
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: MyText.bodySmall(
                                                stars.name,
                                                color: theme.colorScheme.onSurface,
                                                fontWeight: 600,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ];
                            },
                            child: MyContainer.bordered(
                              paddingAll: 10,
                                border: Border.all(
                                  color: controller.starError  ==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.bodySmall(
                                    controller.starstatus.isEmpty ? "Select Star/Raasi" : controller.starstatus,
                                    color: controller.starstatus.isNotEmpty 
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
                            color: theme.cardTheme.color,
                            offset: const Offset(0, 0),
                            position: PopupMenuPosition.under,
                          ),
                          if (controller.starError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                controller.starError!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12),
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
                            "Chovva Dosham".trim().tr().capitalizeWords,
                          ),
                          MySpacing.height(8),
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: "Yes",
                                  height: 32,
                                  child: MyText.bodySmall(
                                    "Yes",
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: 600,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: "No",
                                  height: 32,
                                  child: MyText.bodySmall(
                                    "No",
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: 600,
                                  ),
                                ),
                              ];
                            },
                            position: PopupMenuPosition.under,
                            offset: const Offset(0, 0),
                            onSelected: controller.onchovvaDoshamSelectedSize,
                            color: theme.cardTheme.color,
                            child: MyContainer.bordered(
                              paddingAll: 10,
                                border: Border.all(
                                  color: controller.chovvaDoshamError  ==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.bodySmall(
                                    controller.chovvaDoshamStatus.isEmpty 
                                        ? "Select Chovva Dosham" 
                                        : controller.chovvaDoshamStatus,
                                    color: controller.chovvaDoshamStatus.isNotEmpty
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
                          if (controller.chovvaDoshamError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                controller.chovvaDoshamError!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                    MySpacing.width(10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelMedium(
                            "Horoscope Match".trim().tr().capitalizeWords,
                          ),
                          MySpacing.height(8),
                            PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return controller.horoscopeMatchList.map((horoscope) {
                                  return PopupMenuItem<String>(
                                    value: horoscope.name,
                                    height: 32,
                                    child: MyText.bodySmall(
                                      horoscope.name,
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: 600,
                                    ),
                                  );
                                }).toList();
                              },
                              position: PopupMenuPosition.under,
                              offset: const Offset(0, 0),
                              onSelected: controller.onHoroscopeSelectedSize,
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                paddingAll: 10,
                                border: Border.all(
                                  color: controller.horoscopeError  ==null ? theme.colorScheme.onSurface.withOpacity(0.2):Colors.red,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.bodySmall(
                                      controller.horoscopeStatus.isEmpty 
                                          ? "Select Horoscope Match" 
                                          : controller.horoscopeStatus,
                                      color: controller.horoscopeStatus.isNotEmpty
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
                            if (controller.horoscopeError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                controller.horoscopeError!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                MySpacing.height(16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButton(
                        onPressed: () async {
                        final isFormValid = formKey.currentState!.validate();
                        final isDropdownValid = controller.validateReligiousInfo();
                
                          if (isFormValid && isDropdownValid){
                            controller.saveReligiousInfo();
                          } else {
                            // Force UI update to show errors
                            controller.update();
                          }
                        },
                        elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor:contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                        child: MyText.bodySmall(
                          'Save'.tr().capitalizeWords,
                          color: contentTheme.onPrimary,
                        ),
                      ),
                      MySpacing.width(8),
                      MyButton(
                        onPressed: () async {
                          final isFormValid = formKey.currentState!.validate();
                        final isDropdownValid = controller.validateReligiousInfo();
                
                          if (isFormValid && isDropdownValid){
                            controller.saveReligiousInfo();
                            defaultTabController.animateTo(4);
                          } else {
                            // Force UI update to show errors
                            controller.update();
                          }
                        },
                        elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor:contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                        child: MyText.bodySmall(
                          'Save & Next'.tr().capitalizeWords,
                          color: contentTheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
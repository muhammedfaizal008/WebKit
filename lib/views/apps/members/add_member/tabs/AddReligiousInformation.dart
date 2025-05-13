import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_member_controller.dart';
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
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
                              paddingAll: 8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.labelMedium(
                                    controller.religion.isEmpty
                                        ? (controller.religionError
                                            ? "Please select religion"
                                            : "Select Religion")
                                        : controller.religion,
                                    color: controller.religion.isNotEmpty
                                        ? Colors.black
                                        : (controller.religionError
                                            ? Colors.red
                                            : theme.colorScheme.onSurface),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
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
                              paddingAll: 8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.labelMedium(
                                    controller.castestatus.isEmpty
                                        ? (controller.casteError
                                            ? "Please select caste"
                                            : "Select caste")
                                        : controller.castestatus,
                                    color: controller.castestatus.isNotEmpty
                                        ? Colors.black
                                        : (controller.casteError
                                            ? Colors.red
                                            : theme.colorScheme.onSurface),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
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
                              paddingAll: 8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.labelMedium(
                                    controller.zodiacstatus.isEmpty
                                        ? (controller.zodiacError
                                            ? "Please select zodiac sign"
                                            : "Select Zodiac Sign")
                                        : controller.zodiacstatus,
                                    color: controller.zodiacstatus.isNotEmpty
                                        ? Colors.black
                                        : (controller.zodiacError
                                            ? Colors.red
                                            : theme.colorScheme.onSurface),
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
                                  enabled: false, // So it can't be selected
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          200, // Adjust this height to fit 5–6 items
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children:
                                            controller.starsList.map((stars) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.pop(
                                                  context); // Close the popup
                                              controller.onStarsSelectedSize(
                                                  stars
                                                      .name); // Handle selection
                                            },
                                            child: Container(
                                              height: 32,
                                              alignment: Alignment.centerLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: MyText.bodySmall(
                                                stars.name,
                                                color:
                                                    theme.colorScheme.onSurface,
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
                              paddingAll: 8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.labelMedium(
                                    controller.starstatus.isEmpty
                                        ? (controller.starError
                                            ? "Please select star"
                                            : "Select Star/Raasi")
                                        : controller.starstatus,
                                    color: controller.starstatus.isNotEmpty
                                        ? Colors.black
                                        : (controller.starError
                                            ? Colors.red
                                            : theme.colorScheme.onSurface),
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
                              paddingAll: 8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.labelMedium(
                                    controller.chovvaDoshamStatus.isEmpty
                                        ? (controller.chovvaDoshamError
                                            ? "Please select chovva dosham"
                                            : "Select Chovva Dosham")
                                        : controller.chovvaDoshamStatus,
                                    color:
                                        controller.chovvaDoshamStatus.isNotEmpty
                                            ? Colors.black
                                            : (controller.chovvaDoshamError
                                                ? Colors.red
                                                : theme.colorScheme.onSurface),
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
                              return [
                                PopupMenuItem<String>(
                                  value: 'Required',
                                  height: 32,
                                  child: MyText.bodySmall(
                                    'Required',
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: 600,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Not Required',
                                  height: 32,
                                  child: MyText.bodySmall(
                                    'Not Required',
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: 600,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Optional',
                                  height: 32,
                                  child: MyText.bodySmall(
                                    'Optional',
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: 600,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Only After Engagement',
                                  height: 32,
                                  child: MyText.bodySmall(
                                    'Only After Engagement',
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: 600,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Based on Astrologer’s Advice',
                                  height: 32,
                                  child: MyText.bodySmall(
                                    'Based on Astrologer’s Advice',
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: 600,
                                  ),
                                ),
                              ];
                            },
                            position: PopupMenuPosition.under,
                            offset: const Offset(0, 0),
                            onSelected: controller.onHoroscopeSelectedSize,
                            color: theme.cardTheme.color,
                            child: MyContainer.bordered(
                              paddingAll: 8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.labelMedium(
                                    controller.horoscopeStatus.isEmpty
                                        ? (controller.horoscopeError
                                            ? "Please select horoscope match"
                                            : "Select Horoscope Match")
                                        : controller.horoscopeStatus,
                                    color: controller.horoscopeStatus.isNotEmpty
                                        ? Colors.black
                                        : (controller.horoscopeError
                                            ? Colors.red
                                            : theme.colorScheme.onSurface),
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                MySpacing.height(16),
                Align(
                  alignment: Alignment.centerRight,
                  child: MyButton(
                          onPressed: () async {
                            // Reset all error flags
                            controller.religionError = controller.religion.isEmpty;
                            controller.casteError = controller.castestatus.isEmpty;
                            controller.zodiacError = controller.zodiacstatus.isEmpty;
                            controller.starError = controller.starstatus.isEmpty;
                            controller.chovvaDoshamError =
                                controller.chovvaDoshamStatus.isEmpty;
                            controller.horoscopeError =
                                controller.horoscopeStatus.isEmpty;

                            if (!controller.validateReligiousInfo()) {
                              controller.update();
                              return;
                            }

                            if (formKey.currentState!.validate()) {
                              controller.saveReligiousInfo();
                              defaultTabController.animateTo(4);
                            }
                          },
                    elevation: 0,
                    padding: MySpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    borderRadiusAll: AppStyle.buttonRadius.medium,
                    child: MyText.bodySmall(
                      'Submit'.tr().capitalizeWords,
                      color: contentTheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

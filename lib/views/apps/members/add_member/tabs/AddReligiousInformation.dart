import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_member_controller.dart';
import 'package:webkit/helpers/extensions/extensions.dart';
import 'package:webkit/helpers/theme/app_theme.dart' show theme;
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

class AddReligiousInformation extends StatelessWidget {
  const AddReligiousInformation({
    super.key,
    required this.controller,
    required this.casteController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.errorTextStyle,
  });

  final AddMemberController controller;
  final TextEditingController casteController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextStyle errorTextStyle;

  @override
  Widget build(BuildContext context) {
    return MyFlexItem(
        sizes: "lg-7",
        child: MyContainer.bordered(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                MyText.labelMedium(
                                  controller.religion.isEmpty
                                      ? "Select Religion"
                                      : controller.religion,
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
                        TextFormField(
                          controller: casteController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your caste";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your Caste",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(12),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: errorTextStyle,
                            errorMaxLines: 1,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  MyText.labelMedium(
                                    controller.religion.isEmpty
                                        ? "Select Zodiac Sign"
                                        : controller.religion,
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
                        TextFormField(
                          controller: casteController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your Star/Raasi";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your Star/Raasi",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(12),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorStyle: errorTextStyle,
                            errorMaxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

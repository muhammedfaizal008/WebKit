import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/edit_members_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

class PersonalDetails extends StatefulWidget {
  PersonalDetails({
    super.key,
    required this.uid,
    required this.theme,
    required this.outlineInputBorder,
    required this.religionController,
    required this.casteController,
    required this.professionController,
    required this.educationController,
    required this.formKey,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final ThemeData theme;
  final OutlineInputBorder outlineInputBorder;
  final String uid;
  final TextEditingController religionController;
  final TextEditingController casteController;
  final TextEditingController professionController;
  final TextEditingController educationController;
  final GlobalKey<FormState> formKey;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
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
    controller.fetchLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.labelLarge("Marital Status".tr().capitalizeWords),
                  MySpacing.height(8),
                  PopupMenuButton<String>(
                    itemBuilder: (context) {
                      return [
                        'Single',
                        'Married',
                        'Divorced',
                        'Widowed',
                      ].map((status) {
                        return PopupMenuItem<String>(
                          value: status,
                          height: 32,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: MyText.bodySmall(
                              status,
                              color: widget.theme.colorScheme.onSurface,
                              fontWeight: 600,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    position: PopupMenuPosition.under,
                    offset: const Offset(0, 0),
                    onSelected: controller.onSelectedSize,
                    color: widget.theme.cardTheme.color,
                    child: MyContainer.bordered(
                      paddingAll: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyText.labelMedium(
                            "${controller.selectProperties}",
                            color: widget.theme.colorScheme.onSurface,
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            LucideIcons.chevronDown,
                            size: 22,
                            color: widget.theme.colorScheme.onSurface,
                          ),
                        ],
                      ),
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
                  MyText.labelLarge("Mother Tongue".tr().capitalizeWords),
                  MySpacing.height(8),
                  Material(
                    // Ensure it's tappable
                    color: Colors.transparent,
                    child: PopupMenuButton<String>(
                      itemBuilder: (BuildContext context) {
                        return controller.languages.map((behavior) {
                          return PopupMenuItem(
                            value: behavior,
                            height: 32,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
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
                      onSelected: controller.onSelectedSize1,
                      color: theme.cardTheme.color,
                      child: MyContainer.bordered(
                        paddingAll: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MyText.labelMedium(
                              controller.selectProperties1,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    "religion".tr().capitalizeWords,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your religion';
                      }
                      return null;
                    },
                    controller: widget.religionController,
                    decoration: InputDecoration(
                        hintText: "Religion",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: widget.outlineInputBorder,
                        enabledBorder: widget.outlineInputBorder,
                        focusedBorder: focusedInputBorder,
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
              "caste".tr().capitalizeWords,
            ),
            MySpacing.height(8),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your caste ';
                }
                return null;
              },
              controller: widget.casteController,
              decoration: InputDecoration(
                  hintText: "caste",
                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                  border: widget.outlineInputBorder,
                  enabledBorder: widget.outlineInputBorder,
                  focusedBorder: focusedInputBorder,
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
                await controller.savePersonalData(
                  uid: widget.uid,
                  religion: widget.religionController.text,
                  caste: widget.casteController.text,
                );
                widget.defaultTabController.animateTo(2);
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
    );
  }
}

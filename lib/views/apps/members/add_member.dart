

  import 'package:flutter/material.dart';
  import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/app_constant.dart';
  import 'package:webkit/controller/apps/members/add_member_controller.dart';
import 'package:webkit/controller/forms/basic_controller.dart';
import 'package:webkit/helpers/extensions/date_time_extention.dart';
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
  import 'package:webkit/views/layouts/layout.dart';

  class AddMember extends StatefulWidget {
    const AddMember({super.key});

    @override
    State<AddMember> createState() => _AddMemberState();
  }

  class _AddMemberState extends State<AddMember>
      with SingleTickerProviderStateMixin, UIMixin {
    late AddMemberController controller;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

    @override
    void initState() {
      controller = Get.put(AddMemberController());
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
                      "basic_forms".tr().capitalizeWords,
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
                                      "basic_input".capitalizeWords,
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
                                              "Full name".capitalizeWords,
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
                                    "email address".trim().capitalizeWords,
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
                                    "password",
                                  ),
                                  MySpacing.height(8),
                                  TextFormField(
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
                                      MyText.labelLarge("gender"),
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
                                  MySpacing.height(20),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: MyButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: MyText.bodySmall(
                                        'submit',
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
                    ),
                    MyFlexItem(
                      sizes: "lg-7",
                      child: MyContainer.bordered(
                        paddingAll: 0,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: MySpacing.x(8),
                              child: MyContainer(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      LucideIcons.layers,
                                      size: 16,
                                    ),
                                    MySpacing.width(12),
                                    MyText.titleMedium(
                                      "More inputs".tr().capitalizeWords,
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
                                  MyText.labelLarge(
                                      "date_time_pickers".capitalizeWords),
                                  MySpacing.height(12),
                                  Wrap(
                                    spacing: 16,
                                    runSpacing: 16,
                                    children: [
                                      MyButton.outlined(
                                        onPressed: () {
                                          controller.pickDate();
                                        },
                                        borderColor: contentTheme.primary,
                                        padding: MySpacing.xy(16, 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              LucideIcons.calendar,
                                              color: contentTheme.primary,
                                              size: 16,
                                            ),
                                            MySpacing.width(10),
                                            MyText.labelMedium(
                                                controller.selectedDate != null
                                                    ? dateFormatter.format(
                                                        controller
                                                            .selectedDate!)
                                                    : "select_date"
                                                        
                                                        .capitalizeWords,
                                                fontWeight: 600,
                                                color: contentTheme.primary),
                                          ],
                                        ),
                                      ),
                                      MyButton.outlined(
                                        onPressed: () {
                                          controller.pickTime();
                                        },
                                        borderColor: contentTheme.primary,
                                        padding: MySpacing.xy(16, 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              LucideIcons.clock4,
                                              color: contentTheme.primary,
                                              size: 16,
                                            ),
                                            MySpacing.width(10),
                                            MyText.labelMedium(
                                                controller.selectedTime != null
                                                    ? timeFormatter.format(
                                                        DateTime.now().applied(
                                                            controller
                                                                .selectedTime!))
                                                    : "select_time"
                                                        
                                                        .capitalizeWords,
                                                fontWeight: 600,
                                                color: contentTheme.primary),
                                          ],
                                        ),
                                      ),
                                      MyButton.outlined(
                                        onPressed: () {
                                          controller.pickDateRange();
                                        },
                                        borderColor: contentTheme.primary,
                                        padding: MySpacing.xy(16, 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              LucideIcons.calendarDays,
                                              color: contentTheme.primary,
                                              size: 16,
                                            ),
                                            MySpacing.width(10),
                                            MyText.labelMedium(
                                                controller.selectedDateTimeRange !=
                                                        null
                                                    ? "${dateFormatter.format(controller.selectedDateTimeRange!.start)} - ${dateFormatter.format(controller.selectedDateTimeRange!.end)}"
                                                    : "select_range"
                                                        
                                                        .capitalizeWords,
                                                fontWeight: 600,
                                                color: contentTheme.primary),
                                          ],
                                        ),
                                      ),
                                      MyButton.outlined(
                                        onPressed: () {
                                          controller.pickDateTime();
                                        },
                                        borderColor: contentTheme.primary,
                                        padding: MySpacing.xy(16, 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              LucideIcons.calendarCheck,
                                              color: contentTheme.primary,
                                              size: 16,
                                            ),
                                            MySpacing.width(10),
                                            MyText.labelMedium(
                                                controller.selectedDateTime !=
                                                        null
                                                    ? "${dateFormatter.format(controller.selectedDateTime!)} ${timeFormatter.format(controller.selectedDateTime!)}"
                                                    : "select_date_&_time"
                                                        
                                                        .capitalizeWords,
                                                fontWeight: 600,
                                                color: contentTheme.primary),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(20),
                                  MyText.labelLarge("sliders"),
                                  MySpacing.height(8),
                                  Slider(
                                    activeColor: contentTheme.primary,
                                    inactiveColor:
                                        contentTheme.primary.withAlpha(50),
                                    value: controller.slider1,
                                    onChanged: controller.onChangeSlider1,
                                    min: 0,
                                    max: 50,
                                  ),
                                  MyContainer.bordered(
                                    margin: MySpacing.x(flexSpacing),
                                    paddingAll: 8,
                                    child: Center(
                                      child: MyText.titleSmall(
                                          "${controller.slider1}"),
                                    ),
                                  ),
                                  Slider(
                                    activeColor: contentTheme.primary,
                                    inactiveColor:
                                        contentTheme.primary.withAlpha(50),
                                    value: controller.slider2,
                                    min: 0,
                                    max: 100,
                                    divisions: 100,
                                    label:
                                        controller.slider2.floor().toString(),
                                    onChanged: controller.onChangeSlider2,
                                  ),
                                  MyContainer.bordered(
                                    margin: MySpacing.x(flexSpacing),
                                    paddingAll: 8,
                                    child: Center(
                                      child: MyText.titleSmall(
                                          "${controller.slider2}"),
                                    ),
                                  ),
                                  RangeSlider(
                                    values: controller.rangeSlider,
                                    min: 0,
                                    max: 100,
                                    divisions: 100,
                                    labels: RangeLabels(
                                        controller.rangeSlider.start
                                            .floor()
                                            .toString(),
                                        controller.rangeSlider.end
                                            .floor()
                                            .toString()),
                                    onChanged: controller.onChangeRangeSlider,
                                    activeColor: contentTheme.primary,
                                    inactiveColor:
                                        contentTheme.primary.withAlpha(50),
                                  ),
                                  MyContainer.bordered(
                                    margin: MySpacing.x(flexSpacing),
                                    paddingAll: 8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        MyText.bodyMedium(
                                            "${controller.rangeSlider.start}"),
                                        MyText.bodyMedium(
                                            "${controller.rangeSlider.end}")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-7",
                      child: MyContainer.bordered(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                      LucideIcons.settings,
                                      size: 16,
                                    ),
                                    MySpacing.width(12),
                                    MyText.titleMedium(
                                      "builder",
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
                                      SizedBox(
                                          width: 180,
                                          child: MyText.labelLarge(
                                              "floating_label_type"
                                                  
                                                  .capitalizeWords)),
                                      PopupMenuButton(
                                          onSelected:
                                              controller.onChangeLabelType,
                                          itemBuilder: (BuildContext context) {
                                            return FloatingLabelBehavior.values
                                                .map((behavior) {
                                              return PopupMenuItem(
                                                value: behavior,
                                                height: 32,
                                                child: MyText.bodySmall(
                                                  behavior.name.capitalize!,
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                  fontWeight: 600,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          color: theme.cardTheme.color,
                                          child: MyContainer.bordered(
                                            padding: MySpacing.xy(12, 8),
                                            child: Row(
                                              children: <Widget>[
                                                MyText.labelMedium(
                                                  controller
                                                      .floatingLabelBehavior
                                                      .name
                                                      .capitalize!,
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  child: Icon(
                                                    LucideIcons.chevronDown,
                                                    size: 22,
                                                    color: theme.colorScheme
                                                        .onSurface,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  MySpacing.height(8),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 180,
                                          child: MyText.labelLarge("border_type"
                                              
                                              .capitalizeWords)),
                                      PopupMenuButton(
                                          onSelected:
                                              controller.onChangeBorderType,
                                          itemBuilder: (BuildContext context) {
                                            return TextFieldBorderType.values
                                                .map((borderType) {
                                              return PopupMenuItem(
                                                value: borderType,
                                                height: 32,
                                                child: MyText.bodySmall(
                                                  borderType.name.capitalize!,
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                  fontWeight: 600,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          color: theme.cardTheme.color,
                                          child: MyContainer.bordered(
                                            padding: MySpacing.xy(12, 8),
                                            child: Row(
                                              children: <Widget>[
                                                MyText.labelMedium(
                                                  controller.borderType.name
                                                      .capitalize!,
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  child: Icon(
                                                    LucideIcons.chevronDown,
                                                    size: 22,
                                                    color: theme.colorScheme
                                                        .onSurface,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  MySpacing.height(12),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 180,
                                          child:
                                              MyText.labelLarge("filled")),
                                      Switch(
                                        onChanged:
                                            controller.onChangedFilledChecked,
                                        value: controller.filled,
                                        activeColor: contentTheme.primary,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        // visualDensity: getCompactDensity,
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(20),
                                  MyText.labelLarge("output"),
                                  MySpacing.height(20),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Sample Text Field",
                                        border: controller.inputBorder,
                                        focusedBorder: controller.inputBorder,
                                        filled: controller.filled,
                                        enabledBorder: controller.inputBorder,
                                        floatingLabelBehavior:
                                            controller.floatingLabelBehavior),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      );
    }
  }



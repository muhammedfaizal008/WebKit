import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
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

class ReligiousInfo extends StatefulWidget {
   ReligiousInfo({
    super.key,
    required this.uid,
    required this.religionController,
    required this.outlineInputBorder,
    required this.focusedInputBorder,
    required this.casteController,
    required this.zodiacSignController,
    required this.starController,
    required this.chovvaDoshamController,
    required this.horoscopeController,
    required this.formKey,
    required this.defaultTabController,
    required this.contentTheme,
  });

  final String uid;
  final TextEditingController religionController;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder focusedInputBorder;
  final TextEditingController casteController;
  final TextEditingController zodiacSignController;
  final TextEditingController starController;
  final TextEditingController chovvaDoshamController;
  final TextEditingController horoscopeController;
  final GlobalKey<FormState> formKey;
  final TabController defaultTabController;
  final ContentTheme contentTheme;

  @override
  State<ReligiousInfo> createState() => _ReligiousInfoState();
}

class _ReligiousInfoState extends State<ReligiousInfo> {
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
    final GlobalKey _religionKey=GlobalKey();
    final GlobalKey _casteKey=GlobalKey();
    final GlobalKey _zodiacSignKey=GlobalKey();
    final GlobalKey _starKey=GlobalKey();
    final GlobalKey _doshamKey=GlobalKey();
    final GlobalKey _horoscopeMatchKey=GlobalKey();
    
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
                  "Religious Details".tr().capitalizeWords,
                  fontWeight: 600,
                ),
              ],
            ),
            MySpacing.height(15),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium(
                        "religion".tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _religionKey,
                                readOnly: true,
                                controller: widget.religionController,
                                onTap: () => _showSelectionMenu(
                                  key: _religionKey,
                                  items: controller.religions,
                                  onSelected: (religion) {
                                  controller.setselectReligion(religion);
                                  widget.religionController.text = religion;
                                  },
                                  controller: widget.religionController,
                                ),
                                style: MyTextStyle.bodySmall(),
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
                      MyText.labelMedium(
                        "caste".tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                        builder: (controller) {
                          return TextFormField(
                            key: _casteKey,
                            readOnly: true,
                            controller: widget.casteController,
                            onTap: () => _showSelectionMenu(
                              key: _casteKey,
                              items: controller.castes,
                              onSelected: controller.setSelectedCaste,
                              controller: widget.casteController,
                            ),
                            style: MyTextStyle.bodySmall(),
                            decoration: InputDecoration(
                              hintText: "Select caste",
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
            MySpacing.height(10),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium(
                        "zodiac sign".tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _zodiacSignKey,
                                readOnly: true,
                                controller: widget.zodiacSignController,
                                onTap: () => _showSelectionMenu(
                                  key: _zodiacSignKey,
                                  items: controller.zodiacSigns,
                                  onSelected: controller.setselectzodiacSign,
                                  controller: widget.zodiacSignController,
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select zodiac sign",
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
                      MyText.labelMedium(
                        "star/raasi".tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _starKey,
                                readOnly: true,
                                controller: widget.starController,
                                onTap: () => _showSelectionMenu(
                                  key: _starKey,
                                  items: controller.stars,
                                  onSelected: controller.setselectstar,
                                  controller: widget.starController,
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select star ",
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
            MySpacing.height(10),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium(
                        "chovva dosham".tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _doshamKey,
                                readOnly: true,
                                controller: widget.chovvaDoshamController,
                                onTap: () => _showSelectionMenu(
                                  key: _doshamKey,
                                  items: [
                                    "Yes","No"
                                  ],
                                  onSelected: controller.setselectdosham,
                                  controller: widget.chovvaDoshamController,  
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select chovvaDosham ",
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
                      MyText.labelMedium(
                        "horoscope match".tr().capitalizeWords,
                      ),
                      MySpacing.height(8),
                      GetBuilder<EditMembersController>(
                            builder: (controller) {
                              return TextFormField(
                                key: _horoscopeMatchKey,
                                readOnly: true,
                                controller: widget.horoscopeController,
                                onTap: () => _showSelectionMenu(
                                  key: _horoscopeMatchKey,
                                  items: controller.horoscopeMatch,
                                  onSelected: controller.setselecthoroscopeMatch,
                                  controller: widget.horoscopeController
                                ),
                                style: MyTextStyle.bodySmall(),
                                decoration: InputDecoration(
                                  hintText: "Select horoscopeMatch ",
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
            MySpacing.height(10),
            Align(  
              alignment: Alignment.centerRight,
              child: MyButton(
                onPressed: () async { 
                  
                    controller.saveReligiousInfo(
                      uid: widget.uid,caste: widget.casteController.text,religion: widget.religionController.text,zodiacSign: widget.zodiacSignController.text,
                      chovvadosham: widget.chovvaDoshamController.text,horoscopeMatch: widget.horoscopeController.text,
                      star: widget.starController.text
                    );
                    widget.defaultTabController.animateTo(3);
                  
                },
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor:widget.contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: MyText.bodySmall(
                  'Submit'.tr().capitalizeWords,
                  color: widget.contentTheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';


import 'package:webkit/controller/apps/members/profile_attributes/zodiac_sign_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/models/zodiac_sign.dart';
import 'package:webkit/views/layouts/layout.dart';

class ZodiacSign extends StatefulWidget {
  const ZodiacSign({super.key});

  @override
  State<ZodiacSign> createState() => _ZodiacSignState();
}

class _ZodiacSignState extends State<ZodiacSign> with UIMixin{
  late ZodiacSignController controller;
  TextEditingController zodiacSignController = TextEditingController();
  @override
  void initState() {
    controller = Get.put(ZodiacSignController());
    super.initState();
    controller.fetchZodiacSign();
  } 

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<ZodiacSignController>(builder: (controller) {
        if (controller.data == null) {
          return Center(
              child: RefreshProgressIndicator(
            backgroundColor: Colors.white,
          ));
        }

        return Column(
          children: [
            Padding(
              padding: MySpacing.x(flexSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.titleMedium("ZodiacSign", fontWeight: 600),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: "Users"),
                      MyBreadcrumbItem(name: "ZodiacSign", active: true),
                    ],
                  ),
                ],
              ),
            ),
            MySpacing.height(20),
            MyFlex(children: [
              MyFlexItem(
                sizes: "lg-6 md-6 sm-12 xs-12",
                child: PaginatedDataTable(
                  dividerThickness: 0,
                  showEmptyRows: false,
                  showCheckboxColumn: false,
                  header: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.titleMedium("All ZodiacSign"),
                        Spacer(),
                        MyButton(
                          backgroundColor: contentTheme.primary,
                         borderRadiusAll: 10,
                          onPressed: () {
                            TextEditingController ZodiacSignController = TextEditingController();
                              Get.dialog(
                              Dialog(
                                backgroundColor: theme.cardColor,
                                child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 320),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MyText.titleMedium("Add ZodiacSign"),
                                    MySpacing.height(16),
                                    TextFormField(
                                    controller: ZodiacSignController,
                                    decoration: InputDecoration(
                                      labelText: "ZodiacSign",
                                      labelStyle:
                                      MyTextStyle.labelMedium(),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.grey,
                                            style: BorderStyle.none),
                                      ),
                                      enabledBorder:
                                          OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder:
                                          OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey),
                                                ),
                                    ),
                                    ),
                                    MySpacing.height(16),
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MyButton(
                                      borderRadiusAll: 8,
                                      padding: MySpacing.xy(16, 10),
                                      child: MyText.bodyMedium("Cancel",color: Colors.white),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      ),
                                      MySpacing.width(12),
                                      MyButton(
                                      borderRadiusAll: 8,
                                      padding: MySpacing.xy(16, 10),
                                      child: MyText.bodyMedium("Add", color: Colors.white),
                                      onPressed: () async {
                                        final newStatus = ZodiacSignController.text.trim();
                                        if (newStatus.isNotEmpty) {
                                          Get.back();
                                          controller.addZodiacSign(name: ZodiacSignController.text);
                                        }
                                      },
                                      ),
                                    ],
                                    ),
                                  ],
                                  ),
                                ),
                                ),
                              ),
                              );
                          },
                          child:Row(
                            children: [
                              Icon(LucideIcons.userPlus,color: Colors.white,),
                              MySpacing.width(10),
                              MyText.bodyMedium("Add ZodiacSign",color: Colors.white),
                            ],
                          ))
                      ],
                    ),
                  ),
                  source:
                      ZodiacSignDataSource(controller.ZodiacSignList, controller),
                  columns: [
                    DataColumn(
                      label: MyText.titleSmall('#', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Name', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Options', fontWeight: 600),
                    ),
                  ],
                  // columnSpacing: 50,
                  // horizontalMargin: 16,
                  rowsPerPage: (controller.data!.rowCount == 0)
                    ? 1
                    : (controller.data!.rowCount < 10 ? controller.data!.rowCount : 10),
                  // Optional: Hide the dropdown if there's only one page
                  availableRowsPerPage: (controller.data!.rowCount == 0)
                    ? [1]
                    : (controller.data!.rowCount <= 10
                      ? [controller.data!.rowCount]
                      : [10, 25, 50]),
                ),
              ),
              
            ]),
          ],
        );
      }),
    );
  }
}

class ZodiacSignDataSource extends DataTableSource {
  final List<ZodiacSignModel> zodiacSign;
  final ZodiacSignController controller;

  ZodiacSignDataSource(this.zodiacSign, this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= zodiacSign.length) return null;
    final ZodiacSign = zodiacSign[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(MyText.titleSmall('${index + 1}')),
        DataCell(MyText.titleSmall(ZodiacSign.name)),
        DataCell(Row(
            children: [
            MyButton(
              borderRadiusAll: 8,
              padding: MySpacing.xy(8, 8),
              backgroundColor: Colors.transparent,
              splashColor: Colors.grey.withOpacity(0.2),
              child: Icon(Icons.edit, size: 20, color: Colors.blue),
              onPressed: () {
              final TextEditingController editController =
                TextEditingController(text: ZodiacSign.name);
              Get.dialog(
                Dialog(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 320),
                  child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    MyText.titleMedium("Edit ZodiacSign"),
                    MySpacing.height(16),
                    TextFormField(
                      controller: editController,
                      decoration: InputDecoration(
                      labelText: "ZodiacSign Name",
                      border: OutlineInputBorder(),
                      ),
                    ),
                    MySpacing.height(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      MyButton(
                        borderRadiusAll: 8,
                        padding: MySpacing.xy(16, 10),
                        child: MyText.bodyMedium("Cancel"),
                        onPressed: () {
                        Get.back();
                        },
                      ),
                      MySpacing.width(12),
                      MyButton(
                        borderRadiusAll: 8,
                        padding: MySpacing.xy(16, 10),
                        child: MyText.bodyMedium("Save", color: Colors.white),
                        onPressed: () async {
                        final newName = editController.text.trim();
                        if (newName.isNotEmpty) {
                          Get.back();
                          controller.editZodiacSign(ZodiacSign.id, newName);  
                        }
                        },
                      ),
                      ],
                    ),
                    ],
                  ),
                  ),
                ),
                ),
              );
              },
            ),
            MyButton(
              borderRadiusAll: 8,
              padding: MySpacing.xy(8, 8),
              backgroundColor: Colors.transparent,
              splashColor: Colors.grey.withOpacity(0.2),
              child: Icon(Icons.delete, size: 20, color: Colors.red),
              onPressed: () async {
              await FirebaseFirestore.instance
                .collection('ZodiacSign')
                .doc(ZodiacSign.id)
                .delete()
                .then((_) {
                Get.snackbar("Success", "ZodiacSign deleted successfully");
                controller.fetchZodiacSign(); // Refresh list
              }).catchError((error) {
                Get.snackbar("Error", "Failed to delete ZodiacSign: $error");
              });
              },
            ),
            ],
        )),
      ],
    );
  }

  

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => zodiacSign.length;

  @override
  int get selectedRowCount => 0;
}


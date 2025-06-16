import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
  import 'package:webkit/controller/apps/staffs/staff_roles_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/models/staff_roles_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class StaffRoles extends StatefulWidget {
  const StaffRoles({super.key});

  @override
  State<StaffRoles> createState() => _StaffRolesState();
}

class _StaffRolesState extends State<StaffRoles> {
  late StaffRolesController controller;
  @override
  void initState() {
    controller = Get.put(StaffRolesController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: StaffRolesController(),
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Staff",
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Staffs", active: false),
                        MyBreadcrumbItem(name: "Staff Roles", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(20),
              MyFlex(children: [
                MyFlexItem(
                  sizes: "lg-12 md-12 sm-12 xs-12",
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
                          MyText.titleMedium("Staff Roles"),
                          Spacer(),
                          MyButton(
                              onPressed: () {
                                TextEditingController addCasteController =
                                    TextEditingController();
                                Get.dialog(
                                  Dialog(
                                    backgroundColor: theme.cardColor,
                                    child: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: 320),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MyText.titleMedium("Add Staff Role"),
                                            MySpacing.height(16),
                                            TextFormField(
                                              controller: addCasteController,
                                              decoration: InputDecoration(
                                                labelText: "Staff Role",
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                MyButton(
                                                  borderRadiusAll: 8,
                                                  padding: MySpacing.xy(16, 10),
                                                  child: MyText.bodyMedium(
                                                      "Cancel",
                                                      color: Colors.white),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                                MySpacing.width(12),
                                                MyButton(
                                                  borderRadiusAll: 8,
                                                  padding: MySpacing.xy(16, 10),
                                                  child: MyText.bodyMedium(
                                                      "Add",
                                                      color: Colors.white),
                                                  onPressed: () async {
                                                    controller.addStaffRoles(
                                                        role: addCasteController
                                                            .text);
                                                    Get.back();
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
                              child: MyText.bodyMedium("Add Staff Role",
                                  color: Colors.white))
                        ],
                      ),
                    ),
                    source: StaffRolesDataSource(
                        controller.StaffRolesList, controller),
                    columns: [
                      DataColumn(
                        label: MyText.titleSmall('#', fontWeight: 600),
                      ),
                      DataColumn(
                        label: MyText.titleSmall('Role', fontWeight: 600),
                      ),
                      DataColumn(
                        label: MyText.titleSmall('Options', fontWeight: 600),
                      ),
                    ],
                    // columnSpacing: 50,
                    // horizontalMargin: 16,
                    rowsPerPage: 10,
                  ),
                ),
              ]),
            ],
          );
        },
      ),
    );
  }
}

class StaffRolesDataSource extends DataTableSource {
  final List<StaffRolesModel> StaffRoles;
  final StaffRolesController controller;

  StaffRolesDataSource(this.StaffRoles, this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= StaffRoles.length) return null;
    final Staff = StaffRoles[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(MyText.bodyMedium('${index + 1}')),
        DataCell(MyText.bodyMedium(Staff.role)),
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, size: 20),
              onPressed: () {
                final TextEditingController editController =
                    TextEditingController(text: Staff.role);
                Get.dialog(
                  Dialog(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 320),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText.titleMedium("Edit Staff"),
                            MySpacing.height(16),
                            TextFormField(
                              controller: editController,
                              decoration: InputDecoration(
                                labelText: "Staff Role  ",
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
                                  child: MyText.bodyMedium("Save",
                                      color: Colors.white),
                                  onPressed: () async {
                                    final newName = editController.text.trim();
                                    if (newName.isNotEmpty) {
                                      controller.editStaffRoles(
                                          Staff.id, newName);
                                      Get.back();
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
            IconButton(
              icon: Icon(Icons.delete, size: 20),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('StaffRole')
                    .doc(Staff.id)
                    .delete()
                    .then((_) {
                  Get.snackbar("Success", "Staff deleted successfully");
                  controller.fetchStaffRoles(); // Refresh list
                }).catchError((error) {
                  Get.snackbar("Error", "Failed to delete Staff: $error");
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
  int get rowCount => StaffRoles.length;

  @override
  int get selectedRowCount => 0;
}

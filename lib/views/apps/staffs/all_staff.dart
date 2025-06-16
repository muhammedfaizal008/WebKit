import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/staffs/all_staff_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/utils/utils.dart';
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
import 'package:webkit/models/all_staff_model.dart';
import 'package:webkit/views/layouts/layout.dart';
import 'package:webkit/widgets/buildActionButton.dart';

class AllStaff extends StatefulWidget {
  const AllStaff({super.key});

  @override
  State<AllStaff> createState() => _AllStaffState();
}

class _AllStaffState extends State<AllStaff> with UIMixin{
  late AllStaffController controller;
  @override
  void initState() {
    controller = Get.put(AllStaffController());
    controller.fetchStaffRoles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: AllStaffController(),
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Staffs",
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Staffs", active: false),
                        MyBreadcrumbItem(name: "Staff", active: true),
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
                          MyText.titleMedium("Staffs",fontWeight: 600,),
                          Spacer(),
                          MyButton(
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: 10,
                              onPressed: () {
                                Get.toNamed('/staff/add_staff');
                                
                              },
                              child: Row(
                            children: [
                              Icon(LucideIcons.userPlus,color: Colors.white,),
                              MySpacing.width(10),
                              MyText.bodyMedium("Add staff",color: Colors.white),
                            ],
                          ))
                        ],
                      ),
                    ),
                    source:
                        AllStaffDataSource(controller.allStaffList, controller),
                    columns: [
                      DataColumn(
                      label: MyText.titleSmall('#', fontWeight: 600),
                      ),
                      DataColumn(
                      label: MyText.titleSmall('Name', fontWeight: 600),
                      ),
                      DataColumn(
                      label: MyText.titleSmall('Role', fontWeight: 600),
                      ),
                      DataColumn(
                      label: MyText.titleSmall('Active', fontWeight: 600),
                      ),
                      DataColumn(
                      label: MyText.titleSmall('Email', fontWeight: 600),
                      ),
                      DataColumn(
                      label: MyText.titleSmall('Status', fontWeight: 600),
                      ),
                      DataColumn(
                      label: MyText.titleSmall('Created At', fontWeight: 600),
                      ),
                      DataColumn(
                      label: MyText.titleSmall('Updated At', fontWeight: 600),
                      ),
                      DataColumn(
                      label: MyText.titleSmall('Actions', fontWeight: 600),
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

class AllStaffDataSource extends DataTableSource {
  final List<AllStaffModel> allStaff;
  final AllStaffController controller;

  AllStaffDataSource(this.allStaff, this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= allStaff.length) return null;
    final staff = allStaff[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(MyText.bodyMedium('${index + 1}')), // #
        DataCell(MyText.bodyMedium(staff.staffName)), // Name
        DataCell(MyText.bodyMedium(staff.role)), // Role
        DataCell(
          MyText.bodyMedium(staff.status), // Active
        ),
        DataCell(MyText.bodyMedium(staff.email)), // Email
        DataCell(MyText.bodyMedium(staff.status)), // Status
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(
              (staff.createdAt).toDate(),
              showMonthShort: true),
        )), // Created At
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(
              (staff.updatedAt).toDate(),
              showMonthShort: true),
        )),  // Updated At
        DataCell(Row(
          children: [
            BuildActionButton(icon: Icons.edit, onPressed: () {
                final TextEditingController editController =
                    TextEditingController(text: staff.role);
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
                                labelText: "Staff Role",
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
                                    final newRole = editController.text.trim();
                                    if (newRole.isNotEmpty) {
                                      controller.editAllStaff(
                                          staff.id, newRole);
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
              }, isPrimary: true),
            SizedBox(width: 5,),
            BuildActionButton(
              icon:Icons.delete,iconColor: Colors.red, onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('AllStaff')
                    .doc(staff.id)
                    .delete()
                    .then((_) {
                  Get.snackbar("Success", "Staff deleted successfully");
                  controller.fetchAllStaffs(); // Refresh list
                }).catchError((error) {
                  Get.snackbar("Error", "Failed to delete Staff: $error");
                });
              }, isPrimary: false)
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => allStaff.length;

  @override
  int get selectedRowCount => 0;
}

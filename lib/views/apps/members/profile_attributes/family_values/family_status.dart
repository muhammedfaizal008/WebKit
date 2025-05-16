
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/profile_attributes/family_status_controller.dart';
import 'package:webkit/controller/apps/members/profile_attributes/family_type_controller.dart';
import 'package:webkit/controller/apps/members/profile_attributes/family_values_controller.dart';
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
import 'package:webkit/models/family_status_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class FamilyStatus extends StatefulWidget {
  const FamilyStatus({super.key});

  @override
  State<FamilyStatus> createState() => _FamilyStatusState();
}

class _FamilyStatusState extends State<FamilyStatus>  with SingleTickerProviderStateMixin, UIMixin {
  late FamilyStatusController controller;
  TextEditingController familyStatusController = TextEditingController();
  @override
  void initState() {
    controller = Get.put(FamilyStatusController());
    super.initState();
    controller.fetchFamilyStatus();
  } 

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<FamilyStatusController>(builder: (controller) {
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
                  MyText.titleMedium("FamilyStatus", fontWeight: 600),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: "Users"),
                      MyBreadcrumbItem(name: "FamilyStatus", active: true),
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
                        MyText.titleMedium("All FamilyStatus"),
                        Spacer(),
                        MyButton(
                         backgroundColor: contentTheme.primary,
                         borderRadiusAll: 10,
                          onPressed: () {
                            TextEditingController FamilyStatusController = TextEditingController();
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
                                    MyText.titleMedium("Add FamilyStatus"),
                                    MySpacing.height(16),
                                    TextFormField(
                                    controller: FamilyStatusController,
                                    decoration: InputDecoration(
                                      labelText: "FamilyStatus",
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
                                        final newStatus = FamilyStatusController.text.trim();
                                        if (newStatus.isNotEmpty) {
                                          Get.back();
                                          controller.addFamilyStatus(name: FamilyStatusController.text);
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
                              MyText.bodyMedium("Add FamilyStatus",color: Colors.white)
                            ],
                          )
                          )
                      ],
                    ),
                  ),
                  source:
                      FamilyStatusDataSource(controller.FamilyStatusList, controller),
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
                  // Dynamically set rowsPerPage based on data length
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

class FamilyStatusDataSource extends DataTableSource {
  final List<FamilyStatusModel> familyStatus;
  final FamilyStatusController controller;

  FamilyStatusDataSource(this.familyStatus, this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= familyStatus.length) return null;
    final FamilyStatus = familyStatus[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(MyText.titleSmall('${index + 1}')),    
        DataCell(MyText.titleSmall(FamilyStatus.name)),
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
                TextEditingController(text: FamilyStatus.name);
              Get.dialog(
                Dialog(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 320),
                  child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    MyText.titleMedium("Edit FamilyStatus"),
                    MySpacing.height(16),
                    TextFormField(
                      controller: editController,
                      decoration: InputDecoration(
                      labelText: "FamilyStatus Name",
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
                          controller.editFamilyStatus(FamilyStatus.id, newName);  
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
                .collection('FamilyStatus')
                .doc(FamilyStatus.id)
                .delete()
                .then((_) {
                Get.snackbar("Success", "FamilyStatus deleted successfully");
                controller.fetchFamilyStatus(); // Refresh list
              }).catchError((error) {
                Get.snackbar("Error", "Failed to delete FamilyStatus: $error");
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
  int get rowCount => familyStatus.length;

  @override
  int get selectedRowCount => 0;
}


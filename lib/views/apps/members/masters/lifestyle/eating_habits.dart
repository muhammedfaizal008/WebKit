
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/profile_attributes/eating_habits_controller.dart';
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
import 'package:webkit/models/eating_habits_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class EatingHabits extends StatefulWidget {
  const EatingHabits({super.key});

  @override
  State<EatingHabits> createState() => _EatingHabitsState();
}

class _EatingHabitsState extends State<EatingHabits> with UIMixin{
  late EatingHabitsController controller;
  TextEditingController eatingHabitsController = TextEditingController();
  @override
  void initState() {
    controller = Get.put(EatingHabitsController());
    super.initState();
    controller.fetchEatingHabits();
  } 

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<EatingHabitsController>(builder: (controller) {
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
                  MyText.titleMedium("EatingHabits", fontWeight: 600),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: "Users"),
                      MyBreadcrumbItem(name: "EatingHabits", active: true),
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
                        MyText.titleMedium("All EatingHabits"),
                        Spacer(),
                        MyButton(
                          backgroundColor: contentTheme.primary,
                         borderRadiusAll: 10,
                          onPressed: () {
                            TextEditingController EatingHabitsController = TextEditingController();
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
                                    MyText.titleMedium("Add EatingHabits"),
                                    MySpacing.height(16),
                                    TextFormField(
                                    controller: EatingHabitsController,
                                    decoration: InputDecoration(
                                      labelText: "EatingHabits",
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
                                        final newStatus = EatingHabitsController.text.trim();
                                        if (newStatus.isNotEmpty) {
                                          Get.back();
                                          controller.addEatingHabits(name: EatingHabitsController.text);
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
                              MyText.bodyMedium("Add EatingHabits",color: Colors.white),
                            ],
                          ))
                      ],
                    ),
                  ),
                  source:
                      EatingHabitsDataSource(controller.EatingHabitsList, controller),
                  columns: [
                    DataColumn(
                      label: MyText.titleSmall('#', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Name', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Status', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Actions', fontWeight: 600),
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

class EatingHabitsDataSource extends DataTableSource {
  final List<EatingHabitsModel> eatingHabits;
  final EatingHabitsController controller;

  EatingHabitsDataSource(this.eatingHabits, this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= eatingHabits.length) return null;
    final EatingHabits = eatingHabits[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(MyText.titleSmall('${index + 1}')),    
        DataCell(MyText.titleSmall(EatingHabits.name)),
        DataCell(MyText.titleSmall(EatingHabits.isActive==true?"Active":"Inactive")),
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
                TextEditingController(text: EatingHabits.name);
              Get.dialog(
                Dialog(
                  backgroundColor: Colors.white,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 320),
                  child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    MyText.titleMedium("Edit EatingHabits"),
                    MySpacing.height(16),
                    TextFormField(
                      style: MyTextStyle.bodyMedium(),
                      controller: editController,
                      decoration: InputDecoration(
                      labelText: "EatingHabits Name",
                      border: OutlineInputBorder(),
                      ),
                    ),
                    MySpacing.height(8),
                    Row(
                    children: [
                      Expanded(
                      flex: 1,
                        child: DropdownButtonFormField<bool>(
                          value: EatingHabits.isActive,
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(

                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          items: [
                          DropdownMenuItem(
                            value: true,
                            child: MyText.bodyMedium("Active"),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: MyText.bodyMedium("Inactive"),
                          ),
                          ],
                          onChanged: controller.onEatingHabitStatusChanged
                        ),
                      ),
                    ],
                    ),
                    MySpacing.height(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      MyButton(
                        borderRadiusAll: 8,
                        padding: MySpacing.xy(16, 10),
                        child: MyText.bodyMedium("Cancel", color: Colors.white),
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
                          controller.editEatingHabits(EatingHabits.id, newName);
                           controller.editEatingHabitStatus(EatingHabits.id,controller.selectedEatingHabitStatus!);  
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
                .collection('EatingHabits')
                .doc(EatingHabits.id)
                .delete()
                .then((_) {
                Get.snackbar("Success", "EatingHabits deleted successfully");
                controller.fetchEatingHabits(); // Refresh list
              }).catchError((error) {
                Get.snackbar("Error", "Failed to delete EatingHabits: $error");
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
  int get rowCount => eatingHabits.length;

  @override
  int get selectedRowCount => 0;
}


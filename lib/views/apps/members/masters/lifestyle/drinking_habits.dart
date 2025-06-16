
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/profile_attributes/drinking_habits_controller.dart';
import 'package:webkit/helpers/theme/admin_theme.dart';
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
import 'package:webkit/models/drinking_habits_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class DrinkingHabits extends StatefulWidget {
  const DrinkingHabits({super.key});

  @override
  State<DrinkingHabits> createState() => _DrinkingHabitsState();
}

class _DrinkingHabitsState extends State<DrinkingHabits>with SingleTickerProviderStateMixin, UIMixin {
  late DrinkingHabitsController controller;
  TextEditingController drinkingHabitsController = TextEditingController();

  @override
  void initState() {
    controller = Get.put(DrinkingHabitsController());
    super.initState();
    controller.fetchDrinkingHabits();
  } 

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<DrinkingHabitsController>(builder: (controller) {
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
                  MyText.titleMedium("DrinkingHabits", fontWeight: 600),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: "Users"),
                      MyBreadcrumbItem(name: "DrinkingHabits", active: true),
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
                        MyText.titleMedium("All DrinkingHabits"),
                        Spacer(),
                        MyButton(
                          backgroundColor: contentTheme.primary,
                         borderRadiusAll: 10,
                          onPressed: () {
                            TextEditingController DrinkingHabitsController = TextEditingController();
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
                                    MyText.titleMedium("Add DrinkingHabits"),
                                    MySpacing.height(16),
                                    TextFormField(
                                    controller: DrinkingHabitsController,
                                    decoration: InputDecoration(
                                      labelText: "DrinkingHabits",
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
                                        final newStatus = DrinkingHabitsController.text.trim();
                                        if (newStatus.isNotEmpty) {
                                          Get.back();
                                          controller.addDrinkingHabits(name: DrinkingHabitsController.text);
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
                              MyText.bodyMedium("Add DrinkingHabits",color: Colors.white),
                            ],
                          ))
                      ],
                    ),
                  ),
                  source:
                      DrinkingHabitsDataSource(controller.DrinkingHabitsList, controller),
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

class DrinkingHabitsDataSource extends DataTableSource {
  final List<DrinkingHabitsModel> drinkingHabits;
  final DrinkingHabitsController controller;

  DrinkingHabitsDataSource(this.drinkingHabits, this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= drinkingHabits.length) return null;
    final DrinkingHabits = drinkingHabits[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(MyText.titleSmall('${index + 1}')),    
        DataCell(MyText.titleSmall(DrinkingHabits.name)),
        DataCell(MyText.titleSmall(DrinkingHabits.isActive==true?"Active":"Inactive")),
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
                TextEditingController(text: DrinkingHabits.name);
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
                    MyText.titleMedium("Edit DrinkingHabits"),
                    MySpacing.height(16),
                    TextFormField(
                      style: MyTextStyle.bodyMedium(),
                      controller: editController,
                      decoration: InputDecoration(
                      labelText: "DrinkingHabits Name",
                      border: OutlineInputBorder(),
                      ),
                    ),
                    MySpacing.height(8),
                    Row(
                    children: [
                      Expanded(
                      flex: 1,
                        child: DropdownButtonFormField<bool>(
                          value: DrinkingHabits.isActive,
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
                          onChanged: controller.onDrinkinghabitStatusChanged
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
                          controller.editDrinkingHabits(DrinkingHabits.id, newName);
                          controller.editDrinkinghabitStatus(DrinkingHabits.id,controller.selectedDrinkinghabitStatus!);
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
                .collection('DrinkingHabits')
                .doc(DrinkingHabits.id)
                .delete()
                .then((_) {
                Get.snackbar("Success", "DrinkingHabits deleted successfully");
                controller.fetchDrinkingHabits(); // Refresh list
              }).catchError((error) {
                Get.snackbar("Error", "Failed to delete DrinkingHabits: $error");
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
  int get rowCount => drinkingHabits.length;

  @override
  int get selectedRowCount => 0;
}


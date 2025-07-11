
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/subscription_packages%20/subcription_packages_controller.dart';
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
import 'package:webkit/models/packages_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({super.key});

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> with UIMixin{

  late SubcriptionPackagesController controller;
  TextEditingController packageName = TextEditingController();
  @override
  void initState() {
    controller = Get.put(SubcriptionPackagesController());
    super.initState();
    controller.fetchPackages();
  } 

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<SubcriptionPackagesController>(builder: (controller) {
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
                  MyText.titleMedium("All Packages", fontWeight: 600),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: "Packages", active: true),
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
                        MyText.titleMedium("Packages"),
                        Spacer(),
                        MyButton(
                          backgroundColor: contentTheme.primary,
                         borderRadiusAll: 10,
                          onPressed: () {
                            TextEditingController SubcriptionPackagesController = TextEditingController();
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
                                    MyText.titleMedium("Add Packages"),
                                    MySpacing.height(16),
                                    TextFormField(
                                    controller: SubcriptionPackagesController,
                                    decoration: InputDecoration(
                                      labelText: "Packages",
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
                                        final newStatus = SubcriptionPackagesController.text.trim();
                                        if (newStatus.isNotEmpty) {
                                          Get.back();
                                          controller.addPackages(range: SubcriptionPackagesController.text);
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
                              MyText.bodyMedium("Add Packages",color: Colors.white),
                            ],
                          ))
                      ],
                    ),
                  ),
                  source:
                      PackagesDataSource(controller.PackagesList, controller),
                  columns: [
                    DataColumn(
                      label: MyText.titleSmall('#', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Package Name', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Price', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Validity', fontWeight: 600),
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

class PackagesDataSource extends DataTableSource {
  final List<PackagesModel> packages;
  final SubcriptionPackagesController controller;

  PackagesDataSource(this.packages, this.controller);

  @override
DataRow? getRow(int index) {
  if (index >= packages.length) return null;
  final package = packages[index];
  return DataRow.byIndex(
    index: index,
    cells: [
      DataCell(MyText.titleSmall('${index + 1}')),
      DataCell(MyText.titleSmall(package.name)),
      DataCell(MyText.titleSmall('₹${package.price.toStringAsFixed(2)}')),
      DataCell(MyText.titleSmall(package.validity)),  
      DataCell(MyText.titleSmall(package.isActive ? "Active" : "Inactive")),
      DataCell(Row(
        children: [
          // Your existing edit + delete buttons
          MyButton(
            borderRadiusAll: 8,
            padding: MySpacing.xy(8, 8),
            backgroundColor: Colors.transparent,
            splashColor: Colors.grey.withOpacity(0.2),
            child: Icon(Icons.edit, size: 20, color: Colors.blue),
            onPressed: () {
              // open edit dialog
            },
          ),
          MyButton(
            borderRadiusAll: 8,
            padding: MySpacing.xy(8, 8),
            backgroundColor: Colors.transparent,
            splashColor: Colors.grey.withOpacity(0.2),
            child: Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: () async {
              // delete logic
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
  int get rowCount => packages.length;

  @override
  int get selectedRowCount => 0;
}


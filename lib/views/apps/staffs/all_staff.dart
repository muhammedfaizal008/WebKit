  import 'package:flutter/material.dart';
  import 'package:get/get_core/get_core.dart';
  import 'package:get/get_instance/get_instance.dart';
  import 'package:get/get_state_manager/src/simple/get_state.dart';
  import 'package:webkit/controller/apps/staffs/all_staff_controller.dart';
  import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
  import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
  import 'package:webkit/helpers/widgets/my_button.dart';
  import 'package:webkit/helpers/widgets/my_flex.dart';
  import 'package:webkit/helpers/widgets/my_flex_item.dart';
  import 'package:webkit/helpers/widgets/my_spacing.dart';
  import 'package:webkit/helpers/widgets/my_text.dart';
  import 'package:webkit/helpers/widgets/my_text_style.dart';
  import 'package:webkit/helpers/widgets/responsive.dart';
  import 'package:webkit/views/layouts/layout.dart';

  class AllStaff extends StatefulWidget {
    const AllStaff({super.key});

    @override
    State<AllStaff> createState() => _AllStaffState();
  }

  class _AllStaffState extends State<AllStaff> {
    late AllStaffController controller;
    @override
    void initState() {
      controller=Get.put(AllStaffController());
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
                          "All Staff",
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: "Staffs", active: false),
                            MyBreadcrumbItem(name: "All Staff", active: true),  
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(flexSpacing),
                  Padding(
                    padding: MySpacing.x(flexSpacing),
                    child: MyFlex(
                      contentPadding: false,
                      children: [
                        MyFlexItem(
                          sizes: "xxl-10 xl-10 lg-10 md-12 sm-12 xs-12",
                          child: Column(
                            children: [
                                controller.data == null
                                ? PaginatedDataTable(
                                    columns: staffTableColumns      ,
                                    source: EmptyDataTableSource(),

                                  ):
                                PaginatedDataTable(
                                  dividerThickness: 0,
                                  showEmptyRows: false,
                                  showCheckboxColumn: false,
                                  header: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32),  
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(maxWidth: 200),
                                            child: TextFormField(
                                              maxLines: 1,
                                              style: MyTextStyle.bodyMedium(),
                                              decoration: InputDecoration(
                                                hintText: "search...",
                                                hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                                
                                                contentPadding: MySpacing.xy(16, 12),
                                                isCollapsed: true,
                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                              ),
                                            ),
                                          ),
                                        ),
                                        MySpacing.width(16),
                                        MyButton(
                                          borderRadiusAll: 10,
                                          padding: MySpacing.xy(16, 12),
                                          child: MyText.bodyMedium(
                                            "Add Staff",
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                              
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  source: controller.data!,
                                  columns: [
                                    DataColumn(
                                      label: ConstrainedBox(
                                        constraints: BoxConstraints(minWidth: 120),
                                        child: MyText.titleSmall('#', fontWeight: 600),
                                      ),
                                    ),
                                    DataColumn(
                                      label: ConstrainedBox(
                                        constraints: BoxConstraints(minWidth: 120),
                                        child: MyText.titleSmall('Name', fontWeight: 600),
                                      ),
                                    ),
                                    DataColumn(
                                      label: ConstrainedBox(
                                        constraints: BoxConstraints(minWidth: 180),
                                        child: MyText.titleSmall('Email', fontWeight: 600),
                                      ),
                                    ),
                                    DataColumn(
                                      label: ConstrainedBox(
                                        constraints: BoxConstraints(minWidth: 110),
                                        child: MyText.titleSmall('Phone', fontWeight: 600),
                                      ),
                                    ),
                                    DataColumn(
                                      label: ConstrainedBox(
                                        constraints: BoxConstraints(minWidth: 100),
                                        child: MyText.titleSmall('Role', fontWeight: 600),
                                      ),
                                    ),
                                    DataColumn(
                                      label: ConstrainedBox(
                                        constraints: BoxConstraints(minWidth: 100),
                                        child: MyText.titleSmall('Options', fontWeight: 600),
                                      ),
                                    ),
                                    
                                  ],
                                  columnSpacing: 75, // Increased from 60 for wider columns
                                  horizontalMargin: 16, // Reduced from 28 to save space
                                  rowsPerPage: 10     ,

                                ),
                            ],
                          ),
                        ),
                          

                      ],
                    ),
                  ),
    

              ],
            );
          },
        ),
      );
    }
  }
  class EmptyDataTableSource extends DataTableSource {
    @override
    DataRow? getRow(int index) => null;

    @override
    bool get isRowCountApproximate => false;

    @override
    int get rowCount => 0;

    @override
    int get selectedRowCount => 0;
  }
  List<DataColumn> staffTableColumns = [
    DataColumn(label: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 120),
      child: MyText.titleSmall('#', fontWeight: 600),
    )),
    DataColumn(label: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 120),
      child: MyText.titleSmall('Name', fontWeight: 600),
    )),
    DataColumn(label: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 180),
      child: MyText.titleSmall('Email', fontWeight: 600),
    )),
    DataColumn(label: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 110),
      child: MyText.titleSmall('Phone', fontWeight: 600),
    )),
    DataColumn(label: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 100),
      child: MyText.titleSmall('Role', fontWeight: 600),
    )),
    DataColumn(label: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 100),
      child: MyText.titleSmall('Options', fontWeight: 600),
    )),
  ];


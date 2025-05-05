import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webkit/controller/apps/members/profile_attributes/religion_controller.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/models/religion_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class Religion extends StatefulWidget {
  const Religion({super.key});

  @override
  State<Religion> createState() => _ReligionState();
}

class _ReligionState extends State<Religion> {
  late ReligionController controller;
  @override
  void initState() {
    controller = Get.put(ReligionController()); 
    super.initState();
    controller.fetchReligions();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<ReligionController  >(
          
          builder: (controller) => Column(
                children: [
                  Padding(
                    padding: MySpacing.x(flexSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.titleMedium(
                          "Religion",
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: "Users"),
                            MyBreadcrumbItem(name: "Religion", active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(20),
                  MyFlex(children: [
                    MyFlexItem(
                      sizes: "lg-3 md-6 sm-12 xs-12",
                      child: PaginatedDataTable(
                                dividerThickness: 0,
                                showEmptyRows: false,
                                showCheckboxColumn: false,
                                header: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context)
                                              .size
                                              .width -
                                          32), // Account for horizontalMargin
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxWidth: 200),
                                          child: TextFormField(
                                            maxLines: 1,
                                            style: MyTextStyle.bodyMedium(),
                                            decoration: InputDecoration(
                                              hintText: "search...",
                                              hintStyle: MyTextStyle.bodySmall(
                                                  xMuted: true),
                                              
                                              contentPadding:
                                                  MySpacing.xy(16, 12),
                                              isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                            ),
                                          ),
                                        ),
                                      ),
                                      MySpacing.width(16),
                                      MyButton(
                                        borderRadiusAll: 10,
                                        padding: MySpacing.xy(16, 12),
                                        child: MyText.bodyMedium(
                                          "Add Religion",
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
                                      constraints:
                                          BoxConstraints(minWidth: 180),
                                      child: MyText.titleSmall('#', 
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth: 120),
                                      child: MyText.titleSmall('Name',
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth: 120),
                                      child: MyText.titleSmall('Options',
                                          fontWeight: 600),
                                    ),
                                  ),  
                                ],
                                columnSpacing:
                                    70, // Increased from 60 for wider columns
                                horizontalMargin:
                                    16, // Reduced from 28 to save space
                                rowsPerPage: 10,
                              ),
                      )
                  ])
                ],
              )),
    );
  }
}
class ReligionDataSource extends DataTableSource {
  final List<ReligionModel> religions;

  ReligionDataSource(this.religions);

  @override
  DataRow? getRow(int index) {
    if (index >= religions.length) return null;
    final religion = religions[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(Text(religion.name)),
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, size: 20),
              onPressed: () {
                // Implement edit logic
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, size: 20),
              onPressed: () {
                // Implement delete logic
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
  int get rowCount => religions.length;

  @override
  int get selectedRowCount => 0;
}

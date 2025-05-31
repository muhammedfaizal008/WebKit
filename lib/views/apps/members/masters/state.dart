

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:lucide_icons/lucide_icons.dart';
  import 'package:webkit/controller/apps/members/profile_attributes/states_controller.dart';
  import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
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
  import 'package:webkit/models/states_model.dart';
  import 'package:webkit/views/layouts/layout.dart';

  class States extends StatefulWidget {
    const States({super.key});

    @override
    State<States> createState() => _StatesState();
  }

  class _StatesState extends State<States> with UIMixin{
    late StatesController controller;
    TextEditingController statesController = TextEditingController();
    @override
    void initState() {
      controller = Get.put(StatesController());
      super.initState();
      controller.fetchCountriesAndStates();
    } 

    @override
    Widget build(BuildContext context) {
      return Layout(
        child: GetBuilder<StatesController>(builder: (controller) {
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
                    MyText.titleMedium("States", fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Users"),
                        MyBreadcrumbItem(name: "States", active: true),
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
                          MyText.titleMedium("All States"),
                          Spacer(),
                          MyButton(
                            backgroundColor: contentTheme.primary,
                         borderRadiusAll: 10,
                            onPressed: () {
                              TextEditingController addstatesController =
                                  TextEditingController();
                              String selectedCountry = "Select Country";
                              String selectedState = "Select state";
                              List<StatesModel> filteredstates = [];
                                Get.dialog(
                                Dialog(
                                  backgroundColor: theme.cardColor,
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 320),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              MyText.titleMedium("Add State"),
                                              MySpacing.height(16),

                                              // countryList Popup Menu
                                              MyContainer.bordered(
                                                paddingAll: 8,
                                                child: PopupMenuButton<String>(
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return controller.countryList
                                                        .map((countryList) {
                                                      return PopupMenuItem<
                                                          String>(
                                                        value: countryList.name,
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                          child: MyText.bodySmall(
                                                            countryList.name,
                                                            color: theme
                                                                .colorScheme
                                                                .onSurface,
                                                            fontWeight: 600,
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          setState(() {
                                                            selectedCountry = countryList.name;
                                                            // Clear any previous state selection
                                                            selectedState = "Select state";
                                                            filteredstates = [];
                                                          });
                                                          
                                                          // Fetch states for the selected country
                                                          final states = await controller.getStatesByCountry(countryList.name);
                                                          setState(() {
                                                            filteredstates = states;
                                                          });
                                                        },  
                                                      );
                                                    }).toList();
                                                  },
                                                  position:
                                                      PopupMenuPosition.under,
                                                  offset: const Offset(0, 0),
                                                  color: theme.cardTheme.color,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      MyText.labelMedium(
                                                        selectedCountry,
                                                        color: theme.colorScheme
                                                            .onSurface,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Icon(
                                                        LucideIcons.chevronDown,
                                                        size: 22,
                                                        color: theme.colorScheme
                                                            .onSurface,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              MySpacing.height(10),

                                              // State Popup Menu (only visible when countryList is selected)
                                              if (selectedCountry !=
                                                  "Select country")
                                                TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter your name';
                                                    }
                                                    return null;
                                                  },
                                                  controller: addstatesController,
                                                  style: MyTextStyle.labelMedium(),
                                                  decoration: InputDecoration(
                                                      hintText: "Enter State",
                                                      hintStyle:
                                                          MyTextStyle.bodySmall(
                                                              xMuted: true),
                                                      border:
                                                          OutlineInputBorder(),
                                                      enabledBorder:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(),
                                                      contentPadding:
                                                          MySpacing.all(16),
                                                      isCollapsed: true,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never,
                                                      errorStyle: TextStyle(
                                                          fontSize: 10)),
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
                                                      final newStateName = addstatesController.text.trim();
                                                      if (newStateName.isNotEmpty && selectedCountry != "Select Country") {
                                                        Get.back();
                                                        await controller.addState(
                                                          countryName: selectedCountry,
                                                          stateName: newStateName
                                                        );
                                                      } else {
                                                        Get.snackbar("Error", "Please select a country and enter a state name");
                                                      }
                                                    },  
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );;
                            },
                            child:Row(
                              children: [
                                Icon(LucideIcons.userPlus,color: Colors.white,),
                              MySpacing.width(10),
                                MyText.bodyMedium("Add States",color: Colors.white),
                              ],
                            ))
                        ],
                      ),
                    ),
                    source:
                        StatesDataSource(controller.statesList, controller,controller.countryNames  ),
                    columns: [
                      DataColumn(label: MyText.titleSmall('#', fontWeight: 600)),
                      DataColumn(label: MyText.titleSmall('Country', fontWeight: 600)),
                      DataColumn(label: MyText.titleSmall('State', fontWeight: 600)),
                      DataColumn(label: MyText.titleSmall('Options', fontWeight: 600)),
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

  class StatesDataSource extends DataTableSource {
  final List<StatesModel> states;
  final StatesController controller;
  final Map<String, String> countryNames;

  StatesDataSource(this.states, this.controller, this.countryNames);

  @override
  DataRow? getRow(int index) {
    if (index >= states.length) return null;
    final state = states[index];
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(MyText.titleSmall('${index + 1}')),
        DataCell(MyText.titleSmall(countryNames[state.countryId] ?? "Unknown")),
        DataCell(MyText.titleSmall(state.name)),
        DataCell(Row(
          children: [
            MyButton(
              borderRadiusAll: 8,
              padding: MySpacing.xy(8, 8),
              backgroundColor: Colors.transparent,
              splashColor: Colors.grey.withOpacity(0.2),
              child: Icon(Icons.edit, size: 20, color: Colors.blue),
              onPressed: () => _showEditDialog(state),
            ),
            MySpacing.width(8),
            MyButton(
              borderRadiusAll: 8,
              padding: MySpacing.xy(8, 8),
              backgroundColor: Colors.transparent,
              splashColor: Colors.grey.withOpacity(0.2),
              child: Icon(Icons.delete, size: 20, color: Colors.red),
              onPressed: () async => await controller.deleteState(state.id, state.countryId),
            ),
          ],
        )),
      ],
    );
  }

  void _showEditDialog(StatesModel state) {
    final editController = TextEditingController(text: state.name);
    
    Get.dialog(
      Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 320),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText.titleMedium("Edit State"),
                MySpacing.height(16),
                TextFormField(
                  controller: editController,
                  style: MyTextStyle.bodySmall(),
                  decoration: InputDecoration(
                    labelText: "State Name",
                    labelStyle: MyTextStyle.bodySmall(),
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
                      onPressed: () => Get.back(),
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
                          await controller.editState(state.id, newName, state.countryId);
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
  }


  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => states.length;

  @override
  int get selectedRowCount => 0;
}


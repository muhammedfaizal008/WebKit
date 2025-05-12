import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/profile_attributes/caste_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart' show MyContainer;
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/models/caste_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class Caste extends StatefulWidget {
  const Caste({super.key});

  @override
  State<Caste> createState() => _CasteState();
}

class _CasteState extends State<Caste> {
  late CasteController controller;
  TextEditingController casteController = TextEditingController();
  @override
  void initState() {
    controller = Get.put(CasteController());
    super.initState();
    controller.fetchcastes();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<CasteController>(builder: (controller) {
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
                  MyText.titleMedium("castes", fontWeight: 600),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: "Users"),
                      MyBreadcrumbItem(name: "caste", active: true),
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
                        MyText.titleMedium("All Castes"),
                        Spacer(),
                        // In your Caste widget (dialog part)
                        MyButton(
                          onPressed: () {
                            TextEditingController addCasteController =
                                TextEditingController();
                            String selectedReligion = "Select Religion";
                            String selectedCaste = "Select Caste";
                            List<CasteModel> filteredCastes = [];

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
                                            MyText.titleMedium("Add Caste"),
                                            MySpacing.height(16),

                                            // Religion Popup Menu
                                            MyContainer.bordered(
                                              paddingAll: 8,
                                              child: PopupMenuButton<String>(
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return controller.religionList
                                                      .map((religion) {
                                                    return PopupMenuItem<
                                                        String>(
                                                      value: religion.name,
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: MyText.bodySmall(
                                                          religion.name,
                                                          color: theme
                                                              .colorScheme
                                                              .onSurface,
                                                          fontWeight: 600,
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        // When religion is selected, fetch its castes
                                                        filteredCastes =
                                                            await controller
                                                                .getCastesByReligion(
                                                                    religion
                                                                        .id);
                                                        setState(() {
                                                          selectedReligion =
                                                              religion.name;
                                                          selectedCaste =
                                                              "Select Caste"; // Reset caste selection
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
                                                      selectedReligion,
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

                                            // Caste Popup Menu (only visible when religion is selected)
                                            if (selectedReligion !=
                                                "Select Religion")
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter your name';
                                                  }
                                                  return null;
                                                },
                                                controller: addCasteController,
                                                decoration: InputDecoration(
                                                    hintText: "Enter caste",
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
                                                    final newCasteName =
                                                        addCasteController.text
                                                            .trim();
                                                    if (newCasteName
                                                            .isNotEmpty &&
                                                        selectedReligion !=
                                                            "Select Religion") {
                                                      // Call the controller's addCaste method with the selected religion and new caste name
                                                      Get.back();
                                                      await controller.addCaste(
                                                          newCasteName,
                                                          selectedReligion);
                                                    } else {
                                                      Get.snackbar("Error",
                                                          "Please select a religion and enter a caste name");
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
                            );
                          },
                          child: MyText.bodyMedium("Add Caste",
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  source: controller.data!,
                  columns: [
                    DataColumn(
                      label: MyText.titleSmall('#', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Religion', fontWeight: 600),
                    ),
                    DataColumn(
                      label: MyText.titleSmall('Caste', fontWeight: 600),
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
      }),
    );
  }
}

class casteDataSource extends DataTableSource {
  final List<CasteModel> castes;
  final CasteController controller;

  casteDataSource(this.castes, this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= castes.length) return null;
    final caste = castes[index];

    // Fetch religion name dynamically using the religionId
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(MyText.titleSmall('${index + 1}')),
        // Fetch the religion name using the religionId
        DataCell(FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection(
                  'Religion') // Assuming you have a collection for religions
              .doc(caste.religionId) // The religionId from the caste model
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MyText.bodySmall("Loading...");
            }
            if (snapshot.hasError) {
              return MyText.bodySmall("Error loading religion");
            }
            if (snapshot.hasData && snapshot.data != null) {
              var religionDoc = snapshot.data!;
              var religionName =
                  religionDoc['name']; // Assuming 'name' is the field
              return MyText.titleSmall(religionName ?? "Unknown");
            } else {
              return MyText.bodySmall("No religion found");
            }
          },
        )),
        DataCell(MyText.titleSmall(caste.name)),
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
                    TextEditingController(text: caste.name);
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
                            MyText.titleMedium("Edit Caste"),
                            MySpacing.height(16),
                            TextFormField(
                              controller: editController,
                              style: MyTextStyle.labelMedium()     ,
                              decoration: InputDecoration(
                                labelText: "Caste Name",
                                labelStyle: MyTextStyle.labelMedium(),
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
                                      controller.editCaste(
                                          caste.religionId, caste.id, newName);
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
            MyButton(
                borderRadiusAll: 8,
                padding: MySpacing.xy(8, 8),
                backgroundColor: Colors.transparent,
                splashColor: Colors.grey.withOpacity(0.2),
                child: Icon(Icons.delete, size: 20, color: Colors.red),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection(
                          'Religion') // Access the 'Religion' collection
                      .doc(caste.religionId) // Use the 'religionId' of the caste
                      .collection('castes') // Access the 'castes' subcollection under that religion
                      .doc(caste
                          .id) // Use the 'id' of the caste document to delete it
                      .delete()
                      .then((_) {
                    Get.snackbar("Success", "Caste deleted successfully");
                  }).catchError((error) {
                    Get.snackbar("Error", "Failed to delete caste: $error");
                  });
                  controller
                      .fetchcastes(); // Refresh the caste list after deletion
                }),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => castes.length;

  @override
  int get selectedRowCount => 0;
}

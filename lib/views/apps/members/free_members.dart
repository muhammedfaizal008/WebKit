import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/apps/members/free_members_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/utils/utils.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/models/user_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class FreeMembers extends StatefulWidget {
  const FreeMembers({super.key});

  @override
  State<FreeMembers> createState() => _FreeMembersState();
}

class _FreeMembersState extends State<FreeMembers>
    with SingleTickerProviderStateMixin, UIMixin {
  late FreeMembersController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FreeMembersController());
    controller.listenToUserUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
          init: controller,
          builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: MySpacing.x(flexSpacing),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.titleMedium(
                        "Free Users",
                        fontWeight: 600,
                      ),
                      MyBreadcrumb(
                        children: [
                          MyBreadcrumbItem(name: "Users"),
                          MyBreadcrumbItem(name: "Free Users", active: true),
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
                        sizes: "xxl-12 xl-12 lg-12 md-12 sm-12 xs-12",
                        child: Column(
                          children: [
                            if (controller.data != null)
                              PaginatedDataTable(
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
                                              border: outlineInputBorder,
                                              enabledBorder: outlineInputBorder,
                                              focusedBorder: focusedInputBorder,
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
                                          "Add User",
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Get.toNamed("/user/add_member");
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
                                          BoxConstraints(minWidth: 120),
                                      child: MyText.titleSmall('Name',
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth: 120),
                                      child: MyText.titleSmall('Phone Number',
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth: 180),
                                      child: MyText.titleSmall('Email',
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth: 110),
                                      child: MyText.titleSmall('Profession',
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth: 100),
                                      child: MyText.titleSmall('Created At',
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth: 100),
                                      child: MyText.titleSmall('Updated At',
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth: 100),
                                      child: MyText.titleSmall('Subscription',
                                          fontWeight: 600),
                                    ),
                                  ),
                                  DataColumn(
                                    label: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(minWidth:  80),
                                      child: MyText.titleSmall('Actions',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class UsersDataTable extends DataTableSource with UIMixin {
  final BuildContext context;
  final List<UserModel> users;
  final void Function(UserModel) onRowSelect;

  UsersDataTable(this.context, this.users, this.onRowSelect);

  @override
  DataRow getRow(int index) {
    final user = users[index];

    return DataRow(
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelect(user);  
        }
        _showUserDetails(user);
      },
      cells: [
        DataCell(
            MyText.titleMedium(user.fullName ?? "No name", fontWeight: 600)),
        DataCell(MyText.bodyMedium(user.phoneNumber ?? "No phone")),
        DataCell(MyText.bodyMedium(user.email ?? "No email")),
        DataCell(MyText.bodyMedium(user.profession ?? "-")),
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(user.createdAt, showMonthShort: true),
        )),
        DataCell(MyText.bodyMedium(
          user.updatedAt != null
              ? Utils.getDateStringFromDateTime(user.updatedAt!,
                  showMonthShort: true)
              : "-",
        )),
        DataCell(MyText.bodyMedium(user.subscription ?? "-"   )),
        DataCell(
          Row(
            children: [
              MyButton(
                onPressed: () {
                  _deleteUser(user.toMap());
                },
                padding: MySpacing.xy(16, 12),
                backgroundColor: Colors.red,
                borderRadiusAll: 8,
                child: Icon(Icons.delete, color: Colors.white),
              ),
              MySpacing.width(16),
              MyButton(
                onPressed: () {
                  Get.toNamed("/user/edit_member", arguments: user.toMap());
                },
                padding: MySpacing.xy(16, 12),
                backgroundColor: contentTheme.primary,
                borderRadiusAll: 8,
                child: Icon(Icons.edit, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _deleteUser(Map<String, dynamic> user) {
    // Logic to delete the user
    FirebaseFirestore.instance
        .collection('users')
        .doc(user['id'])
        .delete()
        .then((_) {
      // Optionally, show a confirmation dialog or feedback message
      Get.snackbar("Success", "User deleted successfully");
    }).catchError((error) {
      // Handle errors in deleting the user
      Get.snackbar("Error", "Failed to delete user: $error");
    });
  }

  void _showUserDetails(UserModel user) {
    // Show a dialog box with user details
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with avatar
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 46,
                            backgroundColor: Colors.grey.shade400,
                            child: Icon(
                              Icons.person,
                              size: 42,
                              color: contentTheme.primary,
                            ),
                          ),
                        ),
                        MySpacing.height(16),
                        MyText.titleLarge(
                          user.fullName,
                          fontWeight: 700,
                          color: Colors.black87,
                        ),
                        MySpacing.height(4),
                      ],
                    ),
                  ),

                  // Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Personal Information Section
                          _buildSectionTitle("Personal Information"),
                          MySpacing.height(12),
                          _buildInfoCard([
                            _buildDetailRow("Email", user.email),
                            _buildDetailRow("Phone Number", user.phoneNumber),
                            _buildDetailRow(
                                "Profession", user.profession ?? "-"),
                            _buildDetailRow("Age", user.age.toString()),
                            _buildDetailRow("Gender", user.gender ?? "-"),
                            _buildDetailRow("Location", user.location ?? "-"),
                          ]),

                          MySpacing.height(24),

                          // Background Section
                          _buildSectionTitle("Background"),
                          MySpacing.height(12),
                          _buildInfoCard([
                            _buildDetailRow(
                                "Marital Status", user.maritalStatus ?? "-"),
                            _buildDetailRow("Religion", user.religion ?? "-"),
                            _buildDetailRow("Caste", user.caste ?? "-"),
                            _buildDetailRow(
                                "Mother Tongue", user.language ?? "-"),
                          ]),

                          MySpacing.height(24),

                          // Partner Preferences Section
                          _buildSectionTitle("Partner Preferences"),
                          MySpacing.height(12),
                          _buildInfoCard([
                            _buildDetailRow("For Whom", user.forWhom ?? "-"),
                            _buildDetailRow(
                                "Partner Age", user.partnerAge.toString()),
                            _buildDetailRow("Partner Education",
                                user.partnerEducation ?? "-"),
                            _buildDetailRow("Partner Profession",
                                user.partnerProfession ?? "-"),
                            _buildDetailRow("Partner Location",
                                user.partnerLocation ?? "-"),
                          ]),

                          MySpacing.height(24),

                          // About Me Section
                          _buildSectionTitle("About Me"),
                          MySpacing.height(12),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: MyText.bodyMedium(
                              user.aboutMe ?? "-",
                              color: Colors.black87,
                            ),
                          ),

                          MySpacing.height(16),

                          // Account Info Section
                          _buildSectionTitle("Account Info"),
                          MySpacing.height(12),
                          _buildInfoCard([
                            _buildDetailRow(
                                "Created At",
                                Utils.getDateStringFromDateTime(
                                  user.createdAt,
                                  showMonthShort: true,
                                )),
                            _buildDetailRow(
                                "Updated At",
                                user.updatedAt != null
                                    ? Utils.getDateStringFromDateTime(
                                        user.updatedAt!,
                                        showMonthShort: true)
                                    : "-"),
                          ]),
                        ],
                      ),
                    ),
                  ),

                  // Actions
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border(top: BorderSide(color: Colors.grey.shade200)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            side: BorderSide(
                                color: contentTheme.primary.withOpacity(0.5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: MyText.bodyMedium(
                            'Close',
                            color: contentTheme.primary,
                          ),
                        ),
                        MySpacing.width(16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Get.toNamed("/user/edit_member",
                                arguments: user.toMap());
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            backgroundColor: contentTheme.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit, size: 18),
                              MySpacing.width(8),
                              MyText.bodyMedium(
                                'Edit User',
                                color: Colors.white,
                                fontWeight: 600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        MyText.titleMedium(
          title,
          fontWeight: 700,
          color: contentTheme.primary,
        ),
        MySpacing.width(8),
        Expanded(
          child: Divider(
            color: contentTheme.primary.withOpacity(0.2),
            thickness: 1,
          ),
        ),
      ],
    );
  }

// Helper method to build info cards
  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(children.length * 2 - 1, (index) {
          if (index % 2 == 0) {
            return children[index ~/ 2];
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: Colors.grey.shade200,
                height: 1,
              ),
            );
          }
        }),
      ),
    );
  }

// Helper method to build detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: MyText.bodyMedium(
              '$label:',
              fontWeight: 600,
              color: Colors.grey.shade700,
            ),
          ),
          Expanded(
            child: MyText.bodyMedium(
              value,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  int get rowCount => users.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

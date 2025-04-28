import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/free_members_controller.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/utils/utils.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/images.dart';
import 'package:webkit/models/contacts.dart';
import 'package:webkit/views/layouts/layout.dart';

class FreeMembers extends StatefulWidget {
  const FreeMembers({super.key});

  @override
  State<FreeMembers> createState() => _FreeMembersState();
}

class _FreeMembersState extends State<FreeMembers> with SingleTickerProviderStateMixin, UIMixin {
  late FreeMembersController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FreeMembersController());
    controller.listenToUserUpdates( );
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
    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32), // Account for horizontalMargin
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
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: focusedInputBorder,
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
        constraints: BoxConstraints(minWidth: 120),
        child: MyText.titleMedium('Name', fontWeight: 600),
      ),
    ),
    DataColumn(
      label: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 140),
        child: MyText.titleMedium('Phone Number', fontWeight: 600),
      ),
    ),
    DataColumn(
      label: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 180),
        child: MyText.titleMedium('Email', fontWeight: 600),
      ),
    ),
    DataColumn(
      label: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 140),
        child: MyText.titleMedium('Profession', fontWeight: 600),
      ),
    ),
    DataColumn(
      label: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 120),
        child: MyText.titleMedium('Created At', fontWeight: 600),
      ),
    ),
    DataColumn(
      label: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 120),
        child: MyText.titleMedium('Updated At', fontWeight: 600),
      ),
    ),
    DataColumn(
      label: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 100),
        child: MyText.titleMedium('Actions', fontWeight: 600),
      ),
    ),
  ],
  columnSpacing: 80, // Increased from 60 for wider columns
  horizontalMargin: 16, // Reduced from 28 to save space
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
  final List<Map<String, dynamic>> users;
  final void Function(Map<String, dynamic>) onRowSelect;

  UsersDataTable(this.context,  this.users, this.onRowSelect);

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
        DataCell(MyText.titleMedium(user['fullName'] ?? '-', fontWeight: 600)),
        DataCell(MyText.bodyMedium(user['phoneNumber'] ?? '-')),
        DataCell(MyText.bodyMedium(user['email'] ?? '-')),
        DataCell(MyText.bodyMedium(user['profession'] ?? '-')),
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(
            (user['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
            showMonthShort: true,
          ),
        )),
        DataCell(MyText.bodyMedium(Utils.getDateStringFromDateTime(
            (user['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
            showMonthShort: true,
          ),)),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  // Navigate to the edit screen with user data
                  // Get.toNamed("/user/edit", arguments: user);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Add logic for deleting the user
                  _deleteUser(user);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _deleteUser(Map<String, dynamic> user) {
    // Logic to delete the user
    FirebaseFirestore.instance.collection('users').doc(user['id']).delete().then((_) {
      // Optionally, show a confirmation dialog or feedback message
      Get.snackbar("Success", "User deleted successfully");
    }).catchError((error) {
      // Handle errors in deleting the user
      Get.snackbar("Error", "Failed to delete user: $error");
    });
  }

  void _showUserDetails(Map<String, dynamic> user) {
  // Show a dialog box with user details
  showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: MyText.titleLarge(
        'User Details',
        fontWeight: 600,
        color: contentTheme.primary,
      ),
      content: SingleChildScrollView(
        child: MyFlexItem(
          sizes: "lg-12 md-12 sm-12",
          child: MyContainer(
            paddingAll: 16,
            borderRadiusAll: 8,
            color: Colors.grey.shade50,
            //  
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [ 
                  Center(
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.person,
                        size: 36,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                MySpacing.height(16),
                MyText.titleMedium(
                  user['fullName'] ?? '-',
                  fontWeight: 600,
                  color: Colors.black,
                ),
                MySpacing.height(12),
                _buildDetailRow("Phone Number", user['phoneNumber'] ?? '-'),
                MySpacing.height(8),
                _buildDetailRow("Email", user['email'] ?? '-'),
                MySpacing.height(8),
                _buildDetailRow("Profession", user['profession'] ?? '-'),
                MySpacing.height(8),
                _buildDetailRow(
                  "Created At",
                  Utils.getDateStringFromDateTime(
                    (user['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
                    showMonthShort: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        MyButton.text(
          onPressed: () {
            Navigator.of(context).pop();
          },
          padding: MySpacing.xy(12, 8),
          child: MyText.bodyMedium(
            'Close',
            color: contentTheme.secondary,
          ),
        ),
        MyButton(
          onPressed: () {
            Get.toNamed("/user/edit", arguments: user);
            Navigator.of(context).pop();
          },
          padding: MySpacing.xy(16, 12),
          borderRadiusAll: 8,
          backgroundColor: contentTheme.primary,
          child: MyText.bodyMedium(
            'Edit User',
            color: Colors.white,
            fontWeight: 600,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      contentPadding: MySpacing.xy(16, 20),
    );
  },
);
}
  // Helper method to build detail rows
Widget _buildDetailRow(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MyText.bodyMedium(
        '$label:',
        fontWeight: 600,
        muted: true,
        color: Colors.grey.shade600,
      ),
      MySpacing.width(12),
      Expanded(
        child: MyText.bodyMedium(
          value,
          color: Colors.black87,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}


  @override
  int get rowCount => users.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}



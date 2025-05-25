import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
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

  void _showUserDetails(UserModel user) {
    final context = Get.context!;
    showDialog(
      context: context,
      builder: (context) => _buildUserDetailsDialog(context, user),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(FreeMembersController());
    controller.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<FreeMembersController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("All Customers", fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Customers"),
                        MyBreadcrumbItem(name: "All Customers", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User type buttons
                    _buildUserTypeButtons(controller),
                    MySpacing.height(16),
                    // Main content
                    _buildMainContent(controller),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserTypeButtons(FreeMembersController controller) {
    return Row(
      children: [
        _buildUserTypeButton(
          color: Colors.blue,
          icon: Icons.person,
          label: "Free Users (${controller.freeUsers})",
        ),
        MySpacing.width(12),
        _buildUserTypeButton(
          color: Colors.green,
          icon: Icons.star,
          label: "Premium Users (${controller.premiumUsers})",
        ),
        MySpacing.width(12),
        _buildUserTypeButton(
          color: Colors.red,
          icon: Icons.block,
          label: "Blocked Users (0)",
        ),
      ],
    );
  }

  Widget _buildMainContent(FreeMembersController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No users found',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        _buildTableHeader(controller),
        _buildDataTable(controller),
      ],
    );
  }

  Widget _buildTableHeader(FreeMembersController controller) {
    return MyFlex(
      children: [
        MyFlexItem(
          sizes: "lg-12",
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Row(
          children: [
            MyText.titleMedium("All Customers", fontWeight: 600),
            const Spacer(),
            _buildPaginationControls(controller),
            MySpacing.width(16),
            _buildAddUserButton(),
          ],
        ),
      ),)
      ],
    );
  }

  Widget _buildPaginationControls(FreeMembersController controller) {
    return Row(
      children: [
        MyText.bodySmall(
          "Showing ${controller.currentPageStartIndex}-${controller.currentPageEndIndex} of ${controller.totalRecords}",
          color: Colors.grey.shade600,
        ),
        MySpacing.width(16),
        _buildRowsPerPageDropdown(controller),
        MySpacing.width(16),
        _buildPageNavigationButtons(controller),
      ],
    );
  }

  Widget _buildRowsPerPageDropdown(FreeMembersController controller) {
    return DropdownButton<int>(
      value: controller.rowsPerPage,
      items: const [4, 10, 20].map((value) {
        return DropdownMenuItem<int>(
          value: value,
          child: MyText.bodyMedium("$value per page"),
        );
      }).toList(),
      onChanged: (value) => controller.onRowsPerPageChanged(value ?? 4),
      underline: Container(),
    );
  }

  Widget _buildPageNavigationButtons(FreeMembersController controller) {
    return Row(
      children: [
        IconButton(
          onPressed: controller.canGoToPrevious ? controller.goToFirstPage : null,
          icon: const Icon(Icons.first_page),
          tooltip: "First page",
        ),
        IconButton(
          onPressed: controller.canGoToPrevious ? controller.goToPreviousPage : null,
          icon: const Icon(Icons.chevron_left),
          tooltip: "Previous page",
        ),
        _buildPageIndicator(controller),
        IconButton(
          onPressed: controller.canGoToNext ? controller.goToNextPage : null,
          icon: const Icon(Icons.chevron_right),
          tooltip: "Next page",
        ),
        IconButton(
          onPressed: controller.canGoToNext ? controller.goToLastPage : null,
          icon: const Icon(Icons.last_page),
          tooltip: "Last page",
        ),
      ],
    );
  }

  Widget _buildPageIndicator(FreeMembersController controller) {
    return GestureDetector(
      onTap: () => _showPageJumpDialog(context, controller),
      child: Container(
        child: MyText.bodyMedium(
          "${controller.currentPage + 1} of ${controller.totalPages}",
          fontWeight: 600,
          color: contentTheme.primary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: contentTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: contentTheme.primary.withOpacity(0.3)),
        
      ),
    )
    );
  }

  Widget _buildAddUserButton() {
    return MyButton(
      backgroundColor: contentTheme.primary,
      borderRadiusAll: 8,
      padding: MySpacing.xy(16, 12),
      child: Row(
        children: [
          const Icon(Icons.person_add, color: Colors.white, size: 20),
          MySpacing.width(8),
          MyText.bodyMedium(
            "Add New User",
            color: Colors.white,
            fontWeight: 600,
          ),
        ],
      ),
      onPressed: () => Get.toNamed("/user/add_member"),
    );
  }

  Widget _buildDataTable(FreeMembersController controller) {
    return MyFlex(
      children: [
        MyFlexItem(
          sizes: "lg-12",
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
              color: Colors.white,
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dataTableTheme: DataTableThemeData(
                  decoration: const BoxDecoration(color: Colors.white),
                  dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => states.contains(MaterialState.selected)
                        ? contentTheme.primary.withOpacity(0.1)
                        : Colors.white,
                  ),
                  headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
                ),
              ),
              child: DataTable(
                columns:  [
                  DataColumn(label: MyText.bodyMedium("Name")),
                  DataColumn(label: MyText.bodyMedium('Phone')),
                  DataColumn(label: MyText.bodyMedium('Email')),
                  DataColumn(label: MyText.bodyMedium('Created At')),
                  DataColumn(label: MyText.bodyMedium('Subscription')),
                  DataColumn(label: MyText.bodyMedium('Actions')),
                ],
                rows: controller.users.map((user) => _buildUserRow(user)).toList(),
                columnSpacing: 32,
                showCheckboxColumn: false,
                headingRowHeight: 56,
                dataRowHeight: 72,
              ),
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildUserRow(UserModel user) {
    return DataRow(
      cells: [
        DataCell(MyText.titleMedium(user.fullName, fontWeight: 600)),
        DataCell(MyText.bodyMedium(user.phoneNumber)),
        DataCell(MyText.bodyMedium(user.email)),
        DataCell(MyText.bodyMedium(
          user.createdAt != null
              ? Utils.getDateStringFromDateTime(user.createdAt!, showMonthShort: true)
              : '-',
        )),
        DataCell(MyText.bodyMedium(user.subscription ?? '-')),
        DataCell(_buildActionButtons(user)),
      ],
      onSelectChanged: (_) => _showUserDetails(user),
    );
  }

  Widget _buildActionButtons(UserModel user) {
    return Row(
      children: [
        MyButton(
          onPressed: () => _deleteUser(user),
          padding: MySpacing.xy(16, 12),
          backgroundColor: Colors.red,
          borderRadiusAll: 8,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        MySpacing.width(16),
        MyButton(
          onPressed: () => Get.toNamed("/user/edit_member", arguments: user.toMap()),
          padding: MySpacing.xy(16, 12),
          backgroundColor: contentTheme.primary,
          borderRadiusAll: 8,
          child: const Icon(Icons.edit, color: Colors.white),
        ),
      ],
    );
  }
  Widget _buildUserDetailsDialog(BuildContext context, UserModel user) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        _buildDetailRow("Profession", user.profession ?? "-"),
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
                        _buildDetailRow("Mother Tongue", user.language ?? "-"),
                      ]),

                      MySpacing.height(24),

                      // Partner Preferences Section
                      _buildSectionTitle("Partner Preferences"),
                      MySpacing.height(12),
                      _buildInfoCard([
                        _buildDetailRow("For Whom", user.forWhom ?? "-"),
                        _buildDetailRow(
                            "Partner Age", user.partnerAge.toString()),
                        _buildDetailRow(
                            "Partner Education", user.partnerEducation ?? "-"),
                        _buildDetailRow("Partner Profession",
                            user.partnerProfession ?? "-"),
                        _buildDetailRow(
                            "Partner Location", user.partnerLocation ?? "-"),
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
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
  void _deleteUser(UserModel user) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .delete()
        .then((_) {
      Get.snackbar("Success", "User deleted successfully");
      // Refresh the current page after deletion
      controller.refreshCurrentPage();
    }).catchError(
            (error) => Get.snackbar("Error", "Failed to delete user: $error"));
  }
  Widget _buildUserTypeButton({
    required Color color,
    required IconData icon,
    required String label,
  }) {
    return MyButton(
      backgroundColor: color,
      borderRadiusAll: 8,
      padding: MySpacing.xy(16, 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          MySpacing.width(8),
          MyText.bodyMedium(label, color: Colors.white, fontWeight: 600),
        ],
      ),
      onPressed: () {
        // Optional: implement filtering by type
      },
    );
  }
  void _showPageJumpDialog(
      BuildContext context, FreeMembersController controller) {
    final TextEditingController pageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Go to Page'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: pageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Page Number',
                hintText: 'Enter page number (1-${controller.totalPages})',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Current: Page ${controller.currentPage + 1} of ${controller.totalPages}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final pageNum = int.tryParse(pageController.text);
              if (pageNum != null &&
                  pageNum >= 1 &&
                  pageNum <= controller.totalPages) {
                controller.goToPage(pageNum - 1); // Convert to 0-based index
                Navigator.of(context).pop();
              } else {
                Get.snackbar('Invalid Page',
                    'Please enter a valid page number between 1 and ${controller.totalPages}');
              }
            },
            child: Text('Go'),
          ),
        ],
      ),
    );
  }
}



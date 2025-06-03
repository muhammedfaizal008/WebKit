import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/blocked_members_controller.dart';
import 'package:webkit/controller/apps/members/free_members_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/utils/utils.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/models/user_model.dart';
import 'package:webkit/views/layouts/layout.dart';

class BlockedMembers extends StatefulWidget  {
   BlockedMembers({super.key});

  @override
  State<BlockedMembers> createState() => _BlockedMembersState();
}

class _BlockedMembersState extends State<BlockedMembers> with UIMixin{
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  late BlockedMembersController controller;
  // void _showUserDetails(UserModel user) {
  //   final context = Get.context!;
  //   showDialog(
  //     context: context,
  //     builder: (context) => _buildUserDetailsDialog(context, user),
  //   );
  // }
  @override
  void initState() {
    controller = Get.put(BlockedMembersController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchBlockedUsers(page: 0);
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlockedMembersController>(
      // init: BlockedMembersController(),
      builder: (controller) {
        return Layout(
          child: Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Blocked Users", fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Users"),
                        MyBreadcrumbItem(name: "Blocked Users", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: _buildMainContent(controller),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainContent(BlockedMembersController controller) {
    // if (controller.isLoading.value) {
    //   return  Center(child: CircularProgressIndicator());
    // }

    return Column(
      children: [
        _buildTableHeader(),
        controller.users.isNotEmpty?
        _buildDataTable(controller)
        :_buildEmptyState(),
        
        _buildTableFooter(controller),
      ],
    );
  }

Widget _buildDataTable(BlockedMembersController controller) {
  return GetBuilder<BlockedMembersController>(builder: (controller) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        color: Colors.white,
      ),
      child: Scrollbar(
        controller: _horizontalScrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            controller: _verticalScrollController,
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 900), // Adjust as needed
              child: Theme(
                data: Theme.of(context).copyWith(
                  dataTableTheme: DataTableThemeData(
                    decoration: const BoxDecoration(color: Colors.white),
                    dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                      (states) => states.contains(WidgetState.selected)
                          ? contentTheme.primary.withOpacity(0.1)
                          : Colors.white,
                    ),
                    headingRowColor: WidgetStateProperty.all(Colors.white),
                  ),
                ),
                child: DataTable(
                    columns: [
                      DataColumn(label: MyText.bodyMedium("Name", fontWeight: 600)),
                      DataColumn(label: MyText.bodyMedium('Phone', fontWeight: 600)),
                      DataColumn(label: MyText.bodyMedium('Email', fontWeight: 600)),
                      DataColumn(label: MyText.bodyMedium('Profession', fontWeight: 600)),
                      DataColumn(label: MyText.bodyMedium('Status', fontWeight: 600)),
                      DataColumn(label: MyText.bodyMedium('Created At', fontWeight: 600)),
                      DataColumn(label: MyText.bodyMedium('Updated At', fontWeight: 600)),
                      DataColumn(label: MyText.bodyMedium('Subscription', fontWeight: 600)),
                      DataColumn(label: MyText.bodyMedium('Actions', fontWeight: 600)),
                    ],
                      rows: controller.users
                        .map((user) => _buildUserRow(user))
                        .toList(),
                    columnSpacing: 32,
                    showCheckboxColumn: false,
                    headingRowHeight: 56,
                    dataRowHeight: 72,
                  ),
                
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

              DataRow _buildUserRow(UserModel user) {
                return DataRow(
                  cells: [
                    DataCell(MyText.titleMedium(user.fullName, fontWeight: 600)),
                    DataCell(MyText.bodyMedium(user.phoneNumber)),
                    DataCell(MyText.bodyMedium(user.email)),
                    DataCell(MyText.bodyMedium(user.professionCategory !=null? user.professionCategory:"-")),
                    DataCell(MyText.bodyMedium(user.status.capitalize??"")),      
                    DataCell(MyText.bodyMedium(
                      user.createdAt != null
                          ? Utils.getDateStringFromDateTime(user.createdAt!, showMonthShort: true)
                          : '-',
                    )),
                    DataCell(MyText.bodyMedium(
                      user.createdAt != null
                          ? Utils.getDateStringFromDateTime(user.updatedAt!, showMonthShort: true)
                          : '-',
                    )),
                    DataCell(MyText.bodyMedium(user.subscription ?? '-')),
                    DataCell(_buildActionButtons(user)),
                  ],
                  // onSelectChanged: (_) => _showUserDetails(user),
                );
              }

  Widget _buildActionButtons(UserModel user) {
    final controller = Get.find<BlockedMembersController>();
    return Row(
      children: [
        MyButton(
          onPressed: () => controller.deleteUser(user),
          padding: MySpacing.xy(16, 12),
          backgroundColor: Colors.red,
          borderRadiusAll: 8,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        MySpacing.width(16),
        MyButton(
          onPressed: () =>controller.unblockUser(user),
          padding: MySpacing.xy(16, 12),
          backgroundColor: contentTheme.primary,
          borderRadiusAll: 8,
          child: Icon(Icons.block, color: Colors.white),
        )
      ],
    );
  }
  
  
  Widget _buildTableHeader() {
    return Container(
      child: Row(
        children: [
          MyText.titleMedium("Blocked Users", fontWeight: 600),
          const Spacer(),
          _buildSearchField(),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),)
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search blocked users...',
          prefixIcon: Icon(LucideIcons.search, size: 20),
          isDense: true,
          contentPadding: MySpacing.xy(12, 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      width: double.infinity,
      // padding: MySpacing.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.userX, size: 48, color: Colors.grey.shade400),
          MySpacing.height(16),
          MyText.titleMedium(
            "No blocked users found",
            color: Colors.grey.shade600,
          ),
          MySpacing.height(8),
          MyText.bodySmall(
            "When you block users, they will appear here",
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }

  Widget _buildTableFooter(BlockedMembersController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildPaginationControls(controller), // Reuse the existing widget
      ],
    ),
  );
}

  Widget _buildPaginationControls(BlockedMembersController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
  Widget _buildRowsPerPageDropdown(BlockedMembersController controller) {
    return DropdownButton<int>(
      dropdownColor: Colors.white,
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
  Widget _buildPageNavigationButtons(BlockedMembersController controller) {
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

  Widget _buildPageIndicator(BlockedMembersController controller) {
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
  void _showPageJumpDialog(
      BuildContext context, BlockedMembersController controller) {
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
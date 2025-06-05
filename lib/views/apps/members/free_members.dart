import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/add_members_controller/add_member_controller.dart';
import 'package:webkit/controller/apps/members/edit_members_controller/edit_members_controller.dart';
import 'package:webkit/controller/apps/members/free_members_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/utils/utils.dart';
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
  late EditMembersController editMemberController;
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();


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
    editMemberController =Get.put(EditMembersController());
     Future.microtask(() => controller.fetchUsers());
     editMemberController.fetchCountries();
     editMemberController.fetchReligion();
     editMemberController.fetchSubscription();
     editMemberController.fetchStatus();
     editMemberController.fetchAnnualIncome();  
     editMemberController.fetchGender();
     

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
                    
                    Column(
                      children: [
                        // Filter Header
                        MyContainer(
                          width: double.infinity,
                          height: 50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: contentTheme.primary,
                          child: MyText.titleMedium("Filter By", color: Colors.white),
                        ),
                        
                        // Filter Content
                        MyContainer(
                          width: double.infinity,
                          padding: MySpacing.all(16),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText.labelMedium("Name"),
                                        MySpacing.height(4),
                                        TextFormField(
                                          controller: controller.nameController,
                                          style: MyTextStyle.bodyMedium(),
                                          decoration: InputDecoration(
                                            hintText: "Enter name",
                                            hintStyle: MyTextStyle.bodyMedium(),
                                            contentPadding: MySpacing.all(12),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MySpacing.width(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText.labelMedium("Phone"),
                                        MySpacing.height(4),
                                        TextFormField(
                                          controller: controller.phoneController,
                                          keyboardType: TextInputType.phone,
                                          style: MyTextStyle.bodyMedium(),
                                          decoration: InputDecoration(
                                            hintText: "Enter phone",
                                            hintStyle: MyTextStyle.bodyMedium(),
                                            contentPadding: MySpacing.all(12),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MySpacing.width(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText.labelMedium("Email"),
                                        MySpacing.height(4),
                                        TextFormField(
                                          controller: controller.emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          style: MyTextStyle.bodyMedium(),
                                          decoration: InputDecoration(  
                                            hintText: "Enter email",
                                            hintStyle: MyTextStyle.bodyMedium(),
                                            contentPadding: MySpacing.all(12),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MySpacing.width(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText.labelMedium("Created Between"),
                                        MySpacing.height(4),
                                        TextFormField(
                                          controller: controller.createdFromDateController,
                                          readOnly: true,
                                          style: MyTextStyle.bodyMedium(),
                                          decoration: InputDecoration(
                                            hintText: "From",
                                            hintStyle: MyTextStyle.bodyMedium(),
                                            contentPadding: MySpacing.all(12),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            suffixIcon: Icon(Icons.calendar_today, size: 18),
                                          ),
                                          onTap: () async {
                                            DateTime? picked = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now(), 
                                            );
                                            if (picked != null) {
                                              controller.createdFromDate = Timestamp.fromDate(
                                                DateTime(picked.year, picked.month, picked.day, 0, 0, 0),
                                              );


                                              controller.createdFromDateController.text =Utils.getDateStringFromDateTime(showMonthShort: true,picked);
                                              controller.createdFromDate = Timestamp.fromDate(picked);
                                               // controller.createdFromDate = picked;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText.labelMedium(""),
                                        MySpacing.height(4),
                                        TextFormField(
                                          controller: controller.createdTillController,
                                          readOnly: true,
                                          style: MyTextStyle.bodyMedium(),
                                          decoration: InputDecoration(
                                            hintText: "Till",
                                            hintStyle: MyTextStyle.bodyMedium(),
                                            contentPadding: MySpacing.all(12),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            suffixIcon: Icon(Icons.calendar_today, size: 18),
                                          ),
                                          onTap: () async {
                                            DateTime? picked = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now(),
                                            );
                                            if (picked != null) {
                                              controller.createdTillDate = Timestamp.fromDate(
                                                DateTime(picked.year, picked.month, picked.day, 23, 59, 59),
                                              );
                                              controller.createdTillController.text = Utils.getDateStringFromDateTime(showMonthShort: true, picked);     
                                            }
                                          },
                                        ),      
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              MySpacing.height(10),
                              // // Religion Dropdown
                                Row(
                                  children: [
                                    _buildFilterDropdown(
                                      label: "Religion",
                                      value: controller.selectedReligion,
                                      items: editMemberController.religions,
                                      onChanged: controller.onReligionChanged
                                    ),
                                    MySpacing.width(12),

                                    // // Show Caste dropdown only when religion is selected
                                    // if (controller.selectedReligion != null) ...[
                                    //   _buildFilterDropdown(
                                    //     label: "Caste",
                                    //     value: controller.selectedCaste,
                                    //     items: controller.casteList,
                                    //     onChanged: (value) {
                                    //       setState(() => controller.selectedCaste = value);
                                    //     },
                                    //   ),
                                    //   MySpacing.width(12),
                                    // ],

                                    _buildFilterDropdown(
                                      label: "Country",
                                      value: controller.selectedCountry,
                                      items: editMemberController.countries,
                                      onChanged: controller.onCountryChanged
                                    ),
                                    MySpacing.width(12),

                                    _buildFilterDropdown(
                                      label: "Subscription",
                                      value: controller.selectedSubscription,
                                      items: editMemberController.subscriptions,
                                      onChanged: controller.onSubscriptionChanged
                                    ),
                                    MySpacing.width(12),

                                    _buildFilterDropdown(
                                      label: "Status",
                                      value: controller.selectedStatus,
                                      items: editMemberController.status,
                                      onChanged:controller.onStatusChanged,
                                    ),
                                  ],
                                ),
                              
                              MySpacing.height(16),
                              Row(
                                  children: [
                                    _buildFilterDropdown(
                                      label: "Gender",
                                      value: controller.selectedGender,
                                      items: editMemberController.genders,
                                      onChanged: controller.onGenderChanged
                                    ),
                                    MySpacing.width(12),

                                    // Age From
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MyText.labelMedium("Age From"),
                                            MySpacing.height(4),
                                            TextFormField(
                                              controller: controller.ageFromController,
                                              keyboardType: TextInputType.number,
                                              style: MyTextStyle.bodyMedium(),
                                              decoration: InputDecoration(
                                                hintText: "From",
                                                hintStyle: MyTextStyle.bodyMedium(),
                                                contentPadding: MySpacing.all(12),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MyText.labelMedium("Age To"),
                                            MySpacing.height(4),
                                            TextFormField(
                                              controller: controller.ageToController,
                                              keyboardType: TextInputType.number,
                                              style: MyTextStyle.bodyMedium(),
                                              decoration: InputDecoration(
                                                hintText: "To",
                                                hintStyle: MyTextStyle.bodyMedium(),
                                                contentPadding: MySpacing.all(12),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    MySpacing.width(12),

                                    _buildFilterDropdown(
                                      label: "Annual Income",
                                      value: controller.selectedAnnualIncome,
                                      items: editMemberController.annualIncomes,
                                      onChanged:controller.onIncomeChanged,
                                    ),
                                  ],
                                ),
                                MySpacing.height(16),
                              // Action Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyButton.text(
                                    onPressed: () {
                                      controller.resetFilters2();
                                      controller.resetFilters();
                                      
                                  }, child: MyText.bodyMedium("Reset")),
                                  MySpacing.width(16),
                                  MyButton.medium(
                                    backgroundColor: contentTheme.primary,
                                    onPressed: () {
                                    controller.fetchFilteredUsers();
                                  }, child: MyText.bodyMedium("Filter ",color: Colors.white,))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
  Widget _buildFilterDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.labelMedium(label),
          MySpacing.height(4),
          DropdownButtonFormField<String>(
            value: value,
            dropdownColor: Colors.white,
            style: MyTextStyle.bodyMedium(),
            decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: MySpacing.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: MyText.bodyMedium(value),
              );
            }).toList(),
            onChanged: onChanged,
            hint: MyText.bodyMedium("Select $label"),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTypeButtons(FreeMembersController controller) {
    return Row(
      children: [
        _buildUserTypeButton(
          color: Colors.blue,
          icon: Icons.person,
          label: "Free (${controller.freeUsers})",
        ),
        MySpacing.width(12),
        _buildUserTypeButton(
          color: Colors.green,
          icon: Icons.star,
          label: "Premium(${controller.premiumUsers})",
        ),
        MySpacing.width(12),
        _buildUserTypeButton(
          color: Colors.blueGrey,
          icon: Icons.star_purple500_rounded,
          label: "Pro (${controller.proUsers})",
        ),
      ],
    );
  }

  Widget _buildMainContent(FreeMembersController controller) {
  if (controller.isFilteredView ? controller.isFilteredLoading : controller.isLoading) {
    return SizedBox(
      height: 400,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  if ((controller.isFilteredView ? controller.filteredUsers : controller.users).isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
            MyText.bodyMedium(
            'No users found',
            color: Colors.grey[600],
            ),

          
        ],
      ),
    );
  }

  return Column(
    children: [
      _buildTableHeader(controller),
      _buildDataTable(controller),
      _buildTableFooter(controller), 
    ],
  );
}

  Widget _buildTableFooter(FreeMembersController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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


Widget _buildTableHeader(FreeMembersController controller) {
  return Column(
    children: [
      // Top row with title and add button
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius:  BorderRadius.vertical(top: Radius.circular(8),bottom: Radius.circular(8)),
        ),
        child: Row(
          children: [
            MyText.titleMedium("All Customers", fontWeight: 600),
            MySpacing.width(15),
            // User type buttons
            _buildUserTypeButtons(controller),
            const Spacer(),
            _buildAddUserButton(),
          ],
        ),
      ),
      
      // Filter row
      // Container(
        
      //   child: SizedBox(
      //     height: 36,
      //     child: TextField(
      //       decoration: InputDecoration(
      //         hintText: 'Search customers...',
      //         hintStyle: MyTextStyle.bodyMedium(),
      //         prefixIcon: Icon(Icons.search, size: 20),

      //         isDense: true,
      //         contentPadding: EdgeInsets.symmetric(horizontal: 12),
      //         border: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(8),
      //           borderSide: BorderSide.none,
      //         ),
      //         filled: true,
      //         fillColor: Colors.white,
      //       ),
      //       onChanged: (value) {
      //         // controller.searchUsers(value);
      //       },
      //     ),
      //   ),
      //   padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(color: Colors.grey.shade200),
      //     borderRadius:  BorderRadius.vertical(bottom: Radius.circular(8)),
      //   ),
      // )
    ],
    
  );
}


  Widget _buildPaginationControls(FreeMembersController controller) {
  final bool isFiltered = controller.isFilteredView;

  final int currentPage = isFiltered ? controller.filteredCurrentPage : controller.currentPage;
  final int totalPages = isFiltered ? controller.filteredTotalPages : controller.totalPages;
  final int totalRecords = isFiltered ? controller.filteredTotalRecords : controller.totalRecords;
  final int rowsPerPage = isFiltered ? controller.filteredRowsPerPage : controller.rowsPerPage;
  final bool canGoPrev = isFiltered ? controller.canGoToPreviousFiltered : controller.canGoToPrevious;
  final bool canGoNext = isFiltered ? controller.canGoToNextFiltered : controller.canGoToNext;

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      MyText.bodySmall(
        "Showing ${(currentPage * rowsPerPage) + 1}"
        "-${((currentPage + 1) * rowsPerPage).clamp(1, totalRecords)} of $totalRecords",
        color: Colors.grey.shade600,
      ),
      MySpacing.width(16),
      _buildRowsPerPageDropdown(controller, isFiltered),
      MySpacing.width(16),
      _buildPageNavigationButtons(controller, isFiltered),
    ],
  );
}


  Widget _buildRowsPerPageDropdown(FreeMembersController controller, bool isFiltered) {
  return DropdownButton<int>(
    dropdownColor: Colors.white,
    value: isFiltered ? controller.filteredRowsPerPage : controller.rowsPerPage,
    items: const [4, 10, 20].map((value) {
      return DropdownMenuItem<int>(
        value: value,
        child: MyText.bodyMedium("$value per page"),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) {
        if (isFiltered) {
          controller.filteredRowsPerPage = value;
          controller.fetchFilteredUsers(page: 0);
        } else {
          controller.onRowsPerPageChanged(value);
        }
      }
    },
    underline: Container(),
  );
}


  Widget _buildPageNavigationButtons(FreeMembersController controller, bool isFiltered) {
  final canGoPrev = isFiltered ? controller.canGoToPreviousFiltered : controller.canGoToPrevious;
  final canGoNext = isFiltered ? controller.canGoToNextFiltered : controller.canGoToNext;

  return Row(
    children: [
      IconButton(
        onPressed: canGoPrev
            ? () => isFiltered ? controller.fetchFilteredUsers(page: 0) : controller.goToFirstPage()
            : null,
        icon: const Icon(Icons.first_page),
        tooltip: "First page",
      ),
      IconButton(
        onPressed: canGoPrev
            ? () => isFiltered ? controller.goToPreviousFilteredPage() : controller.goToPreviousPage()
            : null,
        icon: const Icon(Icons.chevron_left),
        tooltip: "Previous page",
      ),
      _buildPageIndicator(controller, isFiltered),
      IconButton(
        onPressed: canGoNext
            ? () => isFiltered ? controller.goToNextFilteredPage() : controller.goToNextPage()
            : null,
        icon: const Icon(Icons.chevron_right),
        tooltip: "Next page",
      ),
      // IconButton(
      //     onPressed: controller.canGoToNext ? controller.goToLastPage : null,
      //     icon: const Icon(Icons.last_page),
      //     tooltip: "Last page",
      //   ),
    ],
  );
}


  Widget _buildPageIndicator(FreeMembersController controller, bool isFiltered) {
  final currentPage = isFiltered ? controller.filteredCurrentPage : controller.currentPage;
  final totalPages = isFiltered ? controller.filteredTotalPages : controller.totalPages;

  return GestureDetector(
    onTap: () => _showPageJumpDialog(context, controller, isFiltered),
    child: Container(
      child: MyText.bodyMedium(
        "${currentPage + 1} of $totalPages",
        fontWeight: 600,
        color: contentTheme.primary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: contentTheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: contentTheme.primary.withOpacity(0.3)),
      ),
    ),
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
  // Display the appropriate data
final dataToDisplay = controller.isFilteredView 
    ? controller.filteredUsers 
    : controller.users;


  return GetBuilder<FreeMembersController>(builder: (controller) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius:  BorderRadius.vertical(top: Radius.circular(8),bottom: Radius.circular(8)),
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
                    rows: dataToDisplay
                      .map((user) => _buildUserRow(user))
                      .toList(),
                  columnSpacing: 36,
                  showCheckboxColumn: false,
                  headingRowHeight: 56,
                  dataRowHeight: 52,
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
        MySpacing.width(16),
        MyButton(
          onPressed: () =>_blockUser(user),
          padding: MySpacing.xy(16, 12),
          backgroundColor: Colors.red,
          borderRadiusAll: 8,
          child: Icon(Icons.block, color: Colors.white),
        )
      ],
    );
  }
 Widget _buildUserDetailsDialog(BuildContext context, UserModel user) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Colors.transparent,
    insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    child: Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        maxWidth: 900,
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 24,
            offset: Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Enhanced Header with gradient background
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  contentTheme.primary.withOpacity(0.1),
                  contentTheme.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced Avatar with status indicator
                Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            contentTheme.primary.withOpacity(0.2),
                            contentTheme.primary.withOpacity(0.1),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: contentTheme.primary.withOpacity(0.2),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: user.imageUrl != null
                            ? Image.network(
                                user.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildAvatarFallback(),
                              )
                            : _buildAvatarFallback(),
                      ),
                    ),
                    // Online status indicator
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 32),
                
                // Enhanced Basic Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name with verification badge
                      Row(
                        children: [
                          Expanded(
                            child: MyText.titleLarge(
                              user.fullName,
                              fontWeight: 700,
                              fontSize: 28,
                              color: Colors.black87,
                            ),
                          ),
                          Icon(
                            Icons.verified,
                            color: contentTheme.primary,
                            size: 24,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      
                      // Professional styled info chips
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildProfessionalChip('${user.age} years', Icons.cake_outlined),
                          _buildProfessionalChip(user.gender, Icons.person_outline),
                          _buildProfessionalChip(user.maritalStatus, Icons.favorite_outline),
                        ],
                      ),
                      
                      SizedBox(height: 16),
                      
                      // Secondary info with better visual hierarchy
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          if (user.professionCategory.isNotEmpty)
                            _buildSecondaryChip(user.professionCategory, Icons.work_outline),
                          if (user.educationCategory.isNotEmpty)
                            _buildSecondaryChip(user.educationCategory, Icons.school_outlined),
                          if (user.country.isNotEmpty)
                            _buildSecondaryChip(user.country, Icons.location_on_outlined),
                        ],
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Quick stats row
                      Row(
                        children: [
                          _buildQuickStat('Height', '${user.height} cm'),
                          SizedBox(width: 24),
                          _buildQuickStat('Religion', user.religion),
                          SizedBox(width: 24),
                          _buildQuickStat('Location', user.state),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Enhanced Tabbed content
          Expanded(
            child: DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      labelStyle: MyTextStyle.titleMedium(fontWeight: 600),
                      unselectedLabelStyle: MyTextStyle.titleMedium(fontWeight: 500),
                      isScrollable: true,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey.shade600,
                      indicator: BoxDecoration(
                        color: contentTheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      // labelPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      tabs: [
                        Tab(text: 'Personal'),
                        Tab(text: 'Family'),
                        Tab(text: 'Lifestyle'),
                        Tab(text: 'Religious'),
                        Tab(text: 'Preferences'),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildPersonalTab(user),
                        _buildFamilyTab(user),
                        _buildLifestyleTab(user),
                        _buildReligiousTab(user),
                        _buildPreferencesTab(user),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Enhanced Footer with better button styling
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Primary actions
                _buildActionButton(
                  icon: Icons.close,
                  label: 'Close',
                  onPressed: () => Navigator.pop(context),
                  isPrimary: false,
                ),
                SizedBox(width: 16),
                _buildActionButton(
                  icon: Icons.edit_outlined,
                  label: 'Edit Profile',
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed("/user/edit_member", arguments: user.toMap());
                  },
                  isPrimary: true,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Enhanced helper widgets
Widget _buildAvatarFallback() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          contentTheme.primary.withOpacity(0.3),
          contentTheme.primary.withOpacity(0.1),
        ],
      ),
    ),
    child: Icon(
      Icons.person_outline,
      size: 60,
      color: contentTheme.primary,
    ),
  );
}

Widget _buildProfessionalChip(String text, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: contentTheme.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: contentTheme.primary.withOpacity(0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: contentTheme.primary),
        SizedBox(width: 6),
        MyText(
          text,
          style: MyTextStyle.bodySmall(
            color: contentTheme.primary,
            fontWeight: 10,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSecondaryChip(String text, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        SizedBox(width: 4),
        MyText(
          text,
          style: MyTextStyle.bodySmall(
            color: Colors.grey.shade700,
            fontWeight: 500,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget _buildQuickStat(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MyText(
        label,
        style: MyTextStyle.bodySmall(
          color: Colors.grey.shade600,
          fontSize: 12,
          fontWeight: 10
        ),
      ),
      SizedBox(height: 2),
      MyText(
        value,
        style:  MyTextStyle.bodySmall(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: 500,
        ),
      ),
    ],
  );
}

Widget _buildActionButton({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
  required bool isPrimary,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(
      icon,
      size: 18,
      color: isPrimary ? Colors.white : Colors.grey.shade700,
    ),
    label: MyText(
      label,
      style: MyTextStyle.bodyMedium(
        color: isPrimary ? Colors.white : Colors.grey.shade700,
        fontWeight: 10,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: isPrimary ? contentTheme.primary : Colors.white,
      elevation: isPrimary ? 2 : 0,
      shadowColor: isPrimary ? contentTheme.primary.withOpacity(0.3) : null,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isPrimary ? BorderSide.none : BorderSide(color: Colors.grey.shade300),
      ),
    ),
  );
}

// Enhanced Tab content widgets
Widget _buildPersonalTab(UserModel user) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact Information', Icons.contact_mail_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Email', user.email, Icons.email_outlined),
          _buildDetailItem('Phone', user.phoneNumber, Icons.phone_outlined),
          _buildDetailItem('Date of Birth', user.dob ?? '-', Icons.cake_outlined),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Physical Details', Icons.accessibility_new_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Height', '${user.height} cm', Icons.height_outlined),
          _buildDetailItem('Weight', user.weight, Icons.monitor_weight_outlined),
          _buildDetailItem('Physical Status', user.physicalStatus, Icons.health_and_safety_outlined),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Professional & Education', Icons.work_outline),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Profession', user.professionInDetail ?? '-', Icons.work_outline),
          _buildDetailItem('Education', user.educationInDetail ?? '-', Icons.school_outlined),
          _buildDetailItem('Annual Income', user.annualIncome ?? '-', Icons.payments_outlined),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('About Me', Icons.person_outline),
        SizedBox(height: 12),
        _buildModernTextContent(user.aboutMe),
      ],
    ),
  );
}

Widget _buildFamilyTab(UserModel user) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Family Background', Icons.family_restroom_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Family Status', user.familyStatus, Icons.home_outlined),
          _buildDetailItem('Family Type', user.familyType, Icons.group_outlined),
          _buildDetailItem('Family Values', user.familyValues, Icons.favorite_outline),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Parents Occupation', Icons.work_outline),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Father\'s Occupation', user.fathersOccupation, Icons.person_outline),
          _buildDetailItem('Mother\'s Occupation', user.mothersOccupation, Icons.person_outline),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Siblings', Icons.group_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Brothers', user.brothers, Icons.man_outlined),
          _buildDetailItem('Sisters', user.sisters, Icons.woman_outlined),
        ]),
      ],
    ),
  );
}

Widget _buildLifestyleTab(UserModel user) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Lifestyle Preferences', Icons.checklist_rtl_rounded),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Eating Habits', user.eatingHabits, Icons.restaurant_outlined),
          _buildDetailItem('Drinking Habits', user.drinkingHabits, Icons.local_bar_outlined),
          _buildDetailItem('Smoking Habits', user.smokingHabits, Icons.smoking_rooms_outlined),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Languages', Icons.language_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Mother Tongue', user.language, Icons.record_voice_over_outlined),
          _buildDetailItem('Languages Known', user.language, Icons.translate_outlined),
        ]),
      ],
    ),
  );
}

Widget _buildReligiousTab(UserModel user) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Religious Information', Icons.temple_buddhist_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Religion', user.religion, Icons.temple_buddhist_outlined),
          _buildDetailItem('Caste', user.caste, Icons.account_tree_outlined),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Astrological Details', Icons.star_outline),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Star', user.star, Icons.star_outline),
          _buildDetailItem('Zodiac Sign', user.zodiacSign, Icons.circle_outlined),
          _buildDetailItem('Chovva Dosham', user.chovvaDosham, Icons.warning_amber_outlined),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Horoscope', Icons.psychology_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Horoscope', user.horoscope, Icons.description_outlined),
        ]),
      ],
    ),
  );
}

Widget _buildPreferencesTab(UserModel user) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Partner Preferences', Icons.favorite_outline),
        SizedBox(height: 12),
        
        _buildModernDetailCard([
          _buildDetailItem('For Whom', user.forWhom, Icons.person_search_outlined),
          _buildDetailItem('Partner Age', user.partnerAge, Icons.cake_outlined),
          _buildDetailItem('Partner Height', user.partnersHeight, Icons.height_outlined),
          _buildDetailItem('Partner Marital Status', user.partnerMaritalStatus, Icons.favorite_outline),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Religious Preferences', Icons.temple_buddhist_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Partner Religion', user.partnerReligion, Icons.temple_buddhist_outlined),
          _buildDetailItem('Partner Castes', user.partnerCastes.join(', '), Icons.account_tree_outlined),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Educational & Professional Preferences', Icons.work_outline),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Partner Education', user.partnerEducationList.join(', '), Icons.school_outlined),
          _buildDetailItem('Partner Profession', user.partnerProfessions.join(', '), Icons.work_outline),
        ]),
        
        SizedBox(height: 24),
        
        _buildSectionTitle('Location Preferences', Icons.location_on_outlined),
        SizedBox(height: 12),
        _buildModernDetailCard([
          _buildDetailItem('Partner Country', user.partnerCountry, Icons.public_outlined),
          _buildDetailItem('Partner States', user.partnerStates.join(', '), Icons.location_city_outlined),
          _buildDetailItem('Partner Citizenship', user.partnerCitizenship.join(', '), Icons.card_membership_outlined),
        ]),
      ],
    ),
  );
}

// Enhanced reusable components
Widget _buildSectionTitle(String title, IconData icon) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: contentTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: contentTheme.primary,
        ),
      ),
      SizedBox(width: 12),
      MyText(
        title,
        style: MyTextStyle.bodyMedium(
          fontSize: 18,
          fontWeight: 10,
          color: Colors.black87,
        ),
      ),
    ],
  );
}

Widget _buildModernDetailCard(List<Widget> children) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget _buildDetailItem(String label, String value, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey.shade600,
        ),
        SizedBox(width: 12),
        SizedBox(
          width: 140,
          child: MyText(
            label,
            style: MyTextStyle.bodyMedium(
              fontWeight: 10,
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: MyText(
            value.isNotEmpty ? value : '-',
            style: MyTextStyle.bodyMedium(
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildModernTextContent(String? text) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: MyText(
      text?.isNotEmpty == true ? text! : 'Not specified',
      style: MyTextStyle.bodyMedium(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: 10,
        height: 1.5,
      ),
    ),
  );
}

  // Widget _buildSectionTitle(String title) {
  //   return Row(
  //     children: [
  //       MyText.titleMedium(
  //         title,
  //         fontWeight: 700,
  //         color: contentTheme.primary,
  //       ),
  //       MySpacing.width(8),
  //       Expanded(
  //         child: Divider(
  //           color: contentTheme.primary.withOpacity(0.2),
  //           thickness: 1,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Helper method to build info cards
  // Widget _buildInfoCard(List<Widget> children) {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.grey.shade50,
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(color: Colors.grey.shade200),
  //     ),
  //     child: Column(
  //       children: List.generate(children.length * 2 - 1, (index) {
  //         if (index % 2 == 0) {
  //           return children[index ~/ 2];
  //         } else {
  //           return Padding(
  //             padding: EdgeInsets.symmetric(vertical: 8),
  //             child: Divider(
  //               color: Colors.grey.shade200,
  //               height: 1,
  //             ),
  //           );
  //         }
  //       }),
  //     ),
  //   );
  // }

  // Helper method to build detail rows
  // Widget _buildDetailRow(String label, String value) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 4),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           width: 140,
  //           child: MyText.bodyMedium(
  //             '$label:',
  //             fontWeight: 600,
  //             color: Colors.grey.shade700,
  //           ),
  //         ),
  //         Expanded(
  //           child: MyText.bodyMedium(
  //             value,
  //             color: Colors.black87,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  void _blockUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .update({'status': 'blocked'});
      Get.snackbar("Success", "User has been blocked");
      controller.refreshCurrentPage();
    } catch (e) {
      Get.snackbar("Error", "Failed to block user: $e");
    }
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
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          // Optional: implement filtering by type
        },
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 5, vertical: 5 ),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 15),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: MyTextStyle.bodySmall(
                    color: Colors.white,
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
  void _showPageJumpDialog(BuildContext context, FreeMembersController controller, bool isFiltered) {
  showDialog(
    context: context,
    builder: (context) {
      final TextEditingController pageController = TextEditingController();
      return AlertDialog(
        title: const Text('Jump to Page'),
        content: TextField(
          controller: pageController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter page number'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final int? page = int.tryParse(pageController.text);
              if (page != null && page > 0) {
                Navigator.of(context).pop();
                if (isFiltered) {
                  controller.fetchFilteredUsers(page: page - 1);
                } else {
                  controller.goToPage(page - 1);
                }
              }
            },
            child: const Text('Go'),
          ),
        ],
      );
    },
  );
}

}



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
    log(controller.users.toString());
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
                      sizes: "xxl-8 xl-8",
                      child: Column(
                        children: [
                          if (controller.data != null)
                            PaginatedDataTable(
                              showCheckboxColumn: false ,
                              header: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
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
                                          contentPadding: MySpacing.xy(16, 12),
                                          isCollapsed: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never),
                                    ),
                                  ),
                                  MyButton(child: MyText.bodyMedium("Add User"), onPressed: () {
                                    Get.toNamed("/user/add_member");
                                  },),
                                  
                                ],
                              ),
                              source: controller.data!,
                              columns: [
                                DataColumn(
                                    label: MyText.titleMedium(
                                  'Name',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.titleMedium(
                                  'Phone Number',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.titleMedium(
                                  'Email',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.titleMedium(
                                  'Profession',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.titleMedium(
                                  'Created At',
                                  fontWeight: 600,
                                )),
                              ],
                              columnSpacing: 60,
                              horizontalMargin: 28,
                              rowsPerPage: 10,
                            ),
                        ],
                      ),
                    ),
                      // MyFlexItem(
                      //     sizes: "xxl-4 xl-4",
                      //     child: MyCard(
                      //       shadow: MyShadow(elevation: 0.5),
                      //       paddingAll: 20,
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           if (controller.selectedUser == null)
                      //             Center(
                      //               child: MyText.bodyMedium("Select a user from the table."),
                      //             )
                      //           else ...[
                      //             Row(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 MyContainer.roundBordered(
                      //                   alignment: Alignment.topLeft,
                      //                   paddingAll: 0,
                      //                   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                   height: 60,
                      //                   width: 60,
                      //                   child: controller.selectedUser!['avatarUrl'] != null
                      //                       ? Image.network(
                      //                           controller.selectedUser!['avatarUrl'],
                      //                           fit: BoxFit.cover,
                      //                           height: 60,
                      //                           width: 60,
                      //                         )
                      //                       : Center(
                      //                         child: CircleAvatar(
                      //                             backgroundColor: contentTheme.primary,
                      //                             child: Icon(
                      //                               LucideIcons.user,
                      //                               color: contentTheme.onPrimary,
                                                    
                      //                             ),
                      //                           ),
                      //                       ),
                                            
                      //                 ),
                      //                 MySpacing.width(16),
                      //                 Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     MyText.bodyMedium(
                      //                       controller.selectedUser!['fullName'] ?? "-",
                      //                       fontSize: 20,
                      //                     ),
                      //                     MyText.bodyMedium(
                      //                       controller.selectedUser!['age'].toString()+" yrs" ,
                      //                       muted: true,
                      //                     ),
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //             MySpacing.height(16),
                      //             MyContainer(
                      //               paddingAll: 8,
                      //               color: contentTheme.primary.withAlpha(30),
                      //               child: Row(
                      //                 children: [
                      //                   Icon(
                      //                     LucideIcons.user,
                      //                     color: contentTheme.primary,
                      //                   ),
                      //                   MySpacing.width(12),
                      //                   Expanded(
                      //                     child: MyText.bodyMedium(
                      //                       "PERSONAL INFORMATION",
                      //                       fontSize: 16,
                      //                       color: contentTheme.primary,
                      //                       overflow: TextOverflow.ellipsis,
                      //                       fontWeight: 600,
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             MySpacing.height(16),
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 MyText.titleMedium(
                      //                   "ABOUT ME:",
                      //                   fontWeight: 600,
                      //                 ),
                      //                 MySpacing.height(12),
                      //                 MyText.bodyMedium(
                      //                   controller.selectedUser!['aboutMe'] ?? "No description available.",
                      //                   overflow: TextOverflow.ellipsis,
                      //                   maxLines: 3,
                      //                   muted: true,
                      //                 ),
                      //               ],
                      //             ),
                      //             MySpacing.height(16),
                      //             buildPersonalDetail(
                      //               "Education :",
                      //               controller.selectedUser!['education'] ?? "-",
                      //             ),
                      //             MySpacing.height(16),
                      //             buildPersonalDetail(
                      //               "Profession :",
                      //               controller.selectedUser!['profession'] ?? "-",
                      //             ),
                      //             MySpacing.height(16),
                      //             buildPersonalDetail(
                      //               "Location :",
                      //               controller.selectedUser!['location'] ?? "-",
                      //             ),
                      //             MySpacing.height(16),
                      //             buildPersonalDetail(
                      //               "ADDED:",
                      //               Utils.getDateStringFromDateTime(
                      //                 (controller.selectedUser!['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
                      //               ),
                      //             ),
                      //             MySpacing.height(16),
                      //             buildPersonalDetail(
                      //               "UPDATED:",
                      //               Utils.getDateStringFromDateTime(
                      //                 (controller.selectedUser!['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
                      //               ),
                      //             ),
                      //           ],
                      //         ],
                      //       ),
                      //     ),
                      //   ),

                  ],
                ),
              ),
 

          ],
        );
      }),
    );
  }
}
 Widget buildPersonalDetail(String title, String description) {
    return Row(
      children: [
        MyText.titleMedium(
          title,
          fontWeight: 600,
        ),
        MySpacing.width(8),
        Expanded(
          child: MyText.bodyMedium(
            description,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }


class UsersDataTable extends DataTableSource with UIMixin {
  final List<Map<String, dynamic>> users;
  final void Function(Map<String, dynamic>) onRowSelect;

  UsersDataTable(this.users, this.onRowSelect);

  @override
  DataRow getRow(int index) {
    final user = users[index];

    return DataRow(
      onSelectChanged: (selected) {
        if (selected == true) {
          onRowSelect(user);
        }
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



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webkit/controller/apps/members/free_members_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
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
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  MyText(
                    "Free Members",
                    fontSize: 20,
                    fontWeight: 20,
                  ),
                  Spacer(),
                  MyButton(
                    backgroundColor: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: MyText("Add Free Member", color: Colors.white),
                    onPressed: () {
                      Get.toNamed("/user/add_member");
                    }
                  ),

                ],
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: MyContainer(
                  paddingAll: 16,
                  borderRadiusAll: 12,
                  bordered: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
                      MySpacing.height(12),
              
                      // Hardcoded Member List
                      ...[
                        {
                          "name": "Alice Johnson",
                          "email": "alice@example.com",
                          "joinedDate": "2024-12-01"
                        },
                        {
                          "name": "Bob Smith",
                          "email": "bob@example.com",
                          "joinedDate": "2025-01-15"
                        },
                        {
                          "name": "Charlie Davis",
                          "email": "charlie@example.com",
                          "joinedDate": "2025-03-10"
                        },
                      ].map((member) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: MyContainer(
                            paddingAll: 12,
                            borderRadiusAll: 10,
                            color: Colors.grey.shade100,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.blueAccent.shade100,
                                  child: MyText(
                                    member['name']![0],
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: 600,
                                  ),
                                ),
                                MySpacing.width(16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        member['name']!,
                                        fontWeight: 600,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      MySpacing.height(4),
                                      MyText(
                                        member['email']!,
                                        muted: true,
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      MySpacing.height(4),
                                      MyText(
                                        "Joined: ${member['joinedDate']!}",
                                        muted: true,
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
            ),
 

          ],
        );
      }),
    );
  }
}
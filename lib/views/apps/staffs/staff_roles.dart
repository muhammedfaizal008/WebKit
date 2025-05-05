import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webkit/controller/apps/staffs/staff_roles_controller.dart';
import 'package:webkit/views/layouts/layout.dart';

class StaffRoles extends StatefulWidget {
  const StaffRoles({super.key});

  @override
  State<StaffRoles> createState() => _StaffRolesState();
}

class _StaffRolesState extends State<StaffRoles> {
  late StaffRolesController controller;
  @override
  void initState() {
    controller=Get.put(StaffRolesController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: StaffRolesController(),
        builder:(controller) => Column(
          children: [
            Text('Staff Roles'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your button action here
              },
              child: const Text('Add Staff Role'),
            ),
          ],
        ), 
        ),
    );
  }
}
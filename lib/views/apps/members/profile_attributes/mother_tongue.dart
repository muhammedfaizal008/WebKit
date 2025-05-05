import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webkit/controller/apps/members/profile_attributes/mother_tongue_controller.dart';
import 'package:webkit/views/layouts/layout.dart';

class MotherTongue extends StatefulWidget {
  const MotherTongue({super.key});

  @override
  State<MotherTongue> createState() => _MotherTongueState();
}

class _MotherTongueState extends State<MotherTongue> {
  late MotherTongueController controller;
  @override
  void initState() {
    controller=Get.put(MotherTongueController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: MotherTongueController(),
        builder:(controller) => Column(
        children: [
          
        ],
      )),
    );
  }
}
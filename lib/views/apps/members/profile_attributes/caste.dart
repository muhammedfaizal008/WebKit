import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webkit/controller/apps/members/profile_attributes/caste_controller.dart';

import 'package:webkit/views/layouts/layout.dart';

class Caste extends StatefulWidget {
  const Caste({super.key});

  @override
  State<Caste> createState() => _CasteState();
}

class _CasteState extends State<Caste> {
  late CasteController controller;
  @override
  void initState() {
    controller=Get.put(CasteController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: CasteController(),
        builder:(controller) => Column(
        children: [
          
        ],
      )),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:webkit/controller/apps/calender/calender_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/layouts/layout.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender>
    with SingleTickerProviderStateMixin, UIMixin {
  late CalenderController controller; 

  @override
  void initState() {
    super.initState();
    controller = Get.put(CalenderController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              
            ],
          );
        },
      ),
    );
  }
}

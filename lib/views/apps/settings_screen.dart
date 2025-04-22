import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webkit/controller/apps/settings_controller.dart';

import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text.dart';

import 'package:webkit/views/layouts/layout.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late SettingsController controller;

  @override
  void initState() {
    controller = SettingsController();
    super.initState();
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
                      "Settings",
                      fontSize: 20,
                      fontWeight: 20,
                    ),
                  
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
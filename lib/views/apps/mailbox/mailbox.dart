import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webkit/controller/apps/mailbox_controller/mailbox_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/layouts/layout.dart';

class Mailbox extends StatefulWidget {
  const Mailbox({super.key});

  @override
  State<Mailbox> createState() => _MailboxState();
}

class _MailboxState extends State<Mailbox>  with SingleTickerProviderStateMixin, UIMixin {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: MailboxController(),
        builder: (controller) {
          return Column(
            children: [
              Text(
                
                'Welcome to the Mailbox!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}
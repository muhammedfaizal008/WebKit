import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/widgets/my_text_utils.dart';
import 'package:webkit/models/contacts.dart';
import 'package:webkit/views/apps/CRM/contacts_page.dart';
import 'package:webkit/views/apps/members/free_members.dart';


class FreeMembersController extends MyController {
  List<Map<String, dynamic>> users = [];
  DataTableSource? data;
  Map<String, dynamic>? selectedUser;

  @override
  void onInit() {
    super.onInit();
    listenToUserUpdates();
  }
  

  void selectUser(Map<String, dynamic> user) {
    selectedUser = user;
    update();
  }


  void listenToUserUpdates() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
      users = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // include ID if needed
        return data;
      }).toList();

      // Create a DataTableSource from raw maps
      data = UsersDataTable(users, selectUser);
      update();
    });
  }
}

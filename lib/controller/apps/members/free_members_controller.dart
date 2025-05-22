import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/user_model.dart';
import 'package:webkit/views/apps/members/free_members.dart';

class FreeMembersController extends MyController {
  List<UserModel> users =[]; 
  DataTableSource? data;
  UserModel? selectedUser;

  @override
  void onInit() {
    super.onInit();
    listenToUserUpdates();
    listenToTotalUserUpdates();
  }

  void selectUser(UserModel user) {
    selectedUser = user;
    update();
  }

  void listenToUserUpdates() {
    // Get the current context from Get
    BuildContext context = Get.context!;

    FirebaseFirestore.instance
        .collection('users')
        .where('subscription')    
        .snapshots()
        .listen((snapshot) {
      users = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return UserModel.fromMap(data);
      }).toList();

      // Create a DataTableSource from raw maps
      data = UsersDataTable(
          context, users, selectUser); // Use context as needed here
      update();
    });
  }
  RxInt totalUsers = 0.obs;
  RxInt premiumUsers = 0.obs;
  RxInt proUsers = 0.obs;
  RxInt basicUsers = 0.obs;
  RxInt freeUsers = 0.obs;
  RxInt blockedUsers = 0.obs;

  void listenToTotalUserUpdates() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshot) {
      totalUsers.value = snapshot.docs.length;
      proUsers.value = snapshot.docs
          .where((doc) => doc['subscription'] == 'Pro')
          .length;
      basicUsers.value = snapshot.docs
          .where((doc) => doc['subscription'] == 'Basic')
          .length;    
      premiumUsers.value = snapshot.docs
          .where((doc) => doc['subscription'] == 'Premium')
          .length;
      freeUsers.value =
          snapshot.docs.where((doc) => doc['subscription'] == 'Free').length;
      // blockedUsers.value =
      //     snapshot.docs.where((doc) => doc['status'] == 'blocked').length;
    });
  }
}

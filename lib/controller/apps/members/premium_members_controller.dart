import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/user_model.dart';
import 'package:webkit/views/apps/members/free_members.dart';

class PremiumMembersController extends MyController{
  DataTableSource? data;
  UserModel? selectedUser;
  List<UserModel> users = [];

  @override
  void onInit() {
    super.onInit();
    listenToUserUpdates();
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
      .where('subscription', isEqualTo: 'Premium')
      .snapshots()
      .listen((snapshot) {
      users = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return UserModel.fromMap(data);
      }).toList();

      // Create a DataTableSource from raw maps
      // data = UsersDataTable( users, selectUser); // Use context as needed here
      update();
    });
  }
}
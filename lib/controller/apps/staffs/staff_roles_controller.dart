import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/staff_roles_model.dart';
import 'package:webkit/views/apps/staffs/staff_roles.dart';

class StaffRolesController extends MyController{
  DataTableSource? data;
  List<StaffRolesModel> StaffRolesList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchStaffRoles();
  }

  void fetchStaffRoles() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('StaffRole').get();

      StaffRolesList = snapshot.docs
          .map((doc) => StaffRolesModel.fromDoc(doc))
          .toList();

      data = StaffRolesDataSource(StaffRolesList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching staff: $e');
      Get.snackbar("Error", "Failed to fetch staff list");
    }
  }

  Future<void> editStaffRoles(String id, String newRole) async {
    try {
      await _firestore
          .collection("StaffRole")
          .doc(id)
          .update({"role": newRole});

      fetchStaffRoles();
      Get.snackbar("Success", "Staff updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update staff: $e");
    }
  }

  Future<void> addStaffRoles({
    required String role,
  }) async {
    try {
      await _firestore.collection("StaffRole").add({
        "role": role,
        "isActive": true,
      });

      fetchStaffRoles();
      Get.snackbar("Success", "Staff role added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add staff: $e");
    }
  }
}
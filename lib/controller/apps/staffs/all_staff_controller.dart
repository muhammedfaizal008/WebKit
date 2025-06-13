import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/all_staff_model.dart';
import 'package:webkit/models/staff_roles_model.dart';
import 'package:webkit/views/apps/staffs/all_staff.dart';

class AllStaffController extends MyController {
  DataTableSource? data;
  List<AllStaffModel> allStaffList = [];
  List<StaffRolesModel> StaffRolesList = [];
  String selectedRole = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchAllStaffs();
  }

  void fetchAllStaffs() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('Admins').get();

      allStaffList = snapshot.docs
          .map((doc) => AllStaffModel.fromDoc(doc))
          .toList();

      data = AllStaffDataSource(allStaffList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching staff: $e');
      Get.snackbar("Error", "Failed to fetch staff list");
    }
  }

  Future<void> editAllStaff(String id, String newRole) async {
    try {
      await _firestore
          .collection("AllStaff")
          .doc(id)
          .update({"role": newRole});

      fetchAllStaffs();
      Get.snackbar("Success", "Staff updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update staff: $e");
    }
  }

  Future<void> addAllStaff({
    required String StaffName,
    required String role,
  }) async {
    try {
      await _firestore.collection("AllStaff").add({
        "staffName": StaffName,
        "role": role,
        "isActive": true,
      });

      fetchAllStaffs();
      Get.snackbar("Success", "Staff role added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add staff: $e");
    }
  }
  void fetchStaffRoles() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('StaffRole').get();

      StaffRolesList = snapshot.docs
          .map((doc) => StaffRolesModel.fromDoc(doc))
          .toList();
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching staff: $e');
      Get.snackbar("Error", "Failed to fetch staff list");
    }
  }
  void selectRole(String role) {
  selectedRole = role;
  update(); 
}

}

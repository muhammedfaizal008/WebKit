import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/physical_status_model.dart';
import 'package:webkit/views/apps/members/masters/physical_status.dart';


class PhysicalStatusController extends MyController {
  DataTableSource? data;
  List<PhysicalStatusModel> PhysicalStatusList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchPhysicalStatus();
  }

  void fetchPhysicalStatus() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('PhysicalStatus').get();

      PhysicalStatusList = snapshot.docs 
          .map((doc) => PhysicalStatusModel.fromDoc(doc))
          .toList();

      data = PhysicalStatusDataSource(PhysicalStatusList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching PhysicalStatus : $e');
      Get.snackbar("Error", "Failed to fetch PhysicalStatus  list");
    }
  }

  Future<void> editPhysicalStatus(String id, String newStatus) async {
    try {
      await _firestore
          .collection("PhysicalStatus")
          .doc(id)
          .update({"status": newStatus});

      fetchPhysicalStatus();
      Get.snackbar("Success", "PhysicalStatus  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update PhysicalStatus : $e");
    }
  }

  Future<void> addPhysicalStatus({
    required String status
  }) async {
    try {
      await _firestore.collection("PhysicalStatus").add({
        "status": status,
        "isActive": true,
      });

      fetchPhysicalStatus();
      Get.snackbar("Success", "PhysicalStatus added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add PhysicalStatus : $e");
    }
  }
}

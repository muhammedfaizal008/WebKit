import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/marital_status_model.dart';
import 'package:webkit/views/apps/members/masters/marital_status.dart';

class MaritalStatusController extends MyController {
  DataTableSource? data;
  List<MaritalStatusModel> MaritalStatusList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchMaritalStatus();
  }

  void fetchMaritalStatus() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('MaritalStatus').get();

      MaritalStatusList = snapshot.docs
          .map((doc) => MaritalStatusModel.fromDoc(doc))
          .toList();

      data = MaritalStatusDataSource(MaritalStatusList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching Marital status : $e');
      Get.snackbar("Error", "Failed to fetch Marital status  list");
    }
  }

  Future<void> editMaritalStatus(String id, String newStatus) async {
    try {
      await _firestore
          .collection("MaritalStatus")
          .doc(id)
          .update({"status": newStatus});

      fetchMaritalStatus();
      Get.snackbar("Success", "Marital status  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update Marital status : $e");
    }
  }

  Future<void> addMaritalStatus({
    required String status
  }) async {
    try {
      await _firestore.collection("MaritalStatus").add({
        "status": status,
        "isActive": true,
      });

      fetchMaritalStatus();
      Get.snackbar("Success", "Marital status added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add Marital status : $e");
    }
  }
}

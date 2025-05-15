import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/resident_status_model.dart';
import 'package:webkit/views/apps/members/profile_attributes/resident_status.dart';




class ResidentStatusController extends MyController {
  DataTableSource? data;
  List<ResidentStatusModel> ResidentStatusList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchResidentStatus();
  }

  void fetchResidentStatus() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('ResidentStatus')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    ResidentStatusList = snapshot.docs 
        .map((doc) => ResidentStatusModel.fromDoc(doc))
        .toList();

    data = ResidentStatusDataSource(ResidentStatusList, this);
    update();
  } catch (e) {
    print('Error fetching ResidentStatus: $e');
    Get.snackbar("Error", "Failed to fetch ResidentStatus list");
  }
}

  Future<void> editResidentStatus(String id, String newName) async {
    try {
      await _firestore
          .collection("ResidentStatus")
          .doc(id)
          .update({"name": newName});

      fetchResidentStatus();
      Get.snackbar("Success", "ResidentStatus  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update ResidentStatus : $e");
    }
  }

  Future<void> addResidentStatus({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("ResidentStatus")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("ResidentStatus").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchResidentStatus();
    Get.snackbar("Success", "ResidentStatus added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add ResidentStatus: $e");
  }
}
}

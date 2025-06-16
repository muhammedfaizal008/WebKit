import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/family_status_model.dart';
import 'package:webkit/views/apps/members/masters/family_values/family_status.dart';



class FamilyStatusController extends MyController {
  DataTableSource? data;
  List<FamilyStatusModel> FamilyStatusList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchFamilyStatus();
  }

  void fetchFamilyStatus() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('FamilyStatus')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    FamilyStatusList = snapshot.docs 
        .map((doc) => FamilyStatusModel.fromDoc(doc))
        .toList();

    data = FamilyStatusDataSource(FamilyStatusList, this);
    update();
  } catch (e) {
    print('Error fetching FamilyStatus: $e');
    Get.snackbar("Error", "Failed to fetch FamilyStatus list");
  }
}

  Future<void> editFamilyStatus(String id, String newName) async {
    try {
      await _firestore
          .collection("FamilyStatus")
          .doc(id)
          .update({"name": newName});

      fetchFamilyStatus();
      Get.snackbar("Success", "FamilyStatus  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update FamilyStatus : $e");
    }
  }

  Future<void> addFamilyStatus({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("FamilyStatus")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("FamilyStatus").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchFamilyStatus();
    Get.snackbar("Success", "FamilyStatus added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add FamilyStatus: $e");
  }
}
bool? selectedFamilyStatus; // true = Active, false = Inactive, null = no filter

  void onFamilyStatusChanged(bool? value) {
    selectedFamilyStatus = value;
    update(); 
  }
  void editFamilyStatusStatus(String id, bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection('FamilyStatus')
          .doc(id)
          .update({'isActive': status});
      fetchFamilyStatus();
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    }
  }
}

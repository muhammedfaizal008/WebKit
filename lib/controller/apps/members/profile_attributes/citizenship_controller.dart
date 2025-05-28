import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/citizenship_model.dart';
import 'package:webkit/views/apps/members/masters/citizenship.dart';



class CitizenshipController extends MyController {
  DataTableSource? data;
  List<CitizenshipModel> CitizenshipList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCitizenship();
  }

  void fetchCitizenship() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('Citizenship')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    CitizenshipList = snapshot.docs 
        .map((doc) => CitizenshipModel.fromDoc(doc))
        .toList();

    data = CitizenshipDataSource(CitizenshipList, this);
    update();
  } catch (e) {
    print('Error fetching Citizenship: $e');
    Get.snackbar("Error", "Failed to fetch Citizenship list");
  }
}

  Future<void> editCitizenship(String id, String newName) async {
    try {
      await _firestore
          .collection("Citizenship")
          .doc(id)
          .update({"name": newName});

      fetchCitizenship();
      Get.snackbar("Success", "Citizenship  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update Citizenship : $e");
    }
  }

  Future<void> addCitizenship({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("Citizenship")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("Citizenship").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchCitizenship();
    Get.snackbar("Success", "Citizenship added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add Citizenship: $e");
  }
}
}

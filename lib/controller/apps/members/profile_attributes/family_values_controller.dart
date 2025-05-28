import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/drinking_habits_model.dart';
import 'package:webkit/models/family_values_model.dart';
import 'package:webkit/views/apps/members/masters/family_values/family_values.dart';
import 'package:webkit/views/apps/members/masters/lifestyle/drinking_habits.dart';


class FamilyValuesController extends MyController {
  DataTableSource? data;
  List<FamilyValuesModel> FamilyValuesList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchFamilyValues();
  }

  void fetchFamilyValues() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('FamilyValues')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    FamilyValuesList = snapshot.docs 
        .map((doc) => FamilyValuesModel.fromDoc(doc))
        .toList();

    data = FamilyValuesDataSource(FamilyValuesList, this);
    update();
  } catch (e) {
    print('Error fetching FamilyValues: $e');
    Get.snackbar("Error", "Failed to fetch FamilyValues list");
  }
}

  Future<void> editFamilyValues(String id, String newName) async {
    try {
      await _firestore
          .collection("FamilyValues")
          .doc(id)
          .update({"name": newName});

      fetchFamilyValues();
      Get.snackbar("Success", "FamilyValues  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update FamilyValues : $e");
    }
  }

  Future<void> addFamilyValues({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("FamilyValues")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("FamilyValues").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchFamilyValues();
    Get.snackbar("Success", "FamilyValues added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add FamilyValues: $e");
  }
}
}

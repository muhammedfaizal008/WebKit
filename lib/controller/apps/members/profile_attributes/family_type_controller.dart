import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/family_type_model.dart';
import 'package:webkit/views/apps/members/masters/family_values/family_type.dart' show FamilyTypeDataSource;



class FamilyTypeController extends MyController {
  DataTableSource? data;
  List<FamilyTypeModel> FamilyTypeList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchFamilyType();
  }

  void fetchFamilyType() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('FamilyType')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    FamilyTypeList = snapshot.docs 
        .map((doc) => FamilyTypeModel.fromDoc(doc))
        .toList();

    data = FamilyTypeDataSource(FamilyTypeList, this);
    update();
  } catch (e) {
    print('Error fetching FamilyType: $e');
    Get.snackbar("Error", "Failed to fetch FamilyType list");
  }
}

  Future<void> editFamilyType(String id, String newName) async {
    try {
      await _firestore
          .collection("FamilyType")
          .doc(id)
          .update({"name": newName});

      fetchFamilyType();
      Get.snackbar("Success", "FamilyType  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update FamilyType : $e");
    }
  }

  Future<void> addFamilyType({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("FamilyType")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("FamilyType").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchFamilyType();
    Get.snackbar("Success", "FamilyType added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add FamilyType: $e");
  }
}
bool? selectedfamilyTypeStatus; // true = Active, false = Inactive, null = no filter

  void onfamilyTypeStatusChanged(bool? value) {
    selectedfamilyTypeStatus = value;
    update(); 
  }
  void editFamilyTypeStatus(String id, bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection('FamilyType')
          .doc(id)
          .update({'isActive': status});
      fetchFamilyType();
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    }
  }
}

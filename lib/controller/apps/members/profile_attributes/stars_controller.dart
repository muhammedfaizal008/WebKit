import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/stars_model.dart';
import 'package:webkit/views/apps/members/masters/stars.dart';

class StarsController extends MyController {
  DataTableSource? data;
  List<StarsModel> StarsList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchStars();
  }

  void fetchStars() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('Stars')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    StarsList = snapshot.docs 
        .map((doc) => StarsModel.fromDoc(doc))
        .toList();

    data = StarsDataSource(StarsList, this);
    update();
  } catch (e) {
    print('Error fetching Stars: $e');
    Get.snackbar("Error", "Failed to fetch Stars list");
  }
}

  Future<void> editStars(String id, String newName) async {
    try {
      await _firestore
          .collection("Stars")
          .doc(id)
          .update({"name": newName});

      fetchStars();
      Get.snackbar("Success", "Stars  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update Stars : $e");
    }
  }

  Future<void> addStars({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("Stars")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("Stars").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchStars();
    Get.snackbar("Success", "Stars added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add Stars: $e");
  }
}
bool? selectedstarStatus; // true = Active, false = Inactive, null = no filter

  void onstarStatusChanged(bool? value) {
    selectedstarStatus = value;
    update(); 
  }
  void editStarsStatus(String id, bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection('Stars')
          .doc(id)
          .update({'isActive': status});
      fetchStars();
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    }
  }
}

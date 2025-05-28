import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/smoking_habits_model.dart';
import 'package:webkit/views/apps/members/masters/lifestyle/smoking_habits.dart';






class SmokingHabitsController extends MyController {
  DataTableSource? data;
  List<SmokingHabitsModel> SmokingHabitsList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchSmokingHabits();
  }

  void fetchSmokingHabits() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('SmokingHabits')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    SmokingHabitsList = snapshot.docs 
        .map((doc) => SmokingHabitsModel.fromDoc(doc))
        .toList();

    data = SmokingHabitsDataSource(SmokingHabitsList, this);
    update();
  } catch (e) {
    print('Error fetching SmokingHabits: $e');
    Get.snackbar("Error", "Failed to fetch SmokingHabits list");
  }
}

  Future<void> editSmokingHabits(String id, String newName) async {
    try {
      await _firestore
          .collection("SmokingHabits")
          .doc(id)
          .update({"name": newName});

      fetchSmokingHabits();
      Get.snackbar("Success", "SmokingHabits  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update SmokingHabits : $e");
    }
  }

  Future<void> addSmokingHabits({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("SmokingHabits")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("SmokingHabits").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchSmokingHabits();
    Get.snackbar("Success", "SmokingHabits added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add SmokingHabits: $e");
  }
}
}

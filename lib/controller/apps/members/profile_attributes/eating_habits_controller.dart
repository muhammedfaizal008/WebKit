import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/eating_habits_model.dart';
import 'package:webkit/views/apps/members/profile_attributes/lifestyle/eating_habits.dart';





class EatingHabitsController extends MyController {
  DataTableSource? data;
  List<EatingHabitsModel> EatingHabitsList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchEatingHabits();
  }

  void fetchEatingHabits() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('EatingHabits')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    EatingHabitsList = snapshot.docs 
        .map((doc) => EatingHabitsModel.fromDoc(doc))
        .toList();

    data = EatingHabitsDataSource(EatingHabitsList, this);
    update();
  } catch (e) {
    print('Error fetching EatingHabits: $e');
    Get.snackbar("Error", "Failed to fetch EatingHabits list");
  }
}

  Future<void> editEatingHabits(String id, String newName) async {
    try {
      await _firestore
          .collection("EatingHabits")
          .doc(id)
          .update({"name": newName});

      fetchEatingHabits();
      Get.snackbar("Success", "EatingHabits  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update EatingHabits : $e");
    }
  }

  Future<void> addEatingHabits({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("EatingHabits")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("EatingHabits").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchEatingHabits();
    Get.snackbar("Success", "EatingHabits added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add EatingHabits: $e");
  }
}
}

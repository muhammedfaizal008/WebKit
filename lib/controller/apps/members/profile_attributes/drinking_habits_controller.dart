import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/drinking_habits_model.dart';
import 'package:webkit/views/apps/members/masters/lifestyle/drinking_habits.dart';






class DrinkingHabitsController extends MyController {
  DataTableSource? data;
  List<DrinkingHabitsModel> DrinkingHabitsList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchDrinkingHabits();
  }

  void fetchDrinkingHabits() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('DrinkingHabits')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    DrinkingHabitsList = snapshot.docs 
        .map((doc) => DrinkingHabitsModel.fromDoc(doc))
        .toList();

    data = DrinkingHabitsDataSource(DrinkingHabitsList, this);
    update();
  } catch (e) {
    print('Error fetching DrinkingHabits: $e');
    Get.snackbar("Error", "Failed to fetch DrinkingHabits list");
  }
}

  Future<void> editDrinkingHabits(String id, String newName) async {
    try {
      await _firestore
          .collection("DrinkingHabits")
          .doc(id)
          .update({"name": newName});

      fetchDrinkingHabits();
      Get.snackbar("Success", "DrinkingHabits  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update DrinkingHabits : $e");
    }
  }

  Future<void> addDrinkingHabits({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("DrinkingHabits")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("DrinkingHabits").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchDrinkingHabits();
    Get.snackbar("Success", "DrinkingHabits added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add DrinkingHabits: $e");
  }
}
}

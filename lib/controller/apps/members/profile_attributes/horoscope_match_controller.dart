import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/horoscope_match_model.dart';

import 'package:webkit/views/apps/members/masters/horoscope_match.dart';

class HoroscopeMatchController extends MyController {
  DataTableSource? data;
  List<HoroscopeMatchModel> HoroscopeMatchList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchHoroscopeMatch();
  }

  void fetchHoroscopeMatch() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('HoroscopeMatch')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    HoroscopeMatchList = snapshot.docs 
        .map((doc) => HoroscopeMatchModel.fromDoc(doc))
        .toList();

    data = HoroscopeMatchDataSource(HoroscopeMatchList, this);
    update();
  } catch (e) {
    print('Error fetching HoroscopeMatch: $e');
    Get.snackbar("Error", "Failed to fetch HoroscopeMatch list");
  }
}

  Future<void> editHoroscopeMatch(String id, String newName) async {
    try {
      await _firestore
          .collection("HoroscopeMatch")
          .doc(id)
          .update({"name": newName});

      fetchHoroscopeMatch();
      Get.snackbar("Success", "HoroscopeMatch  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update HoroscopeMatch : $e");
    }
  }

  Future<void> addHoroscopeMatch({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("HoroscopeMatch")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("HoroscopeMatch").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchHoroscopeMatch();
    Get.snackbar("Success", "HoroscopeMatch added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add HoroscopeMatch: $e");
  }
}
bool? selectedhoroscopeMatch; // true = Active, false = Inactive, null = no filter

  void onhoroscopeMatchChanged(bool? value) {
    selectedhoroscopeMatch = value;
    update(); 
  }
  void edithoroscopeMatchStatus(String id, bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection('HoroscopeMatch')
          .doc(id)
          .update({'isActive': status});
      fetchHoroscopeMatch();
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    }
  }
}

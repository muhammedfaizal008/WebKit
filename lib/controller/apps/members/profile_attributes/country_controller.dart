import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/country_model.dart';
import 'package:webkit/views/apps/members/profile_attributes/country.dart';


class CountryController extends MyController {
  DataTableSource? data;
  List<CountryModel> CountryList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCountry();
  }

  void fetchCountry() async {
  try {
    final QuerySnapshot snapshot = await _firestore.collection('Country')
        .orderBy('sortOrder', descending: false) // Sort by our custom order
        .get();

    CountryList = snapshot.docs 
        .map((doc) => CountryModel.fromDoc(doc))
        .toList();

    data = CountryDataSource(CountryList, this);
    update();
  } catch (e) {
    print('Error fetching Country: $e');
    Get.snackbar("Error", "Failed to fetch Country list");
  }
}

  Future<void> editCountry(String id, String newName) async {
    try {
      await _firestore
          .collection("Country")
          .doc(id)
          .update({"name": newName});

      fetchCountry();
      Get.snackbar("Success", "Country  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update Country : $e");
    }
  }

  Future<void> addCountry({required String name}) async {
  try {
    // Get the current highest sortOrder value
    final lastDoc = await _firestore.collection("Country")
        .orderBy("sortOrder", descending: true)
        .limit(1)
        .get();

    int newSortOrder = 1; // Default if no documents exist
    
    if (lastDoc.docs.isNotEmpty) {
      newSortOrder = (lastDoc.docs.first['sortOrder'] as int) + 1;
    }

    await _firestore.collection("Country").add({
      "name": name,
      "isActive": true,
      "sortOrder": newSortOrder, // Add the auto-incremented value
      "createdAt": FieldValue.serverTimestamp(),
    });

    fetchCountry();
    Get.snackbar("Success", "Country added successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to add Country: $e");
  }
}
}

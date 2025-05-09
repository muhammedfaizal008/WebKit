import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/occupation_model.dart';
import 'package:webkit/views/apps/members/profile_attributes/occupation.dart';


class OccupationController extends MyController {
  DataTableSource? data;
  List<OccupationModel> OccupationList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchOccupation();
  }

  void fetchOccupation() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('Occupation').get();

      OccupationList = snapshot.docs 
          .map((doc) => OccupationModel.fromDoc(doc))
          .toList();

      data = OccupationDataSource(OccupationList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching Occupation : $e');
      Get.snackbar("Error", "Failed to fetch Occupation  list");
    }
  }

  Future<void> editOccupation(String id, String newName) async {
    try {
      await _firestore
          .collection("Occupation")
          .doc(id)
          .update({"name": newName});

      fetchOccupation();
      Get.snackbar("Success", "Occupation  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update Occupation : $e");
    }
  }

  Future<void> addOccupation({
    required String name
  }) async {
    try {
      await _firestore.collection("Occupation").add({
        "name": name,
        "isActive": true,
      });

      fetchOccupation();
      Get.snackbar("Success", "Occupation added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add Occupation : $e");
    }
  }
}

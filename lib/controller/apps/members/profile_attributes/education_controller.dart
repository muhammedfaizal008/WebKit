import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/education_model.dart';
import 'package:webkit/views/apps/members/masters/education.dart';

class EducationController extends MyController {
  DataTableSource? data;
  List<EducationModel> EducationList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchEducation();
  }

  void fetchEducation() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('Education').get();

      EducationList = snapshot.docs 
          .map((doc) => EducationModel.fromDoc(doc))
          .toList();

      data = EducationDataSource(EducationList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching Education : $e');
      Get.snackbar("Error", "Failed to fetch Education  list");
    }
  }

  Future<void> editEducation(String id, String newName) async {
    try {
      await _firestore
          .collection("Education")
          .doc(id)
          .update({"name": newName});

      fetchEducation();
      Get.snackbar("Success", "Education  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update Education : $e");
    }
  }

  Future<void> addEducation({
    required String name
  }) async {
    try {
      await _firestore.collection("Education").add({
        "name": name,
        "isActive": true,
      });

      fetchEducation();
      Get.snackbar("Success", "Education added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add Education : $e");
    }
  }
}

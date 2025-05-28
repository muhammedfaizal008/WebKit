import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/gender_model.dart';
import 'package:webkit/views/apps/members/masters/gender.dart';



class GenderController extends MyController {
  DataTableSource? data;
  List<GenderModel> GenderList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchGender();
  }

  void fetchGender() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('Gender').get();    

      GenderList = snapshot.docs 
          .map((doc) => GenderModel.fromDoc(doc))
          .toList();

      data = GenderDataSource(GenderList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching Gender : $e');
      Get.snackbar("Error", "Failed to fetch Gender  list");
    }
  }

  Future<void> editGender(String id, String newName) async {
    try {
      await _firestore
          .collection("Gender")
          .doc(id)
          .update({"name": newName});

      fetchGender();
      Get.snackbar("Success", "Gender  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update Gender : $e");
    }
  }

  Future<void> addGender({
    required String name
  }) async {
    try {
      await _firestore.collection("Gender").add({
        "name": name,
        "isActive": true,
      });

      fetchGender();
      Get.snackbar("Success", "Gender added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add Gender : $e");
    }
  }
}

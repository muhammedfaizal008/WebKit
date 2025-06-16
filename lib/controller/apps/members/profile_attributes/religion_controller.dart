import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/religion_model.dart';
import 'package:webkit/views/apps/members/masters/religion.dart';

class ReligionController extends MyController {
  DataTableSource? data;
  List<ReligionModel> religionList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchReligions();
  }

  void fetchReligions() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Religion').get();

    religionList =
        snapshot.docs.map((doc) => ReligionModel.fromDoc(doc)).toList();

    data = ReligionDataSource(
      religionList,this
      
    );
    update(); // Refresh UI
  }

  Future<void> editReligion(String id, String newReligionName) async {
  try {
    await _firestore
        .collection("Religion")
        .doc(id)
        .update({"name": newReligionName});
        
    fetchReligions();
    Get.snackbar("Success", "Religion updated successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to update religion: $e");
  }
}


  Future<void> addReligion(String Religion) async {
    try {
      _firestore
          .collection("Religion")
          .add({"name": Religion, "isActive": true});
      fetchReligions();
      Get.snackbar("Success", "Religion Added");
    } catch (e) {
      print(e);
    }
  }
  bool? selectedReligion; // true = Active, false = Inactive, null = no filter

  void onReligionChanged(bool? value) {
    selectedReligion = value;
    update(); 
  }
  void editReligionStatus(String id, bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection('Religion')
          .doc(id)
          .update({'isActive': status});
      fetchReligions();
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    }
  }
}

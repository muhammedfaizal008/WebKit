import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/mother_tongue_model.dart';
import 'package:webkit/views/apps/members/masters/mother_tongue.dart';

class MotherTongueController extends MyController{
  DataTableSource? data;
  List<MotherTongueModel> MotherTongueList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchMotherTongues();
  }

  void fetchMotherTongues() async {
  try {
    final QuerySnapshot snapshot =
        await _firestore.collection('languages').get();

    MotherTongueList = snapshot.docs
        .map((doc) => MotherTongueModel.fromDoc(doc))
        .toList();

    data = MotherTongueDataSource(MotherTongueList, this);
    log("Fetched ${MotherTongueList.length} languages");
    update();
  } catch (e) {
    log("Firestore fetch failed: $e");
  }
}


  Future<void> editMotherTongue(String id, String newMotherTongueName) async {
  try {
    await _firestore
        .collection("languages")
        .doc(id)
        .update({"name": newMotherTongueName});
        
    fetchMotherTongues(); 
    Get.snackbar("Success", "MotherTongue updated successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Failed to update MotherTongue: $e");
  }
}


  Future<void> addMotherTongue(String MotherTongue) async {
    try {
      _firestore
          .collection("languages")
          .add({"name": MotherTongue, "status": true});
      fetchMotherTongues();
      Get.snackbar("Success", "MotherTongue Added");
    } catch (e) {
      print(e);
    }
  }
  bool? selectedMotherTongue; // true = Active, false = Inactive, null = no filter

  void onMotherTongueChanged(bool? value) {
    selectedMotherTongue = value;
    update(); 
  }
  void editGenderStatus(String id, bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection('languages')
          .doc(id)
          .update({'status': status});
      fetchMotherTongues();
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    }
  }
}
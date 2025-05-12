import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/caste_model.dart';
import 'package:webkit/models/religion_model.dart';
import 'package:webkit/views/apps/members/profile_attributes/caste.dart';
import 'package:webkit/views/apps/members/profile_attributes/religion.dart';

class CasteController extends MyController {
  DataTableSource? data;
  List<CasteModel> casteList = [];
  List<ReligionModel> religionList = [];
  String religion = "";

  String selectedReligionId = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchcastes();
    fetchReligions();
  }

  void fetchReligions() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Religion').get();

    religionList =
        snapshot.docs.map((doc) => ReligionModel.fromDoc(doc)).toList();

    update(); // Refresh UI
  }
  
  Future<void> fetchcastes() async {
    casteList.clear();

    for (var religion in religionList) {
      final snapshot = await _firestore
          .collection('Religion')
          .doc(religion.id)
          .collection('castes')
          .get();

      casteList.addAll(
        snapshot.docs.map((doc) => CasteModel.fromDoc(doc, religion.id)),
      );
    }

    data = casteDataSource(casteList, this);
    update();
  }

  Future<void> addCaste(String casteName, String religionName) async {
    try {
      // Find the religion document by name (or use ID if applicable)
      final religion =
          religionList.firstWhere((religion) => religion.name == religionName);

      // Add caste under the selected religion
      await FirebaseFirestore.instance
          .collection('Religion')
          .doc(religion.id)
          .collection('castes')
          .add({
        'name': casteName,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true, // Optional: Add more fields as needed
      });

      // Refresh the list of castes
      fetchcastes();
      Get.snackbar("Success", "Caste added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add caste: $e");
    }
  }

  Future<void> editCaste(
      String religionId, String casteId, String newName) async {
    try {
      await _firestore
          .collection("Religion")
          .doc(religionId)
          .collection("castes")
          .doc(casteId)
          .update({"name": newName});

      fetchcastes();
      Get.snackbar("Success", "Caste updated");
    } catch (e) {
      print("Edit caste error: $e");
      Get.snackbar("Error", "Failed to update caste");
    }
  }

  Future<List<CasteModel>> getCastesByReligion(String religionId) async {
    try {
      final snapshot = await _firestore
          .collection('Religion')
          .doc(religionId)
          .collection('castes')
          .get();

      return snapshot.docs
          .map((doc) => CasteModel.fromDoc(doc, religionId))
          .toList();
    } catch (e) {
      print("Error fetching castes: $e");
      return [];
    }
  }
}

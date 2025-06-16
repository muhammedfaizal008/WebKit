import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/caste_model.dart';
import 'package:webkit/models/religion_model.dart';
import 'package:webkit/views/apps/members/masters/caste.dart';
import 'package:webkit/views/apps/members/masters/religion.dart';

class CasteController extends MyController {
  DataTableSource? data;
  List<CasteModel> casteList = [];
  List<ReligionModel> religionList = [];
  String religion = "";
  bool isLoading=false;
  bool isInitialLoad=false;

  String selectedReligionId = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit(); 
      fetchReligionsAndCastes(); 

    
  }

  Future<void> fetchReligionsAndCastes() async {
  try {
    // Set loading state
    isLoading = true;
    isInitialLoad = true;
    update();

    // Clear existing data
    religionList.clear();
    casteList.clear();

    // 1. First fetch all religions
    final QuerySnapshot religionSnapshot = 
        await FirebaseFirestore.instance.collection('Religion').get();

    religionList = 
        religionSnapshot.docs.map((doc) => ReligionModel.fromDoc(doc)).toList();

    // 2. Then fetch castes for all religions in parallel
    final futures = religionList.map((religion) async {
      final casteSnapshot = await _firestore
          .collection('Religion')
          .doc(religion.id)
          .collection('castes')
          .get();

      return casteSnapshot.docs.map((doc) => CasteModel.fromDoc(doc, religion.id));
    }
    );

        final results = await Future.wait(futures);
        casteList = results.expand((x) => x).toList();

        // 3. Create data source
        data = casteDataSource(casteList, this);
  } catch (e) {
    Get.snackbar("Error", "Failed to load data: ${e.toString()}");
  } finally {
    isLoading = false;
    isInitialLoad = false;
    update();
  }
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
        await fetchReligionsAndCastes();
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

      await fetchReligionsAndCastes();
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
  bool? selectedCasteStatus; // true = Active, false = Inactive, null = no filter

  void oncasteStatusChanged(bool? value) {
    selectedCasteStatus = value;
    update(); 
  }
  Future<void> editCasteStatus(String religionId, String casteId, bool status) async {
    try {
      await _firestore
          .collection("Religion")
          .doc(religionId)
          .collection("castes")
          .doc(casteId)
          .update({"isActive": status});

      await fetchReligionsAndCastes();
      Get.snackbar("Success", "Caste status updated");
    } catch (e) {
      print("Edit caste status error: $e");
      Get.snackbar("Error", "Failed to update caste status");
    }
  }
}

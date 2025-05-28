import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/annual_income_model.dart';
import 'package:webkit/views/apps/members/masters/annual_income.dart';

class AnnualIncomeController extends MyController {
  DataTableSource? data;
  List<AnnualIncomeModel> AnnualIncomeList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchAnnualIncome();
  }

  void fetchAnnualIncome() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('AnnualIncome').get();

      AnnualIncomeList = snapshot.docs 
          .map((doc) => AnnualIncomeModel.fromDoc(doc))
          .toList();

      data = AnnualIncomeDataSource(AnnualIncomeList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching AnnualIncome : $e');
      Get.snackbar("Error", "Failed to fetch AnnualIncome  list");
    }
  }

  Future<void> editAnnualIncome(String id, String newRange) async {
    try {
      await _firestore
          .collection("AnnualIncome")
          .doc(id)
          .update({"range": newRange});

      fetchAnnualIncome();
      Get.snackbar("Success", "AnnualIncome  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update AnnualIncome : $e");
    }
  }

  Future<void> addAnnualIncome({
    required String range,
  }) async {
    try {
      // Get the current max sort_by value
      final querySnapshot = await _firestore
          .collection("AnnualIncome")     
          .orderBy("sort_by", descending: true)
          .limit(1)
          .get();

      int nextSortBy = 1;
      if (querySnapshot.docs.isNotEmpty) {
        final currentMax = querySnapshot.docs.first.data()["sort_by"];
        if (currentMax is int) {
          nextSortBy = currentMax + 1;
        }
      }

      await _firestore.collection("AnnualIncome").add({
        "range": range,
        "sort_by": nextSortBy,
        "isActive": true,
      });

      fetchAnnualIncome();
      Get.snackbar("Success", "AnnualIncome added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add AnnualIncome : $e");
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/packages_model.dart';
import 'package:webkit/views/apps/subscription_packages/all_packages.dart';

class SubcriptionPackagesController extends MyController {
   DataTableSource? data;
  List<PackagesModel> PackagesList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();
  }

  void fetchPackages() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('Packages').get();

      PackagesList = snapshot.docs 
          .map((doc) => PackagesModel.fromDoc(doc))
          .toList();

      data = PackagesDataSource(PackagesList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching Packages : $e');
      Get.snackbar("Error", "Failed to fetch Packages  list");
    }
  }

  Future<void> editPackages(String id, String newRange) async {
    try {
      await _firestore
          .collection("Packages")
          .doc(id)
          .update({"range": newRange});

      fetchPackages();
      Get.snackbar("Success", "Packages  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update Packages : $e");
    }
  }

  Future<void> addPackages({
    required String range,
  }) async {
    try {
      // Get the current max sort_by value
      final querySnapshot = await _firestore
          .collection("Packages")     
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

      await _firestore.collection("Packages").add({
        "range": range,
        "sort_by": nextSortBy,
        "isActive": true,
      });

      fetchPackages();
      Get.snackbar("Success", "Packages added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add Packages : $e");
    }
  }
  bool? selectedPackages; // true = Active, false = Inactive, null = no filter

  void onPackagesChanged(bool? value) {
    selectedPackages = value;
    update(); 
  }
  void editPackagesStatus(String id, bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection('Packages')
          .doc(id)
          .update({'isActive': status});
      fetchPackages();
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    }
  }
}
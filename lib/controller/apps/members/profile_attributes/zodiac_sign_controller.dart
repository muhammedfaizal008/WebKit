import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/zodiac_sign.dart';
import 'package:webkit/views/apps/members/masters/zodiac_sign.dart';

class ZodiacSignController extends MyController {
  DataTableSource? data;
  List<ZodiacSignModel> ZodiacSignList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchZodiacSign();
  }

  void fetchZodiacSign() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('ZodiacSign').get();

      ZodiacSignList = snapshot.docs 
          .map((doc) => ZodiacSignModel.fromDoc(doc))
          .toList();

      data = ZodiacSignDataSource(ZodiacSignList, this);
      update(); // Refresh UI
    } catch (e) {
      print('Error fetching ZodiacSign : $e');
      Get.snackbar("Error", "Failed to fetch ZodiacSign  list");
    }
  }

  Future<void> editZodiacSign(String id, String newName) async {
    try {
      await _firestore
          .collection("ZodiacSign")
          .doc(id)
          .update({"name": newName});

      fetchZodiacSign();
      Get.snackbar("Success", "ZodiacSign  updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update ZodiacSign : $e");
    }
  }

  Future<void> addZodiacSign({
    required String name
  }) async {
    try {
      await _firestore.collection("ZodiacSign").add({
        "name": name,
        "isActive": true,
      });

      fetchZodiacSign();
      Get.snackbar("Success", "ZodiacSign added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add ZodiacSign : $e");
    }
  }
}

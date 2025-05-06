import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/caste_model.dart';
import 'package:webkit/views/apps/members/profile_attributes/caste.dart';

class CasteController extends MyController {
  DataTableSource? data;
  List<CasteModel> casteList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchcastes();
  }

  void fetchcastes() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Caste').get();

    casteList =
        snapshot.docs.map((doc) => CasteModel.fromDoc(doc)).toList();

    data = casteDataSource(casteList,this);
    update(); // Refresh UI
  }

  Future<void> addCaste(String caste) async {
    try {
      _firestore
          .collection("Caste")
          .add({"name": caste, "isActive": true});
      fetchcastes(); 
      Get.snackbar("Success", "caste Added");
        
    } catch (e) {
      print(e);
    }
  }
  Future<void> editCaste(String id, String newCasteName) async {
  try {
    await _firestore
        .collection("Caste")
        .doc(id)
        .update({"name": newCasteName});
        
    fetchcastes();
    Get.snackbar("Success", "Caste updated successfully");
  } catch (e) {
    print(e);
    Get.snackbar("Error", "Caste to update religion: $e");
  }
}
}

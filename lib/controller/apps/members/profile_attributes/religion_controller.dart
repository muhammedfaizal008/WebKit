import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/religion_model.dart';
import 'package:webkit/views/apps/members/profile_attributes/religion.dart';


class ReligionController extends MyController {
  DataTableSource? data;
  List<ReligionModel> religionList = [];

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

    data = ReligionDataSource(religionList);
    update(); // Refresh UI
  }
}

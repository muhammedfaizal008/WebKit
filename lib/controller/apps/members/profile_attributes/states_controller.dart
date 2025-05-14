  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:webkit/controller/my_controller.dart';
  import 'package:webkit/models/country_model.dart';
  import 'package:webkit/models/states_model.dart';
  import 'package:webkit/views/apps/members/profile_attributes/state.dart';


 class StatesController extends MyController {
  DataTableSource? data;
  List<StatesModel> statesList = [];
  List<CountryModel> countryList = [];
  Map<String, String> countryNames = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCountriesAndStates();
  }

  Future<void> fetchCountriesAndStates() async {
    try {
      // Fetch countries
      final countrySnapshot = await _firestore.collection('Country').orderBy('sortOrder').get();
      
      countryList = countrySnapshot.docs.map((doc) {
        return CountryModel(
          id: doc.id,
          name: doc['name'],
          sortOrder: doc['sortOrder'] ?? 0,
          isActive: doc["isActive"]
        );
      }).toList();
      
      // Create country names mapping
      countryNames = {for (var c in countryList) c.id: c.name};
      
      // Fetch states for each country
      List<StatesModel> allStates = [];
      for (var country in countryList) {
        final stateSnapshot = await _firestore
            .collection('Country')
            .doc(country.id)
            .collection('States') // Ensure consistent case
            .orderBy('sortOrder')
            .get();

        final countryStates = stateSnapshot.docs.map((doc) => 
            StatesModel.fromDoc(doc, countryId: country.id)).toList();
        allStates.addAll(countryStates);
      }

      statesList = allStates;
      data = StatesDataSource(statesList, this, countryNames);
      update();
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to load data");
    }
  }

  Future<void> editState(String id, String newName, String countryId) async {
    try {
      await _firestore
          .collection('Country')
          .doc(countryId)
          .collection('States')
          .doc(id)
          .update({"name": newName});

      fetchCountriesAndStates();
      Get.snackbar("Success", "State updated successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to update state: $e");
    }
  }

  Future<void> deleteState(String id, String countryId) async {
    try {
      await _firestore
          .collection('Country')
          .doc(countryId)
          .collection('States')
          .doc(id)
          .delete();

      fetchCountriesAndStates();
      Get.snackbar("Success", "State deleted successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to delete state: $e");
    }
  }

  Future<void> addState({required String stateName, required String countryName}) async {
    try {
      final country = countryList.firstWhere(
        (c) => c.name == countryName,
        orElse: () => throw Exception("Country not found")
      );

      final lastDoc = await _firestore
          .collection('Country')
          .doc(country.id)
          .collection('States')
          .orderBy("sortOrder", descending: true)
          .limit(1)
          .get();

      int newSortOrder = lastDoc.docs.isNotEmpty 
          ? (lastDoc.docs.first['sortOrder'] as int) + 1 
          : 1;

      await _firestore
          .collection('Country')
          .doc(country.id)
          .collection('States')
          .add({
        'name': stateName,
        'sortOrder': newSortOrder,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
      });

      fetchCountriesAndStates();
      Get.snackbar("Success", "State added successfully");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add state: ${e.toString()}");
    }
  }

  Future<List<StatesModel>> getStatesByCountry(String countryName) async {
    try {
      final country = countryList.firstWhere((c) => c.name == countryName);
      final snapshot = await _firestore
          .collection('Country')
          .doc(country.id)
          .collection('States')
          .orderBy('sortOrder')
          .get();

      return snapshot.docs.map((doc) => 
          StatesModel.fromDoc(doc, countryId: country.id)).toList();
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "Failed to fetch states");
      return [];
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class StatesModel {
  final String id;
  final String name;
  final int sortOrder;
  final String countryId;

  StatesModel({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.countryId,
  });

  factory StatesModel.fromDoc(DocumentSnapshot doc, {required String countryId}) {
    return StatesModel(
      id: doc.id,
      name: doc['name'] ?? '',
      sortOrder: doc['sortOrder'] ?? 0,
      countryId: countryId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sortOrder': sortOrder,
      'countryId': countryId,
    };
  }
}
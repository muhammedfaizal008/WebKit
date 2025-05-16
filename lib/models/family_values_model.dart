import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyValuesModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  FamilyValuesModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory FamilyValuesModel.fromDoc(DocumentSnapshot doc) {
    return FamilyValuesModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

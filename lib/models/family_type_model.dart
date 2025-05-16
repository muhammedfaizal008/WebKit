import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyTypeModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  FamilyTypeModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory FamilyTypeModel.fromDoc(DocumentSnapshot doc) {
    return FamilyTypeModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

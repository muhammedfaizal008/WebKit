import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyStatusModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  FamilyStatusModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory FamilyStatusModel.fromDoc(DocumentSnapshot doc) {
    return FamilyStatusModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

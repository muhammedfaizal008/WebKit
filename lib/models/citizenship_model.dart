import 'package:cloud_firestore/cloud_firestore.dart';

class CitizenshipModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  CitizenshipModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory CitizenshipModel.fromDoc(DocumentSnapshot doc) {
    return CitizenshipModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

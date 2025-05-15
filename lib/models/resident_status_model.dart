import 'package:cloud_firestore/cloud_firestore.dart';

class ResidentStatusModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  ResidentStatusModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory ResidentStatusModel.fromDoc(DocumentSnapshot doc) {
    return ResidentStatusModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

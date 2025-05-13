import 'package:cloud_firestore/cloud_firestore.dart';

class StarsModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  StarsModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory StarsModel.fromDoc(DocumentSnapshot doc) {
    return StarsModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

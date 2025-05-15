import 'package:cloud_firestore/cloud_firestore.dart';

class EatingHabitsModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  EatingHabitsModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory EatingHabitsModel.fromDoc(DocumentSnapshot doc) {
    return EatingHabitsModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

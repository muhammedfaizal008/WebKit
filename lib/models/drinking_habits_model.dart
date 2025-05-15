import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkingHabitsModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  DrinkingHabitsModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory DrinkingHabitsModel.fromDoc(DocumentSnapshot doc) {
    return DrinkingHabitsModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

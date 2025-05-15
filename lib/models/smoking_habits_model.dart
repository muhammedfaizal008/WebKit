import 'package:cloud_firestore/cloud_firestore.dart';

class SmokingHabitsModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  SmokingHabitsModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory SmokingHabitsModel.fromDoc(DocumentSnapshot doc) {
    return SmokingHabitsModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

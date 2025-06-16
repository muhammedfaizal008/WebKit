import 'package:cloud_firestore/cloud_firestore.dart';

class StatesModel {
  final String id;
  final String name;
  final int sortOrder;
  final String countryId;
  final Timestamp createdAt;
  final bool isActive;

  StatesModel({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.countryId,
    required this.createdAt,
    required this.isActive,
  });

  factory StatesModel.fromDoc(DocumentSnapshot doc, {required String countryId}) {
    return StatesModel(
      id: doc.id,
      name: doc['name'] ?? '',
      sortOrder: doc['sortOrder'] ?? 0,
      countryId: countryId,
      createdAt: doc['createdAt'] ?? Timestamp.now(),
      isActive: doc['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sortOrder': sortOrder,
      'countryId': countryId,
      'createdAt': createdAt,
      'isActive': isActive,
    };
  }
}
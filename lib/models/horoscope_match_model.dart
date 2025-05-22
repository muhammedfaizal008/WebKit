import 'package:cloud_firestore/cloud_firestore.dart';

class HoroscopeMatchModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  HoroscopeMatchModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory HoroscopeMatchModel.fromDoc(DocumentSnapshot doc) {
    return HoroscopeMatchModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

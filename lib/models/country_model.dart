import 'package:cloud_firestore/cloud_firestore.dart';

class CountryModel {
  final String id;
  final String name;
  final bool isActive;
  final int sortOrder;

  CountryModel({required this.id, required this.name,required this.isActive,required this.sortOrder});

  factory CountryModel.fromDoc(DocumentSnapshot doc) {
    return CountryModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      sortOrder: doc['sortOrder'] ?? 0,
    );
  }
}

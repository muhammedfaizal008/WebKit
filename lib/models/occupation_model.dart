import 'package:cloud_firestore/cloud_firestore.dart';

class OccupationModel {
  final String id;
  final String name;
  final bool isActive;

  OccupationModel({required this.id, required this.name,required this.isActive});

  factory OccupationModel.fromDoc(DocumentSnapshot doc) {
    return OccupationModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ReligionModel {
  final String id;
  final String name;
  final bool isActive;

  ReligionModel({required this.id, required this.name,required this.isActive});

  factory ReligionModel.fromDoc(DocumentSnapshot doc) {
    return ReligionModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
    );
  }
}

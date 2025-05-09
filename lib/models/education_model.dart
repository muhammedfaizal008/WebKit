import 'package:cloud_firestore/cloud_firestore.dart';

class EducationModel {
  final String id;
  final String name;
  final bool isActive;

  EducationModel({required this.id, required this.name,required this.isActive});

  factory EducationModel.fromDoc(DocumentSnapshot doc) {
    return EducationModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CasteModel {
  final String id;
  final String name;
  final bool isActive;
  final String religionId;

  CasteModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.religionId,
  });

  factory CasteModel.fromDoc(DocumentSnapshot doc, String religionId) {
    return CasteModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
      religionId: religionId,
    );
  }
}

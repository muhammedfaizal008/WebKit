import 'package:cloud_firestore/cloud_firestore.dart';

class CasteModel {
  final String id;
  final String name;
  final bool isActive;

  CasteModel({required this.id, required this.name,required this.isActive});

  factory CasteModel.fromDoc(DocumentSnapshot doc) {
    return CasteModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
    );
  }
}

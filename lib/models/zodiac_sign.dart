import 'package:cloud_firestore/cloud_firestore.dart';

class ZodiacSignModel {
  final String id;
  final String name;
  final bool isActive;

  ZodiacSignModel({required this.id, required this.name,required this.isActive});

  factory ZodiacSignModel.fromDoc(DocumentSnapshot doc) {
    return ZodiacSignModel(
      id: doc.id,
      name: doc['name'],
      isActive: doc['isActive'] ?? true,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class PhysicalStatusModel {
  final String id;
  final String status;
  final bool isActive;

  PhysicalStatusModel({required this.id, required this.status,required this.isActive});

  factory PhysicalStatusModel.fromDoc(DocumentSnapshot doc) {
    return PhysicalStatusModel(
      id: doc.id,
      status: doc['status'],
      isActive: doc['isActive'] ?? true,
    );
  }
}

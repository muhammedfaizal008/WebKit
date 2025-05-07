import 'package:cloud_firestore/cloud_firestore.dart';

class MaritalStatusModel {
  final String id;
  final String status;
  final bool isActive;

  MaritalStatusModel({
    required this.id,
    required this.status,
    required this.isActive,
  });

  factory MaritalStatusModel.fromDoc(DocumentSnapshot doc) {
    return MaritalStatusModel(
      id: doc.id,
      status: doc['status'] ?? '',
      isActive: doc['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'isActive': isActive,
    };
  }
}

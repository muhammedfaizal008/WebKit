  import 'package:cloud_firestore/cloud_firestore.dart';

  class AllStaffModel {
    final String id;
    final String staffName;
    final String role;
    final bool isActive;

    AllStaffModel({
      required this.id,
      required this.staffName,
      required this.role,
      required this.isActive,
    });

    factory AllStaffModel.fromDoc(DocumentSnapshot doc) {
      return AllStaffModel(
        id: doc.id,
        staffName:doc['staffName'],
        role: doc['role'] ?? '',
        isActive: doc['isActive'] ?? true,
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'staffName':staffName,
        'role': role,
        'isActive': isActive,
      };
    }
  }
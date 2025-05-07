
    import 'package:cloud_firestore/cloud_firestore.dart';

  class StaffRolesModel {
    final String id;

    final String role;
    final bool isActive;

    StaffRolesModel({
      required this.id,

      required this.role,
      required this.isActive,
    });

    factory StaffRolesModel.fromDoc(DocumentSnapshot doc) {
      return StaffRolesModel(
        id: doc.id,

        role: doc['role'] ?? '',
        isActive: doc['isActive'] ?? true,
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'role': role,
        'isActive': isActive,
      };
    }
  }


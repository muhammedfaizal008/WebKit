  import 'package:cloud_firestore/cloud_firestore.dart';

  class AllStaffModel {
    final String id;
    final String staffName;
    final String role;
    final bool isActive;
    final String email;
    final String status;
    final String uid;
    final Timestamp createdAt;
    final Timestamp updatedAt;

    AllStaffModel({
      required this.id,
      required this.staffName,
      required this.role,
      required this.isActive,
      required this.email,
      required this.status,
      required this.uid,
      required this.createdAt,
      required this.updatedAt,
    });

    factory AllStaffModel.fromDoc(DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return AllStaffModel(
        id: doc.id,
        staffName: data['fullName'] ?? '',
        role: data['role'] ?? '',
        isActive: data['isActive'] ?? true,
        email: data['email'] ?? '',
        status: data['status'] ?? '',
        uid: data['uid'] ?? '',
        createdAt: data['createdAt'] ?? Timestamp.now(),
        updatedAt: data['updatedAt'] ?? Timestamp.now(),
      );
    }

  }
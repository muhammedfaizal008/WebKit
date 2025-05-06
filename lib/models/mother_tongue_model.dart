  import 'package:cloud_firestore/cloud_firestore.dart';

  class MotherTongueModel {
    final String id;
    final String name;
    final String status;

    MotherTongueModel({required this.id, required this.name,required this.status});

    factory MotherTongueModel.fromDoc(DocumentSnapshot doc) {
      return MotherTongueModel(
        id: doc.id,
        name: doc['name'],
        status: doc['status'] ?? true,
      );
    }
  }

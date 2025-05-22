  import 'package:cloud_firestore/cloud_firestore.dart';

  class GenderModel {
    final String id;
    final String name;
    final bool status;

    GenderModel({required this.id, required this.name,required this.status});

    factory GenderModel.fromDoc(DocumentSnapshot doc) {
      return GenderModel(
        id: doc.id,
        name: doc['name'],
        status: doc['isActive'] ?? true,
      );
    }
  }

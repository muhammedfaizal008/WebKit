import 'package:cloud_firestore/cloud_firestore.dart';

class ReligionModel {
  final String id;
  final String name;

  ReligionModel({required this.id, required this.name});

  factory ReligionModel.fromDoc(DocumentSnapshot doc) {
    return ReligionModel(
      id: doc.id,
      name: doc['name'],
    );
  }
}

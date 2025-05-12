import 'package:cloud_firestore/cloud_firestore.dart';

class AnnualIncomeModel {
  final String id;
  final int sort_by;
  final String range;
  final bool isActive;

  AnnualIncomeModel({required this.id, required this.range,required this.isActive,required this.sort_by});

  factory AnnualIncomeModel.fromDoc(DocumentSnapshot doc) {
    return AnnualIncomeModel(
      id: doc.id,
      sort_by:doc["sort_by"],
      range: doc['range'],
      isActive: doc['isActive'] ?? true,
    );
  }
}

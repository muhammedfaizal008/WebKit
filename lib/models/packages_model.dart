import 'package:cloud_firestore/cloud_firestore.dart';

class PackagesModel {
  final String id;
  final String name;
  final double price;
  final String validity; // e.g., "1 month"

  final bool isActive;

  PackagesModel({
    required this.id,
    required this.name,
    required this.price,
    required this.validity,

    required this.isActive,
  });

  factory PackagesModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PackagesModel(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      validity: data['validity'] ?? '',
      isActive: data['isActive'] ?? true,
    );
  }
}

class LanguageModel {
  final String id;
  final String name;
  final int sortBy;
  final String status;

  LanguageModel({
    required this.id,
    required this.name,
    required this.sortBy,
    required this.status,
  });

  factory LanguageModel.fromDoc(Map<String, dynamic> doc, String docId) {
    return LanguageModel(
      id: docId,
      name: doc['name'] ?? '',
      sortBy: doc['sort_by'] ?? 0,
      status: doc['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sort_by': sortBy,
      'status': status,
    };
  }
}
  
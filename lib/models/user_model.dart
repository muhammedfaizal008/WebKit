import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String? gender;
  final int? age;
  final int? height;
  final String? profession;
  final String? education;
  final String? caste;
  final String? religion;
  final String? location;
  final String? maritalStatus;
  final String? language;
  final String? aboutMe;
  final String? forWhom;
  final String? motherTongue;

  // Partner Preferences
  final int? partnerAge;
  final String? partnerEducation;
  final String? partnerProfession;
  final String? partnerLocation;

  // Timestamps
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    this.gender,
    this.age,
    this.height,
    this.profession,
    this.education,
    this.caste,
    this.religion,
    this.location,
    this.maritalStatus,
    this.language,
    this.aboutMe,
    this.forWhom,
    this.motherTongue,
    this.partnerAge,
    this.partnerEducation,
    this.partnerProfession,
    this.partnerLocation,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'],
      age: map['age'] is int ? map['age'] : int.tryParse(map['age'].toString()),
      height: map['height'] is int ? map['height'] : int.tryParse(map['height'].toString()),
      profession: map['profession'],
      education: map['education'],
      caste: map['caste'],
      religion: map['religion'],
      location: map['location'],
      maritalStatus: map['maritalStatus'],
      language: map['language'],
      aboutMe: map['aboutMe'],
      forWhom: map['forWhom'],
      motherTongue: map['motherTongue'],
      partnerAge: map['partnerAge'] is int ? map['partnerAge'] : int.tryParse(map['partnerAge'].toString()),
      partnerEducation: map['partnerEducation'],
      partnerProfession: map['partnerProfession'],
      partnerLocation: map['partnerLocation'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap()        {
    return {
      'id': id,
      'uid': uid,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      'age': age,
      'height': height,
      'profession': profession,
      'education': education,
      'caste': caste,
      'religion': religion,
      'location': location,
      'maritalStatus': maritalStatus,
      'language': language,
      'aboutMe': aboutMe,
      'forWhom': forWhom,
      'motherTongue': motherTongue,
      'partnerAge': partnerAge,
      'partnerEducation': partnerEducation,
      'partnerProfession': partnerProfession,
      'partnerLocation': partnerLocation,
      'createdAt': Timestamp.fromDate(createdAt),    // ✅ Convert to Timestamp
    'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null, // ✅
    };
  }
}

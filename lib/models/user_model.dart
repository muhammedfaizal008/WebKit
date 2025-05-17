import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? gender;
  final int? age;
  final int? height;
  final String? weight;
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
  final String? subscription;
  final String? imageUrl;

  // Religious info
  final String? zodiacSign;
  final String? star;
  final String? chovvaDosham;
  final String? horoscope;

  // Profile categorization
  final String? physicalStatus;
  final String? educationCategory;
  final String? professionCategory;

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
    required this.email,
    required this.phoneNumber,
    this.gender,
    this.age,
    this.height,
    this.weight,
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
    this.subscription,
    this.imageUrl,
    this.zodiacSign,
    this.star,
    this.chovvaDosham,
    this.horoscope,
    this.physicalStatus,
    this.educationCategory,
    this.professionCategory,
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
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'],
      gender: map['gender'],
      age: map['age'] is int ? map['age'] : int.tryParse(map['age'].toString()),
      height: map['height'] is int ? map['height'] : int.tryParse(map['height'].toString()),
      weight: map['weight']?.toString(),
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
      subscription: map['subscription'],
      imageUrl: map['profileImage'],
      zodiacSign: map['zodiacSign'],  
      star: map['star'],
      chovvaDosham: map['chovvaDosham'],
      horoscope: map['horoscope'],
      physicalStatus: map['physicalStatus'],
      educationCategory: map['educationCategory'],
      professionCategory: map['professionCategory'],
      partnerAge: map['partnerAge'] is int
          ? map['partnerAge']
          : int.tryParse(map['partnerAge'].toString()),
      partnerEducation: map['partnerEducation'],
      partnerProfession: map['partnerProfession'],
      partnerLocation: map['partnerLocation'],        
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
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
      'subscription': subscription,
      'imageUrl':imageUrl,
      'zodiacSign': zodiacSign,
      'star': star,
      'chovvaDosham': chovvaDosham,
      'horoscope': horoscope,
      'physicalStatus': physicalStatus,
      'educationCategory': educationCategory,
      'professionCategory': professionCategory,
      'partnerAge': partnerAge,
      'partnerEducation': partnerEducation,
      'partnerProfession': partnerProfession,
      'partnerLocation': partnerLocation,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

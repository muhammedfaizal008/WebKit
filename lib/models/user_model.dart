import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String uid;
  final String status;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final int age;
  final String? dob;
  final int height;
  final String weight;
  final String? professionInDetail;
  final String? educationInDetail;
  final String caste;
  final String religion;
  final String country;
  final String state;
  final String? citizenship;
  final String maritalStatus;
  final String language;
  final String aboutMe;
  final String forWhom;
  final String? motherTongue;
  final String subscription;
  final String? imageUrl;
  final String? annualIncome;

  // Family details
  final String familyStatus;
  final String familyType;
  final String familyValues;
  final String fathersOccupation;
  final String mothersOccupation;
  final String brothers;
  final String sisters;

  // Lifestyle
  final String drinkingHabits;
  final String eatingHabits;
  final String smokingHabits;

  // Religious info
  final String zodiacSign;
  final String star;
  final String chovvaDosham;
  final String horoscope;

  // Profile categorization
  final String physicalStatus;
  final String educationCategory;
  final String professionCategory;

  // Partner Preferences
  final String partnerAge;
  final String partnersHeight;
  final List<String> partnerEducationList;
  final List<String> partnerProfessions;
  final String partnerCountry;
  final List<String> partnerStates;
  final String partnerReligion;
  final List<String> partnerCastes;
  final String partnerChovvaDosham;
  final List<String> partnerMotherTongue;
  final List<String> partnerMaritalStatus;
  final List<String> partnerDrinkingHabits;
  final List<String> partnerEatingHabits;
  final List<String> partnerSmokingHabits;
  final List<String> partnerStars;
  final String partnerAnnualIncome;
  final List<String> partnerCitizenship;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.uid,
    required this.status,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.age,
    this.dob,
    required this.height,
    required this.weight,
    this.professionInDetail,
    this.educationInDetail,
    required this.caste,
    required this.religion,
    required this.country,
    required this.state,
    this.citizenship,
    required this.maritalStatus,
    required this.language,
    required this.aboutMe,
    required this.forWhom,
    this.motherTongue,
    required this.subscription,
    this.imageUrl,
    this.annualIncome,
    required this.familyStatus,
    required this.familyType,
    required this.familyValues,
    required this.fathersOccupation,
    required this.mothersOccupation,
    required this.brothers,
    required this.sisters,
    required this.drinkingHabits,
    required this.eatingHabits,
    required this.smokingHabits,
    required this.zodiacSign,
    required this.star,
    required this.chovvaDosham,
    required this.horoscope,
    required this.physicalStatus,
    required this.educationCategory,
    required this.professionCategory,
    required this.partnerAge,
    required this.partnersHeight,
    required this.partnerEducationList,
    required this.partnerProfessions,
    required this.partnerCountry,
    required this.partnerStates,
    required this.partnerReligion,
    required this.partnerCastes,
    required this.partnerChovvaDosham,
    required this.partnerMotherTongue,
    required this.partnerMaritalStatus,
    required this.partnerDrinkingHabits,
    required this.partnerEatingHabits,
    required this.partnerSmokingHabits,
    required this.partnerStars,
    required this.partnerAnnualIncome,
    required this.partnerCitizenship,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      status: map["status"]??"",
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] is int ? map['age'] : int.tryParse(map['age']?.toString() ?? '0') ?? 0,
      dob: map['dob']??"",
      height: map['height'] is int ? map['height'] : int.tryParse(map['height']?.toString() ?? '0') ?? 0,
      weight: map['weight']?.toString() ?? '',
      professionInDetail: map['professionInDetail'],
      educationInDetail: map['educationInDetail'],
      caste: map['caste'] ?? '',
      religion: map['religion'] ?? '',
      country: map['Country'] ?? '',
      state: map['State'] ?? '',
      citizenship: map['citizenship']??"",
      maritalStatus: map['maritalStatus'] ?? '',
      language: map['language'] ?? '',
      aboutMe: map['aboutMe'] ?? '',
      forWhom: map['forWhom'] ?? '',
      motherTongue: map['motherTongue'],
      subscription: map['subscription'] ?? 'Free',
      annualIncome: map["annualIncome"],
      imageUrl: map['imageUrl'],
      familyStatus: map['familyStatus'] ?? '',
      familyType: map['familyType'] ?? '',
      familyValues: map['familyValues'] ?? '',
      fathersOccupation: map['fathersOccupation'] ?? '',
      mothersOccupation: map['mothersOccupation'] ?? '',
      brothers: map['brothers']?.toString() ?? '0',
      sisters: map['sisters']?.toString() ?? '0',
      drinkingHabits: map['drinkingHabits'] ?? '',
      eatingHabits: map['eatingHabits'] ?? '',
      smokingHabits: map['smokingHabits'] ?? '',
      zodiacSign: map['zodiacSign'] ?? '',
      star: map['star'] ?? '',
      chovvaDosham: map['chovvaDosham'] ?? '',
      horoscope: map['horoscope'] ?? '',
      physicalStatus: map['physicalStatus'] ?? '',
      educationCategory: map['educationCategory'] ?? '',
      professionCategory: map['professionCategory'] ?? '',
      partnerAge: map['partnerAge']?.toString() ?? '',
      partnersHeight: map['partnersHeight']?.toString() ?? '',
      partnerEducationList: (map['partnerEducationList'] is List)
        ? List<String>.from(map['partnerEducationList'])
        : [],
      partnerProfessions: (map['partnerProfessions'] is List)
        ? List<String>.from(map['partnerProfessions'])
        : [],
      partnerCountry: map['partnerCountry'] ?? '',
      partnerStates: (map['partnerStates'] is List)
        ? List<String>.from(map['partnerStates'])
        : [],
      partnerReligion: map['partnerReligion'] ?? '',
      partnerCastes: (map['partnerCastes'] is List)
        ? List<String>.from(map['partnerCastes'])
        : [],
      partnerChovvaDosham: map['partnerChovvaDosham'] ?? '',
      partnerMotherTongue: (map['partnerMotherTongue'] is List)
        ? List<String>.from(map['partnerMotherTongue'])
        : [],
      partnerMaritalStatus: (map['partnerMaritalStatus'] is List)
        ? List<String>.from(map['partnerMaritalStatus'])
        : [],
      partnerDrinkingHabits: (map['partnerDrinkingHabits'] is List)
        ? List<String>.from(map['partnerDrinkingHabits'])
        : [],
      partnerEatingHabits: (map['partnerEatingHabits'] is List)
          ? List<String>.from(map['partnerEatingHabits'])
          : [],
      partnerSmokingHabits: (map['partnerSmokingHabits'] is List)
          ? List<String>.from(map['partnerSmokingHabits'])
          : [],
      partnerStars: (map['partnerStars'] is List)
        ? List<String>.from(map['partnerStars'])
        : [],
      partnerAnnualIncome: map['partnerAnnualIncome'] ?? '',
      partnerCitizenship: (map['partnerCitizenship'] is List)
        ? List<String>.from(map['partnerCitizenship'])
        : [],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      "status":status,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'age': age,
      'dob':dob,
      'height': height,
      'weight': weight,
      'professionInDetail': professionInDetail,
      'educationInDetail': educationInDetail,
      'caste': caste,
      'religion': religion,
      'Country': country,
      'State': state,
      "citizenship":citizenship,
      'maritalStatus': maritalStatus,
      'language': language,
      'aboutMe': aboutMe,
      'forWhom': forWhom,
      'motherTongue': motherTongue,
      'subscription': subscription,
      'imageUrl': imageUrl,
      'annualIncome':annualIncome,
      'familyStatus': familyStatus,
      'familyType': familyType,
      'familyValues': familyValues,
      'fathersOccupation': fathersOccupation,
      'mothersOccupation': mothersOccupation,
      'brothers': brothers,
      'sisters': sisters,
      'drinkingHabits': drinkingHabits,
      'eatingHabits': eatingHabits,
      'smokingHabits': smokingHabits,
      'zodiacSign': zodiacSign,
      'star': star,
      'chovvaDosham': chovvaDosham,
      'horoscope': horoscope,
      'physicalStatus': physicalStatus,
      'educationCategory': educationCategory,
      'professionCategory': professionCategory,
      'partnerAge': partnerAge,
      'partnersHeight': partnersHeight,
      'partnerEducationList': partnerEducationList,
      'partnerProfessions': partnerProfessions,
      'partnerCountry': partnerCountry,
      'partnerStates': partnerStates,
      'partnerReligion': partnerReligion,
      'partnerCastes': partnerCastes,
      'partnerChovvaDosham': partnerChovvaDosham,
      'partnerMotherTongue': partnerMotherTongue,
      'partnerMaritalStatus': partnerMaritalStatus,
      'partnerDrinkingHabits': partnerDrinkingHabits,
      'partnerEatingHabits': partnerEatingHabits,
      'partnerSmokingHabits': partnerSmokingHabits,
      'partnerStars': partnerStars,
      'partnerAnnualIncome': partnerAnnualIncome,
      'partnerCitizenship': partnerCitizenship,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
// factory UserModel.fromMap(Map<String, dynamic> map) {
//   String safeString(dynamic val) => val is String ? val : (val?.toString() ?? '');
//   int safeInt(dynamic val) =>
//       val is int ? val : int.tryParse(val?.toString() ?? '0') ?? 0;
//   List<String> safeList(dynamic val) =>
//       val is List ? List<String>.from(val) : [];

//   return UserModel(
//     id: safeString(map['id']),
//     uid: safeString(map['uid']),
//     status: safeString(map['status']),
//     fullName: safeString(map['fullName']),
//     email: safeString(map['email']),
//     phoneNumber: safeString(map['phoneNumber']),
//     gender: safeString(map['gender']),
//     age: safeInt(map['age']),
//     dob: safeString(map['dob']),
//     height: safeInt(map['height']),
//     weight: safeString(map['weight']),
//     professionInDetail: safeString(map['professionInDetail']),
//     educationInDetail: safeString(map['educationInDetail']),
//     caste: safeString(map['caste']),
//     religion: safeString(map['religion']),
//     country: safeString(map['Country']),
//     state: safeString(map['State']),
//     citizenship: safeString(map['citizenship']),
//     maritalStatus: safeString(map['maritalStatus']),
//     language: safeString(map['language']),
//     aboutMe: safeString(map['aboutMe']),
//     forWhom: safeString(map['forWhom']),
//     motherTongue: safeString(map['motherTongue']),
//     subscription: safeString(map['subscription']),
//     annualIncome: safeString(map['annualIncome']),
//     imageUrl: safeString(map['imageUrl']),
//     familyStatus: safeString(map['familyStatus']),
//     familyType: safeString(map['familyType']),
//     familyValues: safeString(map['familyValues']),
//     fathersOccupation: safeString(map['fathersOccupation']),
//     mothersOccupation: safeString(map['mothersOccupation']),
//     brothers: safeString(map['brothers']),
//     sisters: safeString(map['sisters']),
//     drinkingHabits: safeString(map['drinkingHabits']),
//     eatingHabits: safeString(map['eatingHabits']),
//     smokingHabits: safeString(map['smokingHabits']),
//     zodiacSign: safeString(map['zodiacSign']),
//     star: safeString(map['star']),
//     chovvaDosham: safeString(map['chovvaDosham']),
//     horoscope: safeString(map['horoscope']),
//     physicalStatus: safeString(map['physicalStatus']),
//     educationCategory: safeString(map['educationCategory']),
//     professionCategory: safeString(map['professionCategory']),
//     partnerAge: safeString(map['partnerAge']),
//     partnersHeight: safeString(map['partnersHeight']),
//     partnerEducationList: safeList(map['partnerEducationList']),
//     partnerProfessions: safeList(map['partnerProfessions']),
//     partnerCountry: safeString(map['partnerCountry']),
//     partnerStates: safeList(map['partnerStates']),
//     partnerReligion: safeString(map['partnerReligion']),
//     partnerCastes: safeList(map['partnerCastes']),
//     partnerChovvaDosham: safeString(map['partnerChovvaDosham']),
//     partnerMotherTongue: safeList(map['partnerMotherTongue']),
//     partnerMaritalStatus: safeString(map['partnerMaritalStatus']),
//     partnerDrinkingHabits: safeList(map['partnerDrinkingHabits']),
//     partnerEatingHabits: safeList(map['partnerEatingHabits']),
//     partnerSmokingHabits: safeList(map['partnerSmokingHabits']),
//     partnerStars: safeList(map['partnerStars']),
//     partnerAnnualIncome: safeString(map['partnerAnnualIncome']),
//     partnerCitizenship: safeList(map['partnerCitizenship']),
//     createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//     updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//   );
// }

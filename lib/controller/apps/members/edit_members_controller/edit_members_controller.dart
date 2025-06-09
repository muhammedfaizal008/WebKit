import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';

class EditMembersController extends MyController {
  // Make Firestore instance final
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Convert to observable lists and add proper typing
  final users = <Map<String, dynamic>>[].obs;
  final languages = <String>[].obs;
  final countries = <String>[].obs;
  final states=<String>[].obs;
  final forwhom =<String>[].obs;
  final maritalStatus= <String>[].obs;
  final subscriptions= <String>[].obs;
  final annualIncomes=<String>[].obs;
  final citizenship =<String>[].obs;
  final professions=<String>[].obs;
  final educations=<String>[].obs;
  final maritalStatuses=<String>[].obs;
  final physicalStatuses=<String>[].obs;
  final religions=<String>[].obs;
  final castes=<String>[].obs;
  final zodiacSigns=<String>[].obs;
  final stars=<String>[].obs;
  final doshams=<String>[].obs;
  final horoscopeMatch=<String>[].obs;
  final familyValues = <String>[].obs;
  final familyTypes = <String>[].obs;
  final familyStatuses = <String>[].obs;
  final eatingHabits = <String>[].obs;
  final drinkingHabits = <String>[].obs;
  final smokingHabits = <String>[].obs;
  final status = <String>[].obs;
  final genders=<String>[].obs;


  
  // Convert to Rx variables for reactivity
  final selectedCountry = ''.obs;
  final selectedState="".obs;
  final selectmaritalStatus = ''.obs;
  final selectedlanguage = ''.obs;
  final selectedforwhom ="".obs;
  final selectedSubscription="".obs;
  final selectedIncome="".obs;
  final selectedCitizenship="".obs;
  final selectedProfessionCategory="".obs;
  final selectededucationCategory="".obs;
  final selectedmaritalStatus="".obs;
  final selectedphysicalStatus="".obs;
  final selectedreligion="".obs;
  final selectedcaste="".obs;
  final selectedzodiacsign="".obs;
  final selectedstar="".obs;
  final selectedhoroscopeMatch="".obs;
  final selecteddosham="".obs;
  final selectedFamilyValue = ''.obs;
  final selectedFamilyType = ''.obs;
  final selectedFamilyStatus = ''.obs;
  final selectedEatingHabit = ''.obs;
  final selectedDrinkingHabit = ''.obs;
  final selectedSmokingHabit = ''.obs;
  final selectedPartnerReligion ="".obs;
  final selectedPartnerMaritalStatus ="".obs;
  final selectedPartnerIncome ="".obs;
  final selectedPartnerdosham ="".obs;
  final selectedPartnerCountry="".obs;
  final isLoading = false.obs;

  List<String> selectedEducation = [];
  List<String> tempSelectedEducation = [];
  List<String> selectedProfessions = [];
  List<String> tempSelectedProfessions = [];
  List<String> selectedMotherTongues = [];
  List<String> tempSelectedMotherTongues = [];
  List<String> selectedStar = [];
  List<String> tempSelectedStar = [];
  List<String> selectedeatingHabits = [];
  List<String> tempSelectedEatingHabits = [];
  List<String> selectedSmokingHabits = [];
  List<String> tempSelectedSmokingHabits = [];
  List<String> selectedDrinkingHabits=[];
  List<String> tempSelectedDrinkingHabits=[];
  List<String> selectedPartnerCitizenShip=[];
  List<String> tempSelectedPartnerCitizenShip=[];
  List<String> selectedPartnerStates=[];
  List<String> tempSelectedPartnerStates=[];
  List<String> selectedPartnerCastes=[];
  List<String> tempSelectedPartnerCastes=[];



  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
    fetchCountries();
    fetchLanguages();
    fetchforWhom();
    fetchSubscription();
    fetchAnnualIncome();
    fetchCitizen();fetchProfessionCategory();
    fetchEducationCategory();
    fetchMaritalStatus();
    fetchPhysicalStatus();
    // fetchDoshams();
    fetchReligion();
    fetchStars();
    fetchZodiacSigns();
    fetchHoroscopeMatch();
    fetchFamilyValues();
    fetchFamilyTypes();
    fetchFamilyStatuses();
    fetchEatingHabits();
    fetchDrinkingHabits();
    fetchSmokingHabits();
    fetchStatus();
      
  }

  Future<void> fetchAllUsers() async {
    try {
      isLoading(true);
      final snapshot = await _firestore.collection('users').get();
      
      users.assignAll(snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {...data, 'uid': doc.id};
      }));
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to load users',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Map<String, dynamic>? getUserById(String uid) {
    try {
      return users.firstWhere(
        (user) => user['uid'] == uid, 
        orElse: () => {},
      );
    } catch (e) {
      Get.snackbar('Error', 'User not found');
      return null;
    }
  }

  Future<void> updateBasicData({
    required String uid,
    String? fullName,
    String? age,
    String? height,
    String? weight,
    String? country,
    String? state,
    String? motherTongue,
    String? forWhom,
    String? subscription,
    String? annualIncome
  }) async {
    try {
      isLoading(true);
      String? firstName;
      String? middleName;
      String? lastName;
      if (fullName != null) { 
      final parts = fullName.trim().split(RegExp(r'\s+'));
      firstName = parts.isNotEmpty ? parts.first : '';
      middleName = parts.length > 2 ? parts.sublist(1, parts.length - 1).join(' ') : '';
      lastName = parts.length > 1 ? parts.last : '';
      }
      await _firestore.collection('users').doc(uid).update({
      if (fullName != null) 'fullName': fullName,
      if (firstName != null) 'firstName': firstName,
      if (middleName != null && middleName.isNotEmpty) 'middleName': middleName,
      if (lastName != null && lastName.isNotEmpty) 'lastName': lastName,
      if (age != null) 'age': age,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (country != null) 'Country': country,
      if (state != null) 'State': state,
      if (motherTongue != null) 'language': motherTongue,
      if (forWhom != null) 'forWhom': forWhom,
      if (subscription != null) 'subscription': subscription,
      if (annualIncome != null) 'annualIncome': annualIncome,
      'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar(
      'Basic Details updated',
      '',
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.only(top: 20, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      backgroundColor: Colors.green[700],
      borderRadius: 8,
      maxWidth: 300,
      messageText: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        Icon(Icons.check_circle, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Flexible(
          child: Text(
          'Basic data updated',
          style: TextStyle(color: Colors.white),
          ),
        ),
        ],
      ),
      titleText: SizedBox(),
      duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update data: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> savePersonalData({
    required String uid,
    String? dob,
    String? citizenship,
    String? professionCategory,
    String? professionInDetail,
    String? educationCategory,
    String? educationInDetail, 
    String? maritalStatus,
    String? physicalStatus,
    String? aboutMe
  }) async {
    try {
      isLoading(true);
      await _firestore.collection('users').doc(uid).update({
        if (dob != null) 'dob': dob,
        if (citizenship != null) 'citizenship': citizenship,
        if (professionCategory != null) 'professionCategory': professionCategory,
        if (professionInDetail != null) 'professionInDetail': professionInDetail,
        if (educationCategory != null) 'educationCategory': educationCategory,
        if (educationInDetail != null) 'educationInDetail': educationInDetail,
        if (maritalStatus != null) 'maritalStatus': maritalStatus,
        if (physicalStatus != null) 'physicalStatus': physicalStatus,
        if (aboutMe != null) 'aboutMe': aboutMe,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar(
          '', '',
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.only(top: 20, right: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              backgroundColor: Colors.green[700],
          borderRadius: 8,
          maxWidth: 300, // Limits width
          messageText: Row(
            mainAxisSize: MainAxisSize.min, // Prevents stretching
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Flexible( // Ensures text wraps if too long
                child: Text(
                  'Personal Details updated',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          titleText: SizedBox(), // Hides title space
          duration: Duration(seconds: 2),
        );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update personal data');
    } finally {
      isLoading(false);
    }
  }
  Future<void> saveReligiousInfo({
    required uid,
    String? religion,
    String? caste,
    String? zodiacSign,
    String? star,
    String? chovvadosham,
    String? horoscopeMatch
  }) async {
    try {
      isLoading(true);
      await _firestore.collection('users').doc(uid).update({
        if (religion != null) 'religion': religion,
        if (caste != null) 'caste': caste,
        if (zodiacSign != null) 'zodiacSign': zodiacSign,
        if (star != null) 'star': star,
        if (chovvadosham != null) 'chovvaDosham': chovvadosham,
        if (horoscopeMatch != null) 'horoscope': horoscopeMatch,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar(
          '', '',
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.only(top: 20, right: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              backgroundColor: Colors.green[700],
          borderRadius: 8,
          maxWidth: 300, // Limits width
          messageText: Row(
            mainAxisSize: MainAxisSize.min, // Prevents stretching
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Flexible( // Ensures text wraps if too long
                child: Text(
                  'Religious details updated',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          titleText: SizedBox(), // Hides title space
          duration: Duration(seconds: 2),
        );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update religious details');
    } finally {
      isLoading(false);
    }
  }
Future<void> saveFamilyLifestyleInfo({
    required uid,
    String? familyValues,
    String? familyStatus,
    String? familyType,
    String? eatingHabit,
    String? smokingHabit,
    String? drinkingHabit,
    String? brothers,
    String? sisters,
    String? fathersOccupation,
    String? mothersOcccupation,

  }) async {
    try {
      isLoading(true);
      await _firestore.collection('users').doc(uid).update({
        if (familyValues != null) 'familyValues': familyValues,
        if (familyStatus != null) 'familyStatus': familyStatus,
        if (familyType != null) 'familyType': familyType,
        if (eatingHabit != null) 'eatingHabits': eatingHabit,
        if (smokingHabit != null) 'smokingHabits': smokingHabit,
        if (drinkingHabit != null) 'drinkingHabits': drinkingHabit,
        if (brothers != null) 'brothers': brothers,
        if (sisters != null) 'sisters': sisters,
        if (fathersOccupation != null) 'fathersOccupation': fathersOccupation,
        if (mothersOcccupation != null) 'mothersOcccupation': mothersOcccupation,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar(
          'Family & Lifestyle details updated', 
          '',
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.only(top: 20, right: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              backgroundColor: Colors.green[700],
          borderRadius: 8,
          maxWidth: 300, // Limits width
          messageText: Row(
            mainAxisSize: MainAxisSize.min, // Prevents stretching
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Flexible( // Ensures text wraps if too long
                child: Text(
                  'Basic data updated',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          titleText: SizedBox(), // Hides title space
          duration: Duration(seconds: 2),
        );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update religious details');
    } finally {
      isLoading(false);
    }
  }
  Future<void> savePartnerPreferences({
    required String uid,
    String? partnersage,
    String? partnerHeight,
    String? partnersCountry,
    List<String>? citizenShips,
    List<String>? states,
    List<String>? partnerEducation,
    List<String>? partnerProfession,
    List<String>? partnerMotherTongue,
    String? partnersmaritalStatus,
    String? annualIncome,
    String? partnerReligion,
    List<String>? partnersCastes,
    List<String>? partnerStars,
    String? partnerDosham,
    List<String>? partnerEatingHabits,
    List<String>? partnerSmokingHabits,
    List<String>? partnerDrinkingHabits,
  }) async {
    try {
      isLoading(true);
      await _firestore.collection('users').doc(uid).update({
        if (partnersage != null) 'partnerAge': partnersage, 
        if (partnerHeight != null) 'partnersHeight': partnerHeight,
        if (partnersCountry != null) 'partnerCountry': partnersCountry,
        if (citizenShips != null) 'partnerCitizenship': citizenShips,
        if (states != null) 'partnerStates': states,
        if (partnerEducation != null) 'partnerEducationList': partnerEducation,
        if (partnerProfession != null) 'partnerProfessions': partnerProfession,
        if (partnerMotherTongue != null) 'partnerMotherTongue': partnerMotherTongue,
        if (partnersmaritalStatus != null) 'partnerMaritalStatus': partnersmaritalStatus,
        if (annualIncome != null) 'partnerAnnualIncome': annualIncome,
        if (partnerReligion != null) 'partnerReligion': partnerReligion,
        if (partnersCastes != null) 'partnerCastes': partnersCastes,
        if (partnerStars != null) 'partnerStars': partnerStars,
        if (partnerDosham != null) 'partnerChovvaDosham': partnerDosham,
        if (partnerEatingHabits != null) 'partnerEatingHabits': partnerEatingHabits,
        if (partnerSmokingHabits != null) 'partnerSmokingHabits': partnerSmokingHabits,
        if (partnerDrinkingHabits != null) 'partnerDrinkingHabits': partnerDrinkingHabits,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar(
          '', '',
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.only(top: 20, right: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              backgroundColor: Colors.green[700],
          borderRadius: 8,
          maxWidth: 300, // Limits width
          messageText: Row(
            mainAxisSize: MainAxisSize.min, // Prevents stretching
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Flexible( // Ensures text wraps if too long
                child: Text(
                  'Partner preference updated',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          titleText: SizedBox(), // Hides title space
          duration: Duration(seconds: 2),
        );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update partner preferences');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchGender() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore
          .collection('Gender')
          .get();

      genders.assignAll(
        querySnapshot.docs
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load status');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchStatus() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore
          .collection('status')
          .get();

      status.assignAll(
        querySnapshot.docs
        .map((doc) => doc['status'] as String)
        .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load status');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCountries() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore
          .collection('Country')
          .orderBy('sortOrder')
          .get();

      countries.assignAll(
        querySnapshot.docs
            .map((doc) => doc['name'] as String)
            .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load countries');
    } finally {
      isLoading(false);
    }
  }
    Future<void> fetchStatesForCountry(String countryName) async {
      try {
        isLoading(true);
        final countryDoc = await _firestore
            .collection('Country')
            .where('name', isEqualTo: countryName)
            .limit(1)
            .get();

        if (countryDoc.docs.isNotEmpty) {
          final countryId = countryDoc.docs.first.id;
          final stateSnapshot = await _firestore
              .collection('Country')
              .doc(countryId)
              .collection('States')
              .where('isActive', isEqualTo: true)
              .get();

          states.assignAll(stateSnapshot.docs
              .map((doc) => doc['name'] as String)
              .where((name) => name.isNotEmpty));
        } else {
          states.clear();
          Get.snackbar('Info', 'No states found for this country');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to load states: ${e.toString()}');
        states.clear();
      } finally {
        isLoading(false);
        update();
      }
    }


  Future<void> fetchLanguages() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore
          .collection('languages')
          .orderBy('sort_by')
          .get();

      languages.assignAll(
        querySnapshot.docs
            .map((doc) => doc['name'] as String)
            .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load languages');
    } finally {
      isLoading(false);
    }
  }
    Future<void> fetchforWhom() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore
          .collection('ProfileNames')
          .get();

      forwhom.assignAll(
        querySnapshot.docs
            .map((doc) => doc['name'] as String)
            .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load subscription');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchSubscription() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore
          .collection('subscription')
          .get();

      subscriptions.assignAll(
        querySnapshot.docs
            .map((doc) => doc['name'] as String)
            .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load subscription');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchAnnualIncome() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore
          .collection('AnnualIncome')
          .get();

      annualIncomes.assignAll(
        querySnapshot.docs
            .map((doc) => doc['range'] as String)
            .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load subscription');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchCitizen() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore
          .collection('Citizenship')
          .orderBy('sortOrder')
          .get();

      citizenship.assignAll(
        querySnapshot.docs
            .map((doc) => doc['name'] as String)
            .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load Citizenship');
    } finally {
      isLoading(false);
    }
  }
Future<void> fetchProfessionCategory() async {
  try {
    isLoading(true);
    final querySnapshot = await _firestore.collection('Occupation').get();
    professions.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load professions data');
  } finally {
    isLoading(false);
  }
}

Future<void> fetchEducationCategory() async {
  try {
    isLoading(true);
    final querySnapshot = await _firestore.collection('Education').get();
    educations.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load education data');
  } finally {
    isLoading(false);
  }
}
Future<void> fetchMaritalStatus() async {
  try {
    isLoading(true);
    final querySnapshot = await _firestore.collection('MaritalStatus').get();
    maritalStatuses.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['status'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load marital status data');
  } finally {
    isLoading(false);
  }
}

Future<void> fetchPhysicalStatus() async {
  try {
    isLoading(true);
    final querySnapshot = await _firestore.collection('PhysicalStatus').get();
    physicalStatuses.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['status'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load physical status data');
  } finally {
    isLoading(false);
  }
}
Future<void> fetchReligion() async {
  try {
    isLoading(true);
    final querySnapshot = await _firestore.collection('Religion').get();
    religions.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load Religion data');
  } finally {
    isLoading(false);
  }
}
  Future<void> fetchCastesForReligion(String religionName) async {
    try {
      isLoading(true);
      final religionDoc = await _firestore
          .collection('Religion')
          .where('name', isEqualTo: religionName)
          .limit(1)
          .get();

      if (religionDoc.docs.isNotEmpty) {
        final religionId = religionDoc.docs.first.id;
        final casteSnapshot = await _firestore
            .collection('Religion')
            .doc(religionId)
            .collection('castes')
            .where('isActive', isEqualTo: true)
            .get();

        castes.assignAll(casteSnapshot.docs
            .map((doc) => doc['name'] as String)
            .where((name) => name.isNotEmpty));
      } else {
        castes.clear();
        Get.snackbar('Info', 'No castes found for this religion');
      }
    } catch (e) {
      print('Error'+ 'Failed to load castes: ${e.toString()}');
      castes.clear();
      Get.snackbar('Error', 'Failed to load castes');
    } finally {
      isLoading(false);
      update();
    }
  }

Future<void> fetchZodiacSigns() async {
  try {
    isLoading(true);
    final querySnapshot = await _firestore.collection('ZodiacSign').get();
    zodiacSigns.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load zodiac signs');
  } finally {
    isLoading(false);
  }
}

Future<void> fetchStars() async {
  try {
    isLoading(true);
    final querySnapshot = await _firestore.collection('Stars').orderBy('sortOrder').get();
    stars.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load stars');
  } finally {
    isLoading(false);
  }
}


Future<void> fetchHoroscopeMatch() async {
  try {
    isLoading(true);
    final querySnapshot = await _firestore.collection('HoroscopeMatch').orderBy('sortOrder').get();
    horoscopeMatch.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load horoscope match');
  } finally {
    isLoading(false);
  }
}
  Future<void> fetchFamilyValues() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore.collection('FamilyValues').orderBy("sortOrder").get();
      familyValues.assignAll(
        querySnapshot.docs
          .where((doc) => doc['isActive'] == true)
          .map((doc) => doc['name'] as String)
          .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load family values');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFamilyTypes() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore.collection('FamilyType').orderBy("sortOrder").get();
      familyTypes.assignAll(
        querySnapshot.docs
          .where((doc) => doc['isActive'] == true)
          .map((doc) => doc['name'] as String)
          .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load family types');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFamilyStatuses() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore.collection('FamilyStatus').orderBy("sortOrder").get();
      familyStatuses.assignAll(
        querySnapshot.docs
          .where((doc) => doc['isActive'] == true)
          .map((doc) => doc['name'] as String)
          .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load family statuses');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchEatingHabits() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore.collection('EatingHabits').orderBy("sortOrder").get();
      eatingHabits.assignAll(
        querySnapshot.docs
          .where((doc) => doc['isActive'] == true)
          .map((doc) => doc['name'] as String)
          .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load eating habits');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchDrinkingHabits() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore.collection('DrinkingHabits').orderBy("sortOrder").get();
      drinkingHabits.assignAll(
        querySnapshot.docs
          .where((doc) => doc['isActive'] == true)
          .map((doc) => doc['name'] as String)
          .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load drinking habits');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSmokingHabits() async {
    try {
      isLoading(true);
      final querySnapshot = await _firestore.collection('SmokingHabits').orderBy("sortOrder").get();
      smokingHabits.assignAll(
        querySnapshot.docs
          .where((doc) => doc['isActive'] == true)
          .map((doc) => doc['name'] as String)
          .where((name) => name.isNotEmpty),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load smoking habits');
    } finally {
      isLoading(false);
    }
  }

  void setSelectedPartnerdosham(String dosham) {
    selectedPartnerdosham.value = dosham;
  }
  void setSelectedPartnerReligion(String religion) {
    selectedPartnerReligion.value = religion;
    fetchCastesForReligion(religion); 
  }
  void setSelectedCaste(String caste) {
    selectedcaste.value = caste;
  }
  
  void setSelectedPartnerMaritalStatus(String maritalStatus) {
    selectedPartnerMaritalStatus.value = maritalStatus;
  }
  void setSelectedPartnerIncome(String income) {
    selectedPartnerIncome.value = income;
  }

  void setSelectedFamilyValue(String value) {
    selectedFamilyValue.value = value;
  }

  void setSelectedFamilyType(String value) {
    selectedFamilyType.value = value;
  }

  void setSelectedFamilyStatus(String value) {
    selectedFamilyStatus.value = value;
  }

  void setSelectedEatingHabit(String value) {
    selectedEatingHabit.value = value;
  }

  void setSelectedDrinkingHabit(String value) {
    selectedDrinkingHabit.value = value;
  }

  void setSelectedSmokingHabit(String value) {
    selectedSmokingHabit.value = value;
  }
  void setselectzodiacSign(String zodiacSign) {
    selectedzodiacsign.value = zodiacSign;
  }
  void setselectstar(String star) {
    selectedstar.value = star;
  }
  void setselectdosham(String dosham) {
    selecteddosham.value = dosham;
  }
  void setselecthoroscopeMatch(String horoscopeMatch) {
    selectedhoroscopeMatch.value = horoscopeMatch;
  }
  void setselectReligion(String religion) {
    selectedreligion.value = religion;
    fetchCastesForReligion(religion); 
  }
  void setselectMaritalstatus(String maritalstatus) {
    selectedmaritalStatus.value = maritalstatus;
  }
  void setselectPhysicalStatus(String physicalstatus) {
    selectedphysicalStatus.value = physicalstatus;
  }
  void setselectEducation(String education) {
    selectededucationCategory.value = education;
  }

  void setselectprofession(String profession) {
    selectedProfessionCategory.value = profession;
  }
  void setselectcitizen (String citizenShip) {
    selectedCitizenship.value = citizenShip;
  }
  void setselectIncome (String Income) {
    selectedIncome.value = Income;
  }
  
  void setselectSubscription (String subscription) {
    selectedSubscription.value = subscription;
  }
  void setSelectforWhom(String forWhom) {
    selectedforwhom.value = forWhom;
  }

  void selectLanguage(String language) {
    selectedlanguage.value = language;
  }

  void setSelectedCountry(String country) {
    selectedCountry.value = country;
    fetchStatesForCountry(country); 
  }
  void setSelectedstate(String state) {
    selectedState.value = state;
  }
  void setSelectedPartnerCountry(String country) {
    selectedPartnerCountry.value = country;
    fetchStatesForCountry(country); 
  }
  // String? selectedCaste;
  // void onCasteChanged(String? value) {
  //   selectedCaste= value ?? '';
  // }
  
}
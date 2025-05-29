import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';

class EditMembersController extends MyController {
  // Make Firestore instance final
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Convert to observable lists and add proper typing
  final users = <Map<String, dynamic>>[].obs;
  final languages = <String>[].obs;
  final countries = <String>[].obs;
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


  
  // Convert to Rx variables for reactivity
  final selectedCountry = ''.obs;
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
  final selectedPartnerCitizenShip ="".obs;
  final selectedPartnerReligion ="".obs;
  final selectedPartnerMaritalStatus ="".obs;
  final selectedPartnerIncome ="".obs;

  final isLoading = false.obs;

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
    required String name,
    required String age,
    required String location,
    required String profession,
    required String education,
    required String height,
    required String aboutMe,
  }) async {
    try {
      isLoading(true);
      await _firestore.collection('users').doc(uid).update({
        'fullName': name,
        'age': age,
        'location': location,
        'profession': profession,
        'education': education,
        'height': height,
        'aboutMe': aboutMe,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'Basic data updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update data: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> savePersonalData({
    required String uid,
    required String religion,
    required String caste,
  }) async {
    try {
      isLoading(true);
      await _firestore.collection('users').doc(uid).update({
        'religion': religion,
        'caste': caste,
        // 'maritalStatus': maritalStatus.value,
        'language': selectedlanguage.value,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'Personal data updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update personal data');
    } finally {
      isLoading(false);
    }
  }

  Future<void> savePartnerPreferences({
    required String uid,
    required String partnerAge,
    required String partnerLocation,
    required String partnerProfession,
    required String partnerEducation,
  }) async {
    try {
      isLoading(true);
      await _firestore.collection('users').doc(uid).update({
        'partnerAge': partnerAge,
        'partnerLocation': partnerLocation,
        'partnerProfession': partnerProfession,
        'partnerEducation': partnerEducation,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'Partner preferences updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update partner preferences');
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

// Future<void> fetchDoshams() async {
//   try {
//     isLoading(true);
//     final querySnapshot = await _firestore.collection('ChovvaDosham').get();
//     doshams.assignAll(
//       querySnapshot.docs
//         .where((doc) => doc['isActive'] == true)
//         .map((doc) => doc['name'] as String)
//         .where((name) => name.isNotEmpty),
//     );
//   } catch (e) {
//     Get.snackbar('Error', 'Failed to load doshams');
//   } finally {
//     isLoading(false);
//   }
// }

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
  void setSelectedPartnerReligion(String religion) {
    selectedPartnerReligion.value = religion;
  }
  void setSelectedPartnerMaritalStatus(String maritalStatus) {
    selectedPartnerMaritalStatus.value = maritalStatus;
  }
  void setSelectedPartnerIncome(String income) {
    selectedPartnerIncome.value = income;
  }
  void setSelectedPartnerCitizenShip(String citizenShip) {
    selectedPartnerCitizenShip.value = citizenShip;
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
  }
}
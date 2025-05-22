import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/forms/basic_controller.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/models/caste_model.dart';
import 'package:webkit/models/education_model.dart';
import 'package:webkit/models/family_status_model.dart';
import 'package:webkit/models/family_type_model.dart';
import 'package:webkit/models/family_values_model.dart';
import 'package:webkit/models/horoscope_match_model.dart';
import 'package:webkit/models/languages_model.dart';
import 'package:webkit/models/marital_status_model.dart';
import 'package:webkit/models/occupation_model.dart';
import 'package:webkit/models/physical_status_model.dart';
import 'package:webkit/models/religion_model.dart';
import 'package:webkit/models/stars_model.dart';
import 'package:webkit/models/zodiac_sign.dart';


class AddMemberController extends MyController {
  UserCredential? _credential;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<MaritalStatusModel> maritalStatusList = [];
  List<ReligionModel> religionList = [];
  List<String> _profileNames = [];
  List<LanguageModel> languages = [];
  List<String> _subscription = [];
  List<CasteModel> casteList = [];
  List<PhysicalStatusModel> physicalStatusList = [];
  List<ZodiacSignModel> zodiacList=[];
  List<StarsModel> starsList=[];
  List<EducationModel> educationCategoryList=[];
  List<OccupationModel> professionCategoryList=[];
  List<HoroscopeMatchModel> horoscopeMatchList=[];
  List<FamilyValuesModel> familyValuesList = [];
  List<FamilyTypeModel> familyTypeList = [];
  List<FamilyStatusModel> familyStatus = [];
  bool isLoading = false;
  bool _isLoading = false;
  String? _errorMessage;
  String selectProperties2 = "";
  String maritalStatus = "";
  String physicalstatus = "";
  String castestatus = "";
  String zodiacstatus= "";
  String starstatus="";
  String chovvaDoshamStatus="";
  String horoscopeStatus="";
  String educationStatus="";
  String professionStatus="";
  String selectedFamilyValue = "";
  String selectedFamilyType = "";
  String selectedFamilyStatus = "";
  

  MyFormValidator basicValidator = MyFormValidator();
  var currentTabIndex = 0.obs;
  var registrationdone = false.obs;
  String subscription = "";
  String religion = "";     
  String language = "";

  UserCredential? get credential => _credential;
  List<String> get profileNames => _profileNames;
  List<String> get Subscription => _subscription;
  bool get isLoading2 => _isLoading;
  String? get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void updateTabIndex(int index) {
    currentTabIndex.value = index;
  }

  void setRegistrationDone(bool value) {
    registrationdone.value = value;
  }

  Future<void> createUser(
    String emailAddress,
    String password,
  ) async {
    try {
      _credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveUserData(
    String name,
    String email,
    // String phoneNumber,
    // String motherTongue
  ) async {
    try {
      final uid = _credential?.user?.uid;

      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'fullName': name.trim(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'forWhom': selectProperties2,
          'gender': selectedGender.name,
          'uid': uid,
          'email': email.trim(),
          'language': language,
          'subscription': subscription,
          'status': 'active',
        }, SetOptions(merge: true));
      }
    } catch (e) {
      // Handle errors here if you want
      debugPrint("Error saving user data: $e");
    }
  }

  Future<void> saveProfile(
    String dob,
    String age,
    String location,
    String profession,
    String education,
    String height,
    String aboutMe,
    String religion,
    String caste,
    String weight,
  ) async {
    isLoading = true;
    try {
      final uid = _credential?.user?.uid;

      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'dob': dob,
          'age': age,
          'location': location.trim(),
          'profession': profession.trim(),
          'education': education.trim(),
          'height': height.trim(),
          'aboutMe': aboutMe.trim(),
          'maritalStatus': maritalStatus,
          'updatedAt': FieldValue.serverTimestamp(),
          'religion': religion.trim(),
          'caste': caste.trim(),
          'weight': weight,
          'physicalStatus': physicalstatus,
          'educationCategory': educationStatus,
          'professionCategory': professionStatus
        }, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint("Error saving profile: $e");
    } finally {
      setLoading(false);
    }
  }
  Future<void> saveReligiousInfo(
  ) async {
    isLoading = true;
    try {
      final uid = _credential?.user?.uid;

      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'religion': religion,
          'caste': castestatus,
          'zodiacSign': zodiacstatus,
          'star': starstatus,
          'chovvaDosham': chovvaDoshamStatus,
          'horoscope': horoscopeStatus,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint("Error saving profile: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> savePartnerPreferences(
    String partnerAge,
    String partnerLocation,
    String partnerProfession,
    String partnerEducation,
  ) async {
    isLoading = true;
    try {
      final uid = _credential?.user?.uid;

      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'partnerAge': partnerAge,
          'partnerLocation': partnerLocation.trim(),
          'partnerProfession': partnerProfession.trim(),
          'partnerEducation': partnerEducation.trim(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint("Error saving profile: $e");
    } finally {
      setLoading(false);
    }
  }

    Future<void> fetchSubscription() async {
      try {
        _isLoading = true;
        update();

        final querySnapshot = await _firestore.collection('subscription').get();

        _subscription = querySnapshot.docs
            .map((doc) => doc['name'] as String)
            .where((name) => name.isNotEmpty)
            .toList();

        _errorMessage = null;
      } catch (e) {
        _errorMessage = "Failed to load subscription: ${e.toString()}";
        print(_errorMessage);
      } finally {
        _isLoading = false;
        update();
      }
    }

    Future<void> fetchLanguages() async {
      try {
        final querySnapshot = await _firestore
            .collection('languages')
            .orderBy('sort_by') // Sort by `sort_by` field
            .get();

        languages = querySnapshot.docs
            .map((doc) => LanguageModel.fromDoc(doc.data(), doc.id))
            .toList();

        update();
      } catch (e) {
        print("Error fetching languages: $e");
        Get.snackbar("Error", "Failed to fetch languages");
      }
    }

    Future<void> fetchProfileNames() async {
      try {
        final querySnapshot = await _firestore.collection('ProfileNames').get();
        _profileNames = querySnapshot.docs
            .where((doc) => doc['status'] == 'active')
            .expand((doc) => (doc['name'] as String).split(','))
            .map((name) => name.trim())
            .where((name) => name.isNotEmpty)
            .toSet()
            .toList();

        _errorMessage = null;
      } catch (e) {
        _errorMessage = "Failed to load profile names: ${e.toString()}";
        print(_errorMessage);
      }
    }

    Future<void> fetchMaritalStatus() async {
      try {
        _isLoading = true;
        update();

        final querySnapshot = await _firestore.collection('MaritalStatus').get();

        maritalStatusList = querySnapshot.docs
            .map((doc) => MaritalStatusModel.fromDoc(doc))
            .toList();
      } catch (e) {
        print(e.toString());
      } finally {
        _isLoading = false;
        update();
      }
    }

    Future<void> fetchReligions() async {
      try {
        _isLoading = true;
        update();

        final querySnapshot = await _firestore.collection('Religion').get();

        religionList =
            querySnapshot.docs.map((doc) => ReligionModel.fromDoc(doc)).toList();
      } catch (e) {
        _errorMessage = "Failed to load religions: ${e.toString()}";
        print(_errorMessage);
      } finally {
        _isLoading = false;
        update();
      }
    }

      Future<void> fetchCastesForReligion(String selectedReligion) async {
        try {
          casteList.clear();
          update();

          // Find the religion document by name
          final religionDoc = await _firestore
              .collection('Religion')
              .where('name', isEqualTo: selectedReligion)
              .limit(1)
              .get();

          if (religionDoc.docs.isNotEmpty) {
            final religionId = religionDoc.docs.first.id;

            // Fetch castes from the subcollection
            final casteSnapshot = await _firestore
                .collection('Religion')
                .doc(religionId)
                .collection('castes')
                .get();

            casteList = casteSnapshot.docs
                .map((doc) => CasteModel.fromDoc(doc, religionId))
                .toList();
          } else {
            casteList = []; // No castes if religion not found
          }
        } catch (e) {
          print("Error fetching castes: $e");
          casteList = [];
        } finally {
          update();
        }
      }

    Future<void> fetchPhysicalStatus() async {
      try {
        _isLoading = true;
        update();

        final querySnapshot = await _firestore.collection('PhysicalStatus').get();

        physicalStatusList = querySnapshot.docs
            .map((doc) => PhysicalStatusModel.fromDoc(doc))
            .toList();
      } catch (e) {
        _errorMessage = "Failed to load PhysicalStatus: ${e.toString()}";
        print(_errorMessage);
      } finally {
        _isLoading = false;
        update();
      }
    }
    Future<void> fetchZodiacSigns() async { 
      try {
        _isLoading = true;
        update();

        final querySnapshot = await _firestore.collection('ZodiacSign').get();

        zodiacList = querySnapshot.docs
            .map((doc) => ZodiacSignModel.fromDoc(doc))
            .toList();
        _errorMessage = null;
      } catch (e) {
        _errorMessage = "Failed to load Zodiac Signs: ${e.toString()}";
        print(_errorMessage);
      } finally {
        _isLoading = false;
        update();
      }
    }
    Future<void> fetchStars() async {
      try {
        _isLoading = true;
        update();

        final querySnapshot = await _firestore.collection('Stars').get();

        starsList = querySnapshot.docs
            .map((doc) => StarsModel.fromDoc(doc))
            .toList();
        _errorMessage = null;
      } catch (e) {
        _errorMessage = "Failed to load Stars: ${e.toString()}";
        print(_errorMessage);
      } finally {
        _isLoading = false;
        update();
      }
    }
    Future<void> fetchEducationCategories() async {
    try {
      _isLoading = true;
      update(); // If using Getx or notifyListeners() for ChangeNotifier

      final querySnapshot = await _firestore.collection('Education').get();

      educationCategoryList = querySnapshot.docs
          .map((doc) => EducationModel.fromDoc(doc))
          .toList();

      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load Education Categories: ${e.toString()}";
      print(_errorMessage);
    } finally {
      _isLoading = false;
      update();
    }
  }
  Future<void> fetchHoroscopeMatch() async {
      try {
        _isLoading = true;
        update();

        final querySnapshot = await _firestore.collection('HoroscopeMatch').get();

        horoscopeMatchList = querySnapshot.docs
            .map((doc) => HoroscopeMatchModel.fromDoc(doc))
            .toList();
        _errorMessage = null;
      } catch (e) {
        _errorMessage = "Failed to load HoroscopeMatch: ${e.toString()}";
        print(_errorMessage);
      } finally {
        _isLoading = false;
        update();
      }
    }
  Future<void> fetchProfessionCategories() async {
    try {
      _isLoading = true;
      update(); // If using Getx or notifyListeners() for ChangeNotifier

      final querySnapshot = await _firestore.collection('Occupation').get();

      professionCategoryList = querySnapshot.docs
          .map((doc) => OccupationModel.fromDoc(doc))
          .toList();

      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load Profession Categories: ${e.toString()}";
      print(_errorMessage);
    } finally {
      _isLoading = false;
      update();
    }
  }
  Future<void> fetchFamilyValues() async {  
    try {
      _isLoading = true;
      update();

      final querySnapshot = await _firestore.collection('FamilyValues').get();

      familyValuesList = querySnapshot.docs
          .map((doc) => FamilyValuesModel.fromDoc(doc))
          .toList();

      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load Family Values: ${e.toString()}";
      print(_errorMessage);
    } finally {
      _isLoading = false;
      update();
    }
  }
  Future<void> fetchFamilyType() async {
    try {
      _isLoading = true;
      update();

      final querySnapshot = await _firestore.collection('FamilyType').get();

      familyTypeList = querySnapshot.docs
          .map((doc) => FamilyTypeModel.fromDoc(doc))
          .toList();

      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load Family Type: ${e.toString()}";
      print(_errorMessage);
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> fetchFamilyStatus() async {
    try {
      _isLoading = true;
      update();

      final querySnapshot = await _firestore.collection('FamilyStatus').get();

      familyStatus = querySnapshot.docs
          .map((doc) => FamilyStatusModel.fromDoc(doc))
          .toList();

      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load Family Status: ${e.toString()}";
      print(_errorMessage);
    } finally {
      _isLoading = false;
      update();
    }
  }


  void onSelectedmaritalStatus(String size) {
    maritalStatus = size;
    update();
  }

  void onSelectedSize2(String size) {
    selectProperties2 = size;
    update();
  }

  void onSelectedSubscription(String size) {
    subscription = size;
    update();
  }

  void onReligionSelectedSize(String selectedReligion) {
    religion = selectedReligion;
    fetchCastesForReligion(selectedReligion); // Fetch corresponding castes
    update();
  }

  void onLanguageSelectedSize(String size) {
    language = size;
    update(); 
  }

  void onPhysicalStatusSelectedSize(String size) {
    physicalstatus = size;
    update();
  }

  void oncasteSelectedSize(String size) {
    castestatus = size;
    update();
  }

  void onZodiacSignSelectedSize(String size) {
    zodiacstatus = size;
  }
  void onStarsSelectedSize(String size) {
    starstatus = size;
    update();
  }
  void onchovvaDoshamSelectedSize(String size) {
    chovvaDoshamStatus = size;
    update();
  }
  void onHoroscopeSelectedSize(String size) {
  horoscopeStatus = size;
  update();
}
 void onEducationSelectedSize(String value) {
  educationStatus = value;
  update(); 
}
void onProfessionSelectedSize(String value) {
  professionStatus = value;
  update(); 
}
  void onFamilyValuesSelectedSize(String value) {
    selectedFamilyValue = value;
    update();
  } 
  void onFamilyTypeSelectedSize(String value) {
    selectedFamilyType = value;
    update();
  }
  void onFamilyStatusSelectedSize(String value) {
    selectedFamilyStatus = value;
    update();
  }



  Future<void> savePhoneNumber(
    String phoneNumber,
  ) async {
    isLoading = true;
    try {
      final uid = _credential?.user?.uid;

      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'phoneNumber': "+91$phoneNumber",
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint("Error saving profile: $e");
    }
  }

  int calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.always;
  TextFieldBorderType borderType = TextFieldBorderType.outline;
  bool showPassword = false,
      publicStatus = false,
      newsletter = true,
      checked = false;

  Gender selectedGender = Gender.male;
  bool filled = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTimeRange? selectedDateTimeRange;
  DateTime? selectedDateTime;
  RangeValues rangeSlider = const RangeValues(20, 40);
  double slider1 = 10, slider2 = 50;

  OutlineInputBorder? get inputBorder {
    if (borderType == TextFieldBorderType.underline) {
      return null;
    }

    if (borderType == TextFieldBorderType.none) {
      return const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none);
    }
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    );
  }

  void onChangeGender(Gender? value) {
    selectedGender = value ?? selectedGender;
    update();
  }

  void onChangeLabelType(FloatingLabelBehavior value) {
    floatingLabelBehavior = value;
    update();
  }

  void changeNewsletterStatus(bool value) {
    newsletter = value;
    update();
  }

  void onChangeSlider1(double value) {
    slider1 = value;
    update();
  }

  void onChangeSlider2(double value) {
    slider2 = value;
    update();
  }

  void onChangedChecked(bool? value) {
    checked = value ?? checked;
    update();
  }

  void onChangeRangeSlider(RangeValues value) {
    rangeSlider = value;
    update();
  }

  void onChangeBorderType(TextFieldBorderType value) {
    borderType = value;
    if (borderType == TextFieldBorderType.none) {
      filled = true;
    }
    update();
  }

  void onChangedFilledChecked(bool? value) {
    filled = value ?? filled;
    update();
  }

  void changeAccountStatus(bool value) {
    publicStatus = value;
    update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  bool religionError = false;
  bool casteError = false;
  bool zodiacError = false;     
  bool starError = false;
  bool chovvaDoshamError = false;
  bool horoscopeError = false;
  bool subscriptionError = false;
  bool languageError = false;
  bool maritalStatusError = false;
  bool physicalStatusError = false;
  bool profileNameError = false;
  bool selectProperties2Error=false;



bool registrationValidate() {
  return language.isNotEmpty &&
      subscription.isNotEmpty &&
      selectProperties2.isNotEmpty;
}

bool showFieldErrors = false;

bool validateProfile() {
  return physicalstatus.isNotEmpty && maritalStatus.isNotEmpty;
}

void setShowFieldErrors(bool show) {
  showFieldErrors = show;
  update();
}


  bool validateReligiousInfo() {
    return religion.isNotEmpty &&
          castestatus.isNotEmpty &&
          zodiacstatus.isNotEmpty &&
          starstatus.isNotEmpty &&
          chovvaDoshamStatus.isNotEmpty &&
          horoscopeStatus.isNotEmpty;
  }
  
  void refreshUI() {
    update();
  }

}

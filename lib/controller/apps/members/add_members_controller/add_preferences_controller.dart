import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/annual_income_model.dart';
import 'package:webkit/models/caste_model.dart';
import 'package:webkit/models/citizenship_model.dart';
import 'package:webkit/models/country_model.dart';
import 'package:webkit/models/drinking_habits_model.dart';
import 'package:webkit/models/eating_habits_model.dart';
import 'package:webkit/models/education_model.dart';
import 'package:webkit/models/marital_status_model.dart';
import 'package:webkit/models/mother_tongue_model.dart';
import 'package:webkit/models/occupation_model.dart';
import 'package:webkit/models/religion_model.dart';
import 'package:webkit/models/smoking_habits_model.dart';
import 'package:webkit/models/stars_model.dart';
import 'package:webkit/models/states_model.dart';

class AddPreferencesController extends MyController {
  final _firestore = FirebaseFirestore.instance;
  UserCredential? _credential;
  UserCredential? get credential => _credential;
  List<CountryModel> allCountry = []; 
  String selectedCountry = ""; 


  List<StatesModel> statesList = [];
  List<String> selectedStates = [];
  List<String> tempSelectedStates = [];

  List<EducationModel> allEducation = [];
  List<String> selectedEducation = [];
  List<String> tempSelectedEducation = [];

  List<OccupationModel> allProfessions = [];
  List<String> selectedProfessions = [];
  List<String> tempSelectedProfessions = [];

  List<MotherTongueModel> allMotherTongues = [];
  List<String> selectedMotherTongues = [];
  List<String> tempSelectedMotherTongues = [];
  
  List<MaritalStatusModel>maritalStatusList = [];
  String maritalStatus = ''; 

  List<AnnualIncomeModel> annualIncomeList =[];
  String annualIncome = '';

  List<ReligionModel> religionList = [];
  String selectedReligion = '';

  List<CasteModel> casteList = [];
  List<String> selectedCastes = [];
  List<String> tempSelectedCastes = [];

  List<StarsModel> starsList = [];
  List<String> selectedStar = [];
  List<String> tempSelectedStar = [];

  String selectedChovvaDosham = '';

  List<EatingHabitsModel> eatingHabitsList = [];
  List<String> selectedeatingHabits = [];
  List<String> tempSelectedEatingHabits = [];

  List<SmokingHabitsModel> smokingHabitsList = [];
  List<String> selectedSmokingHabits = [];
  List<String> tempSelectedSmokingHabits = [];

  List<DrinkingHabitsModel> drinkingHabitsList=[];
  List<String> selectedDrinkingHabits=[];
  List<String> tempSelectedDrinkingHabits=[];

  List<CitizenshipModel> citizenshipList=[];
  List<String> selectedcitizenShip=[];
  List<String> tempSelectedCitizenship=[];



  @override
  void onInit() {
    super.onInit();
    fetchLocations();
    }

  Future<void> savePartnerPreferences(
    String partnerAge, 
    String PartnersHeight
  ) async {
    try {
      final uid = _credential?.user?.uid;

      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'partnerAge': partnerAge,
          'partnerCitizenship': selectedcitizenShip,
          'partnerCountry': selectedCountry,
          'partnerStates': selectedStates,
          'partnerEducationList': selectedEducation,
          'partnerProfessions': selectedProfessions,
          "partnersHeight": PartnersHeight,
          'partnerMotherTongue': selectedMotherTongues,
          'partnerMaritalStatus': maritalStatus,
          'partnerAnnualIncome': annualIncome,
          'partnerReligion': selectedReligion,
          'partnerCastes': selectedCastes,
          'partnerStars': selectedStar,
          'partnerChovvaDosham': selectedChovvaDosham,
          'partnerEatingHabits': selectedeatingHabits,
          'partnerSmokingHabits': selectedSmokingHabits,
          'partnerDrinkingHabits': selectedDrinkingHabits, 
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Error saving partner preferences: $e');
    }
  }
    

  Future<void> fetchCitizenship() async {
    try {
      final _firestore = FirebaseFirestore.instance;
      final querySnapshot = await _firestore.collection('Citizenship').get();

      citizenshipList = querySnapshot.docs
          .map((doc) => CitizenshipModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching citizenship: $e');
    }
  }
  void onCitizenShipChanged(bool? value, String citizenship) {
    if (value == true) {
      selectedcitizenShip.add(citizenship);
    } else {
      selectedcitizenShip.remove(citizenship);
    }
    update();
  }



  Future<void> fetchMotherTongues() async {
    try {
      final _firestore = FirebaseFirestore.instance;
      final querySnapshot = await _firestore.collection('languages').get();

      allMotherTongues = querySnapshot.docs
          .map((doc) => MotherTongueModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching mother tongues: $e');
    }
  }

  Future<void> fetchProfessions() async {
    try {
      final _firestore = FirebaseFirestore.instance;
      final querySnapshot = await _firestore.collection('Occupation').get();

      allProfessions = querySnapshot.docs
          .map((doc) => OccupationModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching professions: $e');
    }
  }
  Future<void> fetchEducation() async {
    try {
      final _firestore = FirebaseFirestore.instance;
      final querySnapshot = await _firestore.collection('Education').get();

      allEducation = querySnapshot.docs
          .map((doc) => EducationModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching education: $e');
    }
  }
  Future<void> fetchAnnualIncome() async {
    try {
      final _firestore = FirebaseFirestore.instance;
      final querySnapshot = await _firestore.collection('AnnualIncome').get();

      annualIncomeList = querySnapshot.docs
          .map((doc) => AnnualIncomeModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching annual income: $e');
    }
  }
  void onSelectedannualIncome(String size) {
    annualIncome = size;
    update();
  }

  Future<void> fetchReligions() async {
      try {

        final querySnapshot = await _firestore.collection('Religion').get();

        religionList =
            querySnapshot.docs.map((doc) => ReligionModel.fromDoc(doc)).toList();
      } catch (e) {

      } finally {
        update();
      }
    }
    void onSelectedReligion(String religion) {
        selectedReligion = religion;
        fetchCastesForReligion(selectedReligion);
        casteList.clear();  
        update();
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
  Future<void> fetchStars() async {
    try {
      final _firestore = FirebaseFirestore.instance;
      final querySnapshot = await _firestore.collection('Stars').get();

      starsList = querySnapshot.docs
          .map((doc) => StarsModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching stars: $e');
    }
  }



    Future<void> fetchLocations() async {
      try {
        final _firestore = FirebaseFirestore.instance;
        final querySnapshot = await _firestore.collection('Country').get();

        allCountry= querySnapshot.docs
            .map((doc) => CountryModel.fromDoc(doc))
            .toList();
        update();
      } catch (e) {
        print('Error fetching locations: $e');
      }
    }
    void onSelectedCountry(String country) {
        selectedCountry = country;
        fetchStatesForCountry(selectedCountry);
        statesList.clear();  
        update();
      }
   
      Future<void> fetchStatesForCountry(String countryName) async {
        try {
          // Clear previous states if you have a states list
          statesList.clear();
          update();

          final countryDoc = await _firestore
              .collection('Country')
              .where('name', isEqualTo: countryName)
              .limit(1)
              .get();

          if (countryDoc.docs.isNotEmpty) {
                final CountryId = countryDoc.docs.first.id;

                // Fetch castes from the subcollection
                final stateSnapshot = await _firestore
                    .collection('Country')
                    .doc(CountryId)
                    .collection('States')
                    .get();

                statesList = stateSnapshot.docs
                    .map((doc) => StatesModel.fromDoc(doc, countryId: CountryId))
                    .toList();
              } else {
                statesList = []; // No castes if religion not found
              }


          update();
        } catch (e) {
          print('Error fetching states: $e');
          // Optionally handle error state
        }

      }


  
  Future<void> fetchMaritalStatus() async {
      try {
        final querySnapshot = await _firestore.collection('MaritalStatus').get();
          maritalStatusList = querySnapshot.docs.map((doc) => MaritalStatusModel.fromDoc(doc)).toList();
      } catch (e) {
        print(e.toString());
      } finally {
        update();
      }
    }
  void onSelectedmaritalStatus(String size) {
    maritalStatus = size;
    update();
  }
  void onSelectedChovvaDosham(String value) {
    selectedChovvaDosham = value;
    update();
  }

  Future<void> fetchEatingHabits() async {
    try {
      final querySnapshot = await _firestore.collection('EatingHabits').get();
      eatingHabitsList = querySnapshot.docs
          .map((doc) => EatingHabitsModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching eating habits: $e');
    }
  }

  void onEatingHabitsChanged(bool? value, String habit) {
    if (value == true) {
      selectedeatingHabits.add(habit);
    } else {
      selectedeatingHabits.remove(habit);
    }
    update();
  }
  Future<void> fetchSmokingHabits() async {
    try {
      final querySnapshot = await _firestore.collection('SmokingHabits').get();
      smokingHabitsList = querySnapshot.docs
          .map((doc) => SmokingHabitsModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching eating habits: $e');
    }
  }

  void onSmokingHabitsChanged(bool? value, String habit) {
    if (value == true) {
      selectedSmokingHabits.add(habit);
    } else {
      selectedSmokingHabits.remove(habit);
    }
    update();
  }
  Future<void> fetchDrinkingHabits() async {
    try {
      final querySnapshot = await _firestore.collection('DrinkingHabits').get();
      drinkingHabitsList = querySnapshot.docs
          .map((doc) => DrinkingHabitsModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching eating habits: $e');
    }
  }

  void onDrinkingHabitsChanged(bool? value, String habit) {
    if (value == true) {
      selectedDrinkingHabits.add(habit);
    } else {
      selectedDrinkingHabits.remove(habit);
    }
    update();
  }


String? religionError;
String? annualIncomeError;
String? maritalStatusError;
String? ChovvaDoshamError;
String? countryError;


bool validateSelections() {
  bool isValid = true;

  if (selectedReligion.isEmpty) {
    religionError = 'Please select a religion';
    isValid = false;
  } else {
    religionError = null;
  }
  if (maritalStatus.isEmpty) {
    maritalStatusError = 'Please select marital status';
    isValid = false;
  } else {
    maritalStatusError = null;
  }
  if (selectedChovvaDosham.isEmpty) {
    ChovvaDoshamError = 'Please select Chovva Dosham';
    isValid = false;
  } else {
    ChovvaDoshamError = null;
  }

  if (annualIncome.isEmpty) {
    annualIncomeError = 'Please select annual income';
    isValid = false;
  } else {
    annualIncomeError = null;
  }
  if (selectedCountry.isEmpty) {
    countryError = 'Please select a country';
    isValid = false;
  } else {
    countryError = null;
  }


  update();
  return isValid;
}

}

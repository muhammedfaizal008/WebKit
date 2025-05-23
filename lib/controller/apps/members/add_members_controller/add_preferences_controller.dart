import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/models/country_model.dart';
import 'package:webkit/models/education_model.dart';
import 'package:webkit/models/occupation_model.dart';

class AddPreferencesController extends MyController {
  List<CountryModel> allLocations = []; 
  List<String> selectedLocations = []; 
   List<String> tempSelectedLocations = [];

  List<EducationModel> allEducation = [];
  List<String> selectedEducation = [];
  List<String> tempSelectedEducation = [];

  List<OccupationModel> allProfessions = [];
  List<String> selectedProfessions = [];
  List<String> tempSelectedProfessions = [];

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
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



  Future<void> fetchLocations() async {
    try {
      final _firestore = FirebaseFirestore.instance;
      final querySnapshot = await _firestore.collection('Country').get();

       allLocations= querySnapshot.docs
          .map((doc) => CountryModel.fromDoc(doc))
          .toList();
      update();
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }
  void onLocationChanged(bool? value, String location) {
  if (value == true) {
    selectedLocations.add(location);
  } else {
    selectedLocations.remove(location);
  }
  update();
  }

  void onEducationChanged(bool? value, String education) {
    if (value == true) {
      selectedEducation.add(education);
    } else {
      selectedEducation.remove(education);
    }
    update();
  }
  void onProfessionChanged(bool? value, String profession) {
    if (value == true) {
      selectedProfessions.add(profession);
    } else {
      selectedProfessions.remove(profession);
    }
    update();
  }
}

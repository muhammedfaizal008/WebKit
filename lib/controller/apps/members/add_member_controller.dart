import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/forms/basic_controller.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';


class AddMemberController extends MyController{
  UserCredential? _credential;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _profileNames = [];
  List<String> _languages = [];
  bool isLoading = false;
  bool _isLoading = false;
  String? _errorMessage;
  String selectProperties = "Malayalam";
  String selectProperties2 = "Myself";
  String selectProperties3 = "Single";
  MyFormValidator basicValidator = MyFormValidator();
  var currentTabIndex = 0.obs;
  var registrationdone = false.obs;
  

  UserCredential? get credential => _credential;
  List<String> get profileNames => _profileNames;
  List<String> get languages => _languages;
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
        // 'phoneNumber': "+91$phoneNumber",
        'updatedAt': FieldValue.serverTimestamp(),
        'gender': selectedGender.name,      
        'uid': uid,
        'email': email.trim(),
        'language': selectProperties,
        'for_whom   ': selectProperties2,         
      }, SetOptions(merge: true));

    }
  } catch (e) {
      // Handle errors here if you want
      debugPrint("Error saving user data: $e");
    }
  }

  Future<void> saveProfile(
    String age,
    String location,
    String profession,
    String education,
    String height,
    String aboutMe,
    // String maritalStatus,
    String religion,
    String caste,
  ) async {
    isLoading = true;
    try {
      final uid = _credential?.user?.uid;

      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'age': age,
          'location': location.trim(),
          'profession': profession.trim(),
          'education': education.trim(),
          'height': height.trim(),
          'aboutMe': aboutMe.trim(),
          'maritalStatus': selectProperties3,
          'updatedAt': FieldValue.serverTimestamp(),
          'religion': religion.trim(),
          'caste': caste.trim(),

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
  Future<void> fetchLanguages() async {
  try {
    _isLoading = true;
    update();

    final querySnapshot = await _firestore
        .collection('languages')
        .orderBy('sort_by') // Add this to sort by sort_by field
        .get();

    _languages = querySnapshot.docs
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty)
        .toList();

    _errorMessage = null;
  } catch (e) {
    _errorMessage = "Failed to load languages: ${e.toString()}";
    print(_errorMessage);
  } finally {
    _isLoading = false;
    update();
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
  void onSelectedSize3(String size) {
    selectProperties3 = size;
    update();
  } 
  void onSelectedSize2(String size) {
    selectProperties2 = size;
    update();
  } 
  void onSelectedSize(String size) {
    selectProperties = size;
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

  // Future<void> pickDate() async {
  //   final DateTime? picked = await showDatePicker(
  //       context: Get.context!,
  //       initialDate: selectedDate ?? DateTime.now(),
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //     update();
  //   }
  // }

  // Future<void> pickTime() async {
  //   final TimeOfDay? picked = await showTimePicker(
  //       context: Get.context!, initialTime: selectedTime ?? TimeOfDay.now());
  //   if (picked != null && picked != selectedTime) {
  //     selectedTime = picked;
  //     update();
  //   }
  // }

  // Future<void> pickDateRange() async {
  //   final DateTimeRange? picked = await showDateRangePicker(
  //       context: Get.context!,
  //       initialEntryMode: DatePickerEntryMode.input,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDateTimeRange) {
  //     selectedDateTimeRange = picked;
  //     update();
  //   }
  // }

  // Future<void> pickDateTime() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //       context: Get.context!,
  //       initialDate: selectedDate ?? DateTime.now(),
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (pickedDate != null) {
  //     final TimeOfDay? pickedTime = await showTimePicker(
  //         context: Get.context!, initialTime: selectedTime ?? TimeOfDay.now());
  //     if (pickedTime != null) {
  //       selectedDateTime = pickedDate.applied(pickedTime);
  //       update();
  //     }
  //   }
  // }
  


}
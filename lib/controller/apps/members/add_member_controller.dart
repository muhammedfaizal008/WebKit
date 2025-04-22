import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:webkit/controller/forms/basic_controller.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/extensions/date_time_extention.dart';

class AddMemberController extends MyController{
  UserCredential? _credential;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  UserCredential? get credential => _credential;

  void setLoading(bool value) {
    isLoading = value;
    update();
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

  Future<void> saveProfile(
    String userId,
     nameController,
     ageController,
     locationController,
     professionController,
     educationController,
     heightController,
     aboutMeController,
     phoneNumberController,
     maritalStatusController,
     religionController,
     casteController,
     motherTongueController,
    
    // Partner Preferences
     agePartnerController,
     locationPartnerController,
     professionPartnerController,
     educationPartnerController,
  ) async {
    
  isLoading = true;
  try {
    final uid = _credential?.user?.uid;

    if (uid != null) {
      await _firestore.collection('users').doc(userId).set({
        'fullName': nameController.text.trim(),
        'age': int.tryParse(ageController.text.trim()) ?? 0,
        'location': locationController.text.trim(),
        'profession': professionController.text.trim(),
        'education': educationController.text.trim(),
        'height': heightController.text.trim(),
        'aboutMe': aboutMeController.text.trim(),
        'phoneNumber': phoneNumberController.text.trim(),
        'maritalStatus': maritalStatusController.text.trim(),
        'religion': religionController.text.trim(),

        'caste': casteController.text.trim(),
        'motherTongue': motherTongueController.text.trim(),
        
        // Partner Preferences
        'partnerAge': agePartnerController.text.trim(),
        'partnerLocation': locationPartnerController.text.trim(),
        'partnerProfession': professionPartnerController.text.trim(),
        'partnerEducation': educationPartnerController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'userId': uid,      
      }, SetOptions(merge: true));

    }
  } catch (e) {
    // Handle errors here if you want
    debugPrint("Error saving profile: $e");
  } finally {
    setLoading(false);
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

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
        context: Get.context!, initialTime: selectedTime ?? TimeOfDay.now());
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      update();
    }
  }

  Future<void> pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
        context: Get.context!,
        initialEntryMode: DatePickerEntryMode.input,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateTimeRange) {
      selectedDateTimeRange = picked;
      update();
    }
  }

  Future<void> pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
          context: Get.context!, initialTime: selectedTime ?? TimeOfDay.now());
      if (pickedTime != null) {
        selectedDateTime = pickedDate.applied(pickedTime);
        update();
      }
    }
  }


}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webkit/controller/my_controller.dart';

class EditMembersController extends MyController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> users = [];
  String selectProperties = "Single";
  String selectProperties1 = "Malayalam";
  List<String> _languages = [];

  List<String> get languages => _languages;

  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    users = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['uid'] = doc.id; // Ensure UID is included
      return data;
    }).toList();

    update(); // Notify UI
    return users;
  }

  Map<String, dynamic>? getUserById(String uid) {
    return users.firstWhere((user) => user['uid'] == uid, orElse: () => {});
  }

  /// Used to create a new user (if doc doesn't exist)
  Future<void> createUserData(
    String uid,
    String name,
    String age,
    String location,
    String profession,
    String education,
    String height,
    String aboutMe,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'fullName': name,
        'age': int.tryParse(age),
        'location': location,
        'profession': profession,
        'education': education,
        'height': int.tryParse(height),
        'aboutMe': aboutMe,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('User created: $uid');
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  /// Used to update existing user
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
      await _firestore.collection('users').doc(uid).update({
        'fullName': name,
        'age': int.tryParse(age),
        'location': location,
        'profession': profession,
        'education': education,
        'height': int.tryParse(height),
        'aboutMe': aboutMe,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('User updated: $uid');
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> savePersonalData({
    required String uid,
    required String religion,
    required String caste,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'religion': religion,
        'caste': caste,
        'maritalStatus': selectProperties,
        'language': selectProperties1,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('User updated: $uid');
    } catch (e) {
      print('Error updating user: $e');
    }
    }

  Future<void> savePartnerPrefereneces({
    required String uid,
    required String partnerAge,
    required String partnerLocation,
    required String partnerProfession,
    required String partnerEducation,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'partnerAge': int.tryParse(partnerAge),
        'partnerLocation': partnerLocation,
        'partnerProfession': partnerProfession,
        'partnerEducation': partnerEducation,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('User updated: $uid');
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> fetchLanguages() async {
    try {


      final querySnapshot = await _firestore
          .collection('languages')
          .orderBy('sort_by') // Add this to sort by sort_by field
          .get();

      _languages = querySnapshot.docs
          .map((doc) => doc['name'] as String)
          .where((name) => name.isNotEmpty)
          .toList();


    } catch (e) {
      print('Error fetching languages: $e');
    } finally {
    } 
  }

  void onSelectedSize(String size) {
    selectProperties = size;
    update();
  }
  void onSelectedSize1(String size) {
    selectProperties1 = size;
    update();
  }
}

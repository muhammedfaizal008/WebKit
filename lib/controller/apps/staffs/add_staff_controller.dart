import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webkit/controller/my_controller.dart';

class AddStaffController extends MyController{
  UserCredential? _credential;
  String selectedRole='';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  List<String> roleList=[];
  @override
  void onInit() {
    fetchStaffRoles();
    super.onInit();
  }
  void onSelectedRole(String? newValue) {
    selectedRole = newValue ?? '';
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
  Future saveUserData(
    String name,
    String email,
    String phoneNumber,
  ) async {
    try {
      final uid = _credential?.user?.uid;
      if (uid != null) {
        await _firestore.collection('Admins').doc(uid).set({
          'fullName': name.trim(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'uid': uid,
          'email': email.trim(),
          'role':selectedRole,
          'status': 'active',
        }, SetOptions(merge: true));
      }
      
    } catch (e) {
      // Handle errors here if you want
      print("Error saving user data: $e");
    }
  }

  
  Future<void> fetchStaffRoles() async {
    try {
      final querySnapshot = await _firestore.collection('StaffRole').get();
        roleList = querySnapshot.docs
            .where((doc) => doc['isActive'] == true)
            .map((doc) => doc['role'] as String)
            .where((name) => name.isNotEmpty)
            .toList();
      update();
    } catch (e) {
      print(e);
      roleList = [];
      update();
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webkit/controller/my_controller.dart';

class EditMembersController extends MyController {
  List<Map<String, dynamic>> users = [];

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
}

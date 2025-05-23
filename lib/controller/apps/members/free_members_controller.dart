    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:flutter/material.dart';
    import 'package:get/get.dart';
    import 'package:webkit/controller/my_controller.dart';
    import 'package:webkit/models/user_model.dart';
    import 'package:webkit/views/apps/members/free_members.dart';

    class FreeMembersController extends MyController {
      List<UserModel> users = []; 
      late DataTableSource dataSource; // Non-nullable with late initialization
      UserModel? selectedUser;
      DocumentSnapshot? _lastVisibleDocument;
      DocumentSnapshot? _firstVisibleDocument;
      List<DocumentSnapshot> _documentSnapshots = [];
      bool hasNext = true;
      bool hasPrevious = false;
      int pageSize = 5;
      bool isLoading = true; // Initialize as true

      @override
      void onInit() {
        super.onInit();
        dataSource = UsersDataTable([], (user) {});
        fetchUsers();
        listenToTotalUserUpdates();
      }

      void selectUser(UserModel user) {
        selectedUser = user;
        update();
      }

      Future<void> fetchUsers({bool isInitialLoad = true, bool isPrevious = false}) async {
  try {
    if ((!hasNext && !isPrevious) || (!hasPrevious && isPrevious)) return;
    
    isLoading = true;
    update();

    Query query = FirebaseFirestore.instance
        .collection('users')
        .orderBy('fullName')
        .limit(pageSize);

    if (!isInitialLoad) {
      if (isPrevious) {
        query = query.endBeforeDocument(_firstVisibleDocument!).limitToLast(pageSize);
      } else {
        query = query.startAfterDocument(_lastVisibleDocument!);
      }
    }

    final snapshot = await query.get();
    _documentSnapshots = snapshot.docs;

    if (snapshot.docs.isNotEmpty) {
      _firstVisibleDocument = snapshot.docs.first;
      _lastVisibleDocument = snapshot.docs.last;

      users = snapshot.docs.map((doc) {
        return UserModel.fromMap({...doc.data() as Map<String, dynamic>, 'id': doc.id});
      }).toList();

      dataSource = UsersDataTable(users, selectUser);
      
      // Update pagination flags
      if (isInitialLoad) {
        hasNext = snapshot.docs.length == pageSize;
        hasPrevious = false;
      } else {
        hasNext = !isPrevious && snapshot.docs.length == pageSize;
        hasPrevious = isPrevious || _documentSnapshots.isNotEmpty;
      }
    } else {
      users = [];
      hasNext = false;
      hasPrevious = _documentSnapshots.isNotEmpty;
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch users: ${e.toString()}');
  } finally {
    isLoading = false;
    update();
  }
}

Future<void> fetchNextUsers() async {
  await fetchUsers(isInitialLoad: false, isPrevious: false);
}

Future<void> fetchPreviousUsers() async {
  await fetchUsers(isInitialLoad: false, isPrevious: true);
}

      RxInt totalUsers = 0.obs;
      RxInt premiumUsers = 0.obs;
      RxInt proUsers = 0.obs;
      RxInt basicUsers = 0.obs;
      RxInt freeUsers = 0.obs;
      RxInt blockedUsers = 0.obs;

      void listenToTotalUserUpdates() {
        FirebaseFirestore.instance
            .collection('users')
            .snapshots()
            .listen((snapshot) {
          totalUsers.value = snapshot.docs.length;
          proUsers.value = snapshot.docs
              .where((doc) => doc['subscription'] == 'Pro')
              .length;
          basicUsers.value = snapshot.docs
              .where((doc) => doc['subscription'] == 'Basic')
              .length;    
          premiumUsers.value = snapshot.docs
              .where((doc) => doc['subscription'] == 'Premium')
              .length;
          freeUsers.value =
              snapshot.docs.where((doc) => doc['subscription'] == 'Free').length;
        });
      }
    }
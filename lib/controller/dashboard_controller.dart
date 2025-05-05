import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController extends GetxController {
  RxInt totalUsers = 0.obs;
  RxInt premiumUsers = 0.obs;
  RxInt freeUsers = 0.obs;
  RxInt blockedUsers = 0.obs;

  @override
  void onInit() {
    super.onInit();
    listenToTotalUserUpdates();
  }

  void listenToTotalUserUpdates() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshot) {
      totalUsers.value = snapshot.docs.length;
  
      premiumUsers.value = snapshot.docs
          .where((doc) => doc['subscription'] == 'Premium')
          .length;
      freeUsers.value =
          snapshot.docs.where((doc) => doc['subscription'] == 'Free').length;
      // blockedUsers.value =
      //     snapshot.docs.where((doc) => doc['status'] == 'blocked').length;
    });
  }
}

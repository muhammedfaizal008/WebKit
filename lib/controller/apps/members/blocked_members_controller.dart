import 'package:get/get.dart';
import 'package:webkit/models/user_model.dart';

class BlockedMembersController extends GetxController {
  final users = <UserModel>[].obs;
  final isLoading = false.obs;
  final currentPage = 0.obs;
  final rowsPerPage = 10.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBlockedUsers();
  }

  Future<void> fetchBlockedUsers() async {
    try {
      isLoading(true);
      // In a real app, you would fetch blocked users from Firestore
      // For now, we'll just return an empty list
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay
      users.assignAll([]); // Empty list for blocked users
      isLoading(false);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch blocked users");
    } finally {
      isLoading(false);
    }
  }

  // Pagination methods
  int get totalPages => (users.length / rowsPerPage.value).ceil();
  int get currentPageStartIndex => currentPage.value * rowsPerPage.value;
  int get currentPageEndIndex => (currentPage.value + 1) * rowsPerPage.value > users.length
      ? users.length
      : (currentPage.value + 1) * rowsPerPage.value;

  void onRowsPerPageChanged(int value) {
    rowsPerPage.value = value;
    currentPage.value = 0;
  }

  void goToPage(int page) {
    currentPage.value = page;
  }

  void refreshCurrentPage() {
    fetchBlockedUsers();
  }
}
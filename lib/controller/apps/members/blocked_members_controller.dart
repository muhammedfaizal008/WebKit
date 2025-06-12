import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webkit/models/user_model.dart';

class BlockedMembersController extends GetxController {
  RxBool isLoading = false.obs;
  List<UserModel> users = [];
  bool isfilteredExpanded=true;
  // bool isloading =false;
  // late UsersDataTable dataSource;

  // Pagination controls
  int rowsPerPage = 4;
  int currentPage = 0;
  int totalRecords = 0;

  // Improved cursor management
  DocumentSnapshot? _lastDocumentFetched;
  final Map<int, DocumentSnapshot> _pageStartCursors = {};
  bool _hasMorePages = true;
  bool _totalCountFetched = false;

  UserModel? selectedUser;
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  String? selectedStatus;

  @override
  void onInit() {
    super.onInit();
    fetchBlockedUsers();
    refreshCurrentPage();
  }
  void changeExpanded(){
    isfilteredExpanded=!isfilteredExpanded;
    update();
  }
  /// Fetch total count only once
      Future<void> _fetchTotalCount() async {
        if (_totalCountFetched) return;
        
        try {
          final countQuery = await FirebaseFirestore.instance
              .collection('users')
              .where('status', isEqualTo: 'blocked')
              .count()
              .get();
          totalRecords = countQuery.count ?? 0;
          _totalCountFetched = true;
          print('Total records fetched: $totalRecords');
        } catch (e) {
          print('Error fetching total count: $e');
          totalRecords = 0;
        }
      }

  /// Main fetch method with proper pagination
      Future<void> fetchBlockedUsers({int page = 0}) async {
        // if (isLoading) return;

        try {
          isLoading = true.obs;
          update();

          print('Fetching users for page: $page, current page: $currentPage');

          // Fetch total count if not already done
          await _fetchTotalCount();

          // Validate page request
          if (page < 0) {
            print('Invalid page request: $page');
            return;
          }

          QuerySnapshot<Map<String, dynamic>> snapshot;
          
          if (page == 0) {
            // First page - always start fresh
            print('Fetching first page');
            snapshot = await _fetchFirstPage();
          } else if (page > currentPage) {
            // Forward navigation - fetch next page(s)
            print('Forward navigation from $currentPage to $page');
            snapshot = await _fetchForwardPage(page);
          } else if (page < currentPage) {
            // Backward navigation - use stored cursor
            print('Backward navigation from $currentPage to $page');
            snapshot = await _fetchBackwardPage(page);
          } else {
            // Same page - refresh current data
            print('Refreshing current page $page');
            snapshot = await _refreshCurrentPage(page);
          }

          if (snapshot.docs.isEmpty) {
            print('No data found for page $page');
            _hasMorePages = false;
            return;
          }

          // Update users list
          users.clear();
          users.addAll(snapshot.docs.map((doc) {
            return UserModel.fromMap({
              ...doc.data(),
              'id': doc.id,
            });
          }).toList());

          // Update pagination state
          _updatePaginationState(page, snapshot);
          
          // Update the data source
          _updateDataSource();
          
          print('Successfully fetched page $page with ${users.length} users');

        } catch (e, st) {
          // print('Error fetching users for page $page', error: e, stackTrace: st);
          Get.snackbar('Error', 'Failed to fetch users: ${e.toString()}');
        } finally {
          isLoading = false.obs;
          update();
        }
      }
  /// Fetch first page
      Future<QuerySnapshot<Map<String, dynamic>>> _fetchFirstPage() async {
        // Don't clear all cursors, just reset the navigation state
        _lastDocumentFetched = null;
        _hasMorePages = true;

        final query = FirebaseFirestore.instance
            .collection('users')
            .where('status', isEqualTo: 'blocked')
            .orderBy('fullName')
            .limit(rowsPerPage);

        final snapshot = await query.get();
        
        
        // Always store page 0 cursor
        if (snapshot.docs.isNotEmpty) {
          _pageStartCursors[0] = snapshot.docs.first;
          print('Stored cursor for page 0');
        }
        
        return snapshot;
      }

      /// Handle forward navigation (including jumping multiple pages)
      Future<QuerySnapshot<Map<String, dynamic>>> _fetchForwardPage(int targetPage) async {
        QuerySnapshot<Map<String, dynamic>> snapshot;
        
        // If we're going to the immediate next page and have the cursor
        if (targetPage == currentPage + 1 && _lastDocumentFetched != null) {
          print('Fetching immediate next page with cursor');
          snapshot = await _fetchNextPageWithCursor();
        } else {
          // For jumping multiple pages or when cursor is missing, 
          // we need to navigate sequentially
          print('Sequential navigation to page $targetPage from $currentPage');
          snapshot = await _fetchPageSequentially(targetPage);
        }
        
        return snapshot;
      }

      /// Fetch next page using cursor
      Future<QuerySnapshot<Map<String, dynamic>>> _fetchNextPageWithCursor() async {
        if (_lastDocumentFetched == null) {
          throw Exception('No cursor available for next page');
        }

        final query = FirebaseFirestore.instance
            .collection('users')
            .where('status', isEqualTo: 'blocked')
            .orderBy('fullName')
            .startAfterDocument(_lastDocumentFetched!)
            .limit(rowsPerPage);

        return await query.get();
      }

      /// Fetch page sequentially (for jumping pages)
      Future<QuerySnapshot<Map<String, dynamic>>> _fetchPageSequentially(int targetPage) async {
        // Calculate how many records to skip
        final skipCount = targetPage * rowsPerPage;
        
        // This is not ideal with Firestore, but necessary for jumping pages
        // In a real-world scenario, you might want to implement server-side pagination
        
        final query = FirebaseFirestore.instance
            .collection('users')
            .where('status', isEqualTo: 'blocked')
            .orderBy('fullName')
            .limit(skipCount + rowsPerPage);
        
        final allDocs = await query.get();
        
        // Take only the documents for the target page
        final startIndex = skipCount;
        final endIndex = startIndex + rowsPerPage;
        final pageDocuments = allDocs.docs.skip(startIndex).take(rowsPerPage).toList();
        
        // Create a mock QuerySnapshot with just the page documents
        // Note: This is a workaround - in production, consider using offset-based pagination
        // or implement server-side pagination functions
        
        if (pageDocuments.isEmpty) {
          throw Exception('No documents found for page $targetPage');
        }
        
        // Store cursor for this page if not already stored
        if (!_pageStartCursors.containsKey(targetPage)) {
          _pageStartCursors[targetPage] = pageDocuments.first;
        }
        
        // Return the original snapshot but we'll only use the filtered documents
        // Return filtered documents
        return FirebaseFirestore.instance
            .collection('users')
            .where('status', isEqualTo: 'blocked')
            .orderBy('fullName')
            .startAtDocument(pageDocuments.first)
            .limit(rowsPerPage)
            .get();

      }

      /// Handle backward navigation
      Future<QuerySnapshot<Map<String, dynamic>>> _fetchBackwardPage(int targetPage) async {
        if (targetPage == 0) {
          print('Navigating back to page 0');
          return await _fetchFirstPage();
        }

        final cursor = _pageStartCursors[targetPage];
        if (cursor == null) {
          print('No cursor for page $targetPage, fetching sequentially');
          return await _fetchPageSequentially(targetPage);
        }

        final query = FirebaseFirestore.instance
            .collection('users')
            .where('status', isEqualTo: 'blocked')
            .orderBy('fullName')
            .startAtDocument(cursor)
            .limit(rowsPerPage);

        return await query.get();
      }

      /// Refresh current page
      Future<QuerySnapshot<Map<String, dynamic>>> _refreshCurrentPage(int page) async {
        if (page == 0) {
          return await _fetchFirstPage();
        }
        
        final cursor = _pageStartCursors[page];
        if (cursor != null) {
          final query = FirebaseFirestore.instance
              .collection('users')
              .where('status', isEqualTo: 'blocked')
              .orderBy('fullName')
              .startAtDocument(cursor)
              .limit(rowsPerPage);
          return await query.get();
        } else {
          return await _fetchPageSequentially(page);
        }
      }
    /// Update pagination state after successful fetch
      void _updatePaginationState(int page, QuerySnapshot<Map<String, dynamic>> snapshot) {
        currentPage = page;
        
        // Handle special case for sequential fetching
        if (page > 0 && snapshot.docs.length > rowsPerPage) {
          // We fetched more documents than needed for sequential navigation
          final startIndex = page * rowsPerPage;
          final pageDocuments = snapshot.docs.skip(startIndex).take(rowsPerPage).toList();
          _lastDocumentFetched = pageDocuments.isNotEmpty ? pageDocuments.last : null;
          
          // Store cursor for next potential page
          if (pageDocuments.isNotEmpty && !_pageStartCursors.containsKey(page)) {
            _pageStartCursors[page] = pageDocuments.first;
          }
        } else {
          // Normal case
          _lastDocumentFetched = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
          
          // Store cursor for this page if not already stored
          if (snapshot.docs.isNotEmpty && !_pageStartCursors.containsKey(page)) {
            _pageStartCursors[page] = snapshot.docs.first;
            print('Stored cursor for page $page');
          }
        }

        // Check if there are more pages
        _hasMorePages = ((page + 1) * rowsPerPage) < totalRecords;
        
        print('Updated pagination state: page=$page, hasMore=$_hasMorePages, cursors=${_pageStartCursors.keys}');
      }

      /// Update the data source
      void _updateDataSource() {
        // dataSource = UsersDataTable(users, selectUser, this);
        print('DataSource updated with ${users.length} users for page $currentPage');
      }

      /// Handle page change - FIXED VERSION
      void onPageChanged(int page) {
        print('Page change requested: $currentPage -> $page');
        
        // Validate page bounds
        final maxPage = totalRecords > 0 ? ((totalRecords - 1) / rowsPerPage).floor() : 0;
        if (page < 0 || page > maxPage) {
          print('Invalid page $page (max: $maxPage) - ignoring');
          return;
        }
        
        if (page != currentPage) {
          fetchBlockedUsers(page: page);

        }
      }
     /// Handle rows per page change
      @override
      void onRowsPerPageChanged(int? newRowsPerPage) {
        if (newRowsPerPage != null && newRowsPerPage != rowsPerPage) {
          log('Rows per page changed: $rowsPerPage -> $newRowsPerPage');
          rowsPerPage = newRowsPerPage;
          
          // Reset pagination state
          _pageStartCursors.clear();
          _lastDocumentFetched = null;
          currentPage = 0;
          
          // Refetch from first page
          fetchBlockedUsers(page: 0);
        }
      }

      /// Navigation helper methods
      void goToFirstPage() {
        if (currentPage != 0) {
          onPageChanged(0);
        }
      }
      
      void goToPreviousPage() {
        if (currentPage > 0) {
          onPageChanged(currentPage - 1);
        }
      }
      
      void goToNextPage() {
        final totalPages = (totalRecords / rowsPerPage).ceil();
        if (currentPage < totalPages - 1) {
          onPageChanged(currentPage + 1);
        }
      }
      
      void goToLastPage() {
        final totalPages = (totalRecords / rowsPerPage).ceil();
        final lastPage = totalPages - 1;
        if (currentPage != lastPage && lastPage >= 0) {
          onPageChanged(lastPage);
        }
      }
      
      void goToPage(int page) {
        final totalPages = (totalRecords / rowsPerPage).ceil();
        if (page >= 0 && page < totalPages && page != currentPage) {
          onPageChanged(page);
        }
      }

      /// Getters for pagination state
      bool get canGoToPrevious => currentPage > 0;
      bool get canGoToNext => (currentPage + 1) * rowsPerPage < totalRecords;
      int get totalPages => (totalRecords / rowsPerPage).ceil().clamp(1, double.infinity).toInt();
      int get currentPageStartIndex => (currentPage * rowsPerPage) + 1;
      int get currentPageEndIndex => ((currentPage + 1) * rowsPerPage).clamp(0, totalRecords);
      
      /// Get current page info for debugging
      String get paginationInfo {
        return 'Page ${currentPage + 1} of $totalPages, showing $currentPageStartIndex-$currentPageEndIndex of $totalRecords';
      }
      /// Refresh current page
      Future<void> refreshCurrentPage() async {
        print('Refreshing current page: $currentPage');
        await fetchBlockedUsers(page: currentPage);
      }

      /// Reset pagination to first page
      Future<void> resetToFirstPage() async {
        print('Resetting to first page');
        _pageStartCursors.clear();
        _lastDocumentFetched = null;
        currentPage = 0;

        _totalCountFetched = false; // force recount
        users.clear();
        update();

        await fetchBlockedUsers(page: 0);
      }


      @override
      void onClose() {
        _pageStartCursors.clear();
        users.clear();
        super.onClose();
      }
void deleteUser(UserModel user) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(user.id)
      .delete()
      .then((_) {
    Get.snackbar("Success", "User deleted successfully");
    // Clear pagination and refetch from first page
    resetToFirstPage(); 
    update(); 
  }).catchError(
      (error) => Get.snackbar("Error", "Failed to delete user: $error"));
}

void unblockUser(UserModel user) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update({'status': 'active'});

    Get.snackbar("Success", "User has been unblocked");

    // Remove user from current list (optional but gives instant feedback)
    users.removeWhere((u) => u.id == user.id);
    update(); // Reflect UI changes instantly

    // Clean up and fetch again to ensure consistent state
    _pageStartCursors.clear();
    _lastDocumentFetched = null;
    _totalCountFetched = false;
    await fetchBlockedUsers(page: currentPage);
  } catch (e) {
    Get.snackbar("Error", "Failed to unblock user: $e");
  }
}
  



    bool isFilteredLoading=false;
    List<UserModel> filteredUsers = [];
    bool isFilteredView = false; // To track which data to display
    // Filtered pagination controls
    int filteredRowsPerPage = 4;
    int filteredCurrentPage = 0;
    int filteredTotalRecords = 0;
    DocumentSnapshot? _lastFilteredDocument;
    final Map<int, DocumentSnapshot> _filteredPageCursors = {};
    bool _hasMoreFilteredPages = true;

    void onStatusChanged(String? value) {
      selectedStatus = value ?? '';
    }
    
  bool get canGoToPreviousFiltered => filteredCurrentPage > 0;
  bool get canGoToNextFiltered => 
      (filteredCurrentPage + 1) * filteredRowsPerPage < filteredTotalRecords;
  int get filteredTotalPages => 
      (filteredTotalRecords / filteredRowsPerPage).ceil().clamp(1, double.infinity).toInt();

  void goToNextFilteredPage() {
    if (canGoToNextFiltered) {
      fetchFilteredUsers(page: filteredCurrentPage + 1);
    }
  }

  void goToPreviousFilteredPage() {
    if (canGoToPreviousFiltered) {    
      fetchFilteredUsers(page: filteredCurrentPage - 1);
    }
  }

  void resetFilters2() {
    isFilteredView = false;
    _filteredPageCursors.clear();
    _lastFilteredDocument = null;
    filteredCurrentPage = 0;
    update();
  }


      Future<void> fetchFilteredUsers({int page = 0}) async {
      String? fullName = nameController.text.trim();
      String? phone = phoneController.text.trim();
      String? email = emailController.text.trim();
      String? status = selectedStatus;
      try {
        isFilteredView = true;
        isFilteredLoading = true;
        update();

        /// ---------------------- Count Query --------------------------
        Query countQuery = FirebaseFirestore.instance.collection('users');

          if (fullName.isNotEmpty) {
            final prefix = fullName.toLowerCase();
            final endPrefix = prefix + '\uf8ff';

            countQuery = countQuery
            .orderBy('fullName' ).where("status",isEqualTo: "blocked")
            .where('fullName', isGreaterThanOrEqualTo: prefix)
            .where('fullName', isLessThan: endPrefix);
          }

          // if (phone.isNotEmpty) countQuery = countQuery.where('phoneNumber', isEqualTo: "+91$phone");
          if (phone.isNotEmpty) {
        final prefix = "+91$phone";
        final endPrefix = prefix + '\uf8ff'; // Firestore safe upper bound for string prefix

        countQuery = countQuery
          .orderBy('phoneNumber').where("status",isEqualTo: "blocked")
                  .where('phoneNumber', isGreaterThanOrEqualTo: prefix)
                  .where('phoneNumber', isLessThanOrEqualTo: endPrefix);
      }

          if (email.isNotEmpty) {
            final prefix = email.toLowerCase();
            final endPrefix = prefix + '\uf8ff';

            countQuery = countQuery
            .orderBy('email').where("status",isEqualTo: "blocked")
            .where('email', isGreaterThanOrEqualTo: prefix)
            .where('email', isLessThan: endPrefix);
          }
        if (status != null) countQuery = countQuery.where('status', isEqualTo: status);


        final countSnapshot = await countQuery.count().get();
        filteredTotalRecords = countSnapshot.count ?? 0;

        /// ---------------------- Paginated Query --------------------------
        Query query = FirebaseFirestore.instance.collection('users');

        if (fullName.isNotEmpty) {
          final prefix = fullName.toLowerCase();
          final endPrefix = prefix + '\uf8ff';

              query = query
              .orderBy('fullName').where("status",isEqualTo: "blocked")
              .where('fullName', isGreaterThanOrEqualTo: prefix)
              .where('fullName', isLessThan: endPrefix);

            }

        if (phone.isNotEmpty) {
          final prefix = "+91$phone";
          final endPrefix = prefix + '\uf8ff'; // Firestore safe upper bound for string prefix

              query = query
                .orderBy('phoneNumber').where("status",isEqualTo: "blocked")
                .where('phoneNumber', isGreaterThanOrEqualTo: prefix)
                .where('phoneNumber', isLessThanOrEqualTo: endPrefix);
        }

        if (email.isNotEmpty) {
          final prefix = email.toLowerCase();
          final endPrefix = prefix + '\uf8ff';

          query = query
          .orderBy('email').where("status",isEqualTo: "blocked")
          .where('email', isGreaterThanOrEqualTo: prefix)
          .where('email', isLessThan: endPrefix);
        }
        if (status != null) query = query.where('status', isEqualTo: status);

        query = query.limit(filteredRowsPerPage);

        /// ---------------------- Pagination Cursor --------------------------
        if (page > 0) {
          final cursor = _filteredPageCursors[page];
          if (cursor != null) {
            query = query.startAfterDocument(cursor);
          }
        }

        final snapshot = await query.get();

        filteredUsers = snapshot.docs.map((doc) {
          return UserModel.fromMap({...doc.data() as Map<String, dynamic>, 'id': doc.id});
        }).toList();

        /// ---------------------- Cursor Updates --------------------------
        if (snapshot.docs.isNotEmpty) {
          if (page == 0) {
            _filteredPageCursors[1] = snapshot.docs.last;
          } else {
            _filteredPageCursors[page + 1] = snapshot.docs.last;
            _filteredPageCursors.putIfAbsent(page, () => snapshot.docs.first);
          }
          _lastFilteredDocument = snapshot.docs.last;
        }

        filteredCurrentPage = page;
      } catch (e) {
        print('Filtered fetch error: $e');
      } finally {
        isFilteredLoading = false;
        update();
      }
    }



void resetFilters() {
  selectedStatus = null;
  nameController.text="";
  emailController.text="";
  phoneController.text="";
  fetchBlockedUsers(page: 0); 
}

    
}
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:webkit/models/user_model.dart';

class BlockedMembersController extends GetxController {
  final isLoading = false.obs;
  List<UserModel> users = [];
  bool isloading =false;
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

  @override
  void onInit() {
    super.onInit();
    fetchBlockedUsers(page: 0);
 
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
        if (isloading) return;

        try {
          isloading = true;
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
          isloading = false;
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
        fetchBlockedUsers(page: currentPage);
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


    
}
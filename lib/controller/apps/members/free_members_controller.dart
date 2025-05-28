  import 'dart:developer';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:get/get.dart';
  import 'package:webkit/controller/my_controller.dart';
  import 'package:webkit/models/user_model.dart';

  class FreeMembersController extends MyController {
    final List<UserModel> users = [];
    // late UsersDataTable dataSource;

    // Pagination controls
    int rowsPerPage = 4;
    int currentPage = 0;
    int totalRecords = 0;
    bool isLoading = false;

    // Improved cursor management
    DocumentSnapshot? _lastDocumentFetched;
    final Map<int, DocumentSnapshot> _pageStartCursors = {};
    bool _hasMorePages = true;
    bool _totalCountFetched = false;

    UserModel? selectedUser;

    final RxInt totalUsers = 0.obs;
    final RxInt premiumUsers = 0.obs;
    final RxInt proUsers = 0.obs;
    final RxInt basicUsers = 0.obs;
    final RxInt freeUsers = 0.obs;
    final RxInt blockedUsers = 0.obs;

    @override
    void onInit() {
      super.onInit();
      // dataSource = UsersDataTable(users, selectUser, this);
      fetchUsers(page: 0);
      listenToSubscriptionCounts();
    }

    void selectUser(UserModel user) {
      selectedUser = user;
    }

    /// Fetch total count only once
    Future<void> _fetchTotalCount() async {
      if (_totalCountFetched) return;
      
      try {
        final countQuery = await FirebaseFirestore.instance
            .collection('users')
            .count()
            .get();
        totalRecords = countQuery.count ?? 0;
        _totalCountFetched = true;
        log('Total records fetched: $totalRecords');
      } catch (e) {
        log('Error fetching total count: $e');
        totalRecords = 0;
      }
    }

    /// Main fetch method with proper pagination
    Future<void> fetchUsers({int page = 0}) async {
      if (isLoading) return;

      try {
        isLoading = true;
        update();

        log('Fetching users for page: $page, current page: $currentPage');

        // Fetch total count if not already done
        await _fetchTotalCount();

        // Validate page request
        if (page < 0) {
          log('Invalid page request: $page');
          return;
        }

        QuerySnapshot<Map<String, dynamic>> snapshot;
        
        if (page == 0) {
          // First page - always start fresh
          log('Fetching first page');
          snapshot = await _fetchFirstPage();
        } else if (page > currentPage) {
          // Forward navigation - fetch next page(s)
          log('Forward navigation from $currentPage to $page');
          snapshot = await _fetchForwardPage(page);
        } else if (page < currentPage) {
          // Backward navigation - use stored cursor
          log('Backward navigation from $currentPage to $page');
          snapshot = await _fetchBackwardPage(page);
        } else {
          // Same page - refresh current data
          log('Refreshing current page $page');
          snapshot = await _refreshCurrentPage(page);
        }

        if (snapshot.docs.isEmpty) {
          log('No data found for page $page');
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
        
        log('Successfully fetched page $page with ${users.length} users');

      } catch (e, st) {
        log('Error fetching users for page $page', error: e, stackTrace: st);
        Get.snackbar('Error', 'Failed to fetch users: ${e.toString()}');
      } finally {
        isLoading = false;
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
          .orderBy('fullName')
          .limit(rowsPerPage);

      final snapshot = await query.get();
      
      // Always store page 0 cursor
      if (snapshot.docs.isNotEmpty) {
        _pageStartCursors[0] = snapshot.docs.first;
        log('Stored cursor for page 0');
      }
      
      return snapshot;
    }

    /// Handle forward navigation (including jumping multiple pages)
    Future<QuerySnapshot<Map<String, dynamic>>> _fetchForwardPage(int targetPage) async {
      QuerySnapshot<Map<String, dynamic>> snapshot;
      
      // If we're going to the immediate next page and have the cursor
      if (targetPage == currentPage + 1 && _lastDocumentFetched != null) {
        log('Fetching immediate next page with cursor');
        snapshot = await _fetchNextPageWithCursor();
      } else {
        // For jumping multiple pages or when cursor is missing, 
        // we need to navigate sequentially
        log('Sequential navigation to page $targetPage from $currentPage');
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
      return allDocs;
    }

    /// Handle backward navigation
    Future<QuerySnapshot<Map<String, dynamic>>> _fetchBackwardPage(int targetPage) async {
      if (targetPage == 0) {
        log('Navigating back to page 0');
        return await _fetchFirstPage();
      }

      final cursor = _pageStartCursors[targetPage];
      if (cursor == null) {
        log('No cursor for page $targetPage, fetching sequentially');
        return await _fetchPageSequentially(targetPage);
      }

      final query = FirebaseFirestore.instance
          .collection('users')
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
          log('Stored cursor for page $page');
        }
      }

      // Check if there are more pages
      _hasMorePages = ((page + 1) * rowsPerPage) < totalRecords;
      
      log('Updated pagination state: page=$page, hasMore=$_hasMorePages, cursors=${_pageStartCursors.keys}');
    }

    /// Update the data source
    void _updateDataSource() {
      // dataSource = UsersDataTable(users, selectUser, this);
      log('DataSource updated with ${users.length} users for page $currentPage');
    }

    /// Handle page change - FIXED VERSION
    void onPageChanged(int page) {
      log('Page change requested: $currentPage -> $page');
      
      // Validate page bounds
      final maxPage = totalRecords > 0 ? ((totalRecords - 1) / rowsPerPage).floor() : 0;
      if (page < 0 || page > maxPage) {
        log('Invalid page $page (max: $maxPage) - ignoring');
        return;
      }
      
      if (page != currentPage) {
        fetchUsers(page: page);
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
        fetchUsers(page: 0);
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

    /// Listen to live subscription count changes
    void listenToSubscriptionCounts() {
      FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
        final docs = snapshot.docs;
        totalUsers.value = docs.length;
        proUsers.value = docs.where((doc) => doc.data()['subscription'] == 'Pro').length;
        basicUsers.value = docs.where((doc) => doc.data()['subscription'] == 'Basic').length;
        premiumUsers.value = docs.where((doc) => doc.data()['subscription'] == 'Premium').length;
        freeUsers.value = docs.where((doc) => doc.data()['subscription'] == 'Free'||doc.data()['subscription'] == null).length;
        
        // Update total count if it has changed significantly
        if ((docs.length - totalRecords).abs() > 5 && _totalCountFetched) {
          log('Total count changed significantly: $totalRecords -> ${docs.length}');
          totalRecords = docs.length;
          update();
        }
      });
    }

    /// Refresh current page
    Future<void> refreshCurrentPage() async {
      log('Refreshing current page: $currentPage');
      await fetchUsers(page: currentPage);
    }

    /// Reset pagination to first page
    Future<void> resetToFirstPage() async {
      log('Resetting to first page');
      _pageStartCursors.clear();
      _lastDocumentFetched = null;
      currentPage = 0;
      await fetchUsers(page: 0);
    }

    @override
    void onClose() {
      _pageStartCursors.clear();
      users.clear();
      super.onClose();
    }

  final RxString _searchQuery = ''.obs;
  final RxList<UserModel> _allUsers = <UserModel>[].obs;
  final RxList<UserModel> _filteredUsers = <UserModel>[].obs;
  final RxBool _isSearching = false.obs;

  // Getters for search state
  String get searchQuery => _searchQuery.value;
  // List<UserModel> get filteredUsers => _filteredUsers;
  bool get isSearching => _isSearching.value;

    List<UserModel> get filteredUsers => users.where((user) {
      return user.fullName.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    // In your FreeMembersController
Future<void> performServerSideSearch(String query) async {
  try {
    _isSearching.value = true;
    update();

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('fullName', isGreaterThanOrEqualTo: query)
        .where('fullName', isLessThan: query + 'z')
        .limit(50)
        .get();

    _filteredUsers.assignAll(snapshot.docs.map((doc) {
      return UserModel.fromMap({
        ...doc.data(),
        'id': doc.id,
      });
    }).toList());

  } catch (e) {
    Get.snackbar("Error", "Search failed: ${e.toString()}");
  } finally {
    _isSearching.value = false;
    update();
  }
}

// Update your setSearchQuery method
void setSearchQuery(String query) {
  _searchQuery.value = query.trim();
  _isSearching.value = query.isNotEmpty;
  if (query.length > 2) { // Only search after 3 characters
    performServerSideSearch(query);
  } else if (query.isEmpty) {
    _filteredUsers.assignAll(_allUsers);
  }
}
  }
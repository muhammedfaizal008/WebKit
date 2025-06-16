  import 'dart:developer';
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
  import 'package:get/get.dart';
import 'package:webkit/controller/apps/members/edit_members_controller/edit_members_controller.dart';
  import 'package:webkit/controller/my_controller.dart';
  import 'package:webkit/models/user_model.dart';

  class FreeMembersController extends MyController {
      List<UserModel> users = [];
      EditMembersController editMembersController=EditMembersController();
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      bool isfilteredExpanded=true;
      List<String> castes=<String>[].obs;
      final religions=<String>[].obs;

      // Pagination controls
      int rowsPerPage = 4;
      int currentPage = 0;
      int totalRecords = 0;
      final isLoading = false.obs;
      final loadingFilters=false.obs;

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
      void changeExpanded(){
        isfilteredExpanded=!isfilteredExpanded;
        update();
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

        try {
          isLoading(true);
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
          isLoading(false);
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
          blockedUsers.value = docs.where((doc) => doc.data()['status']?.toLowerCase() == 'blocked').length;
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

    TextEditingController nameController=TextEditingController();
    TextEditingController phoneController=TextEditingController();
    TextEditingController emailController=TextEditingController();
    TextEditingController createdFromDateController=TextEditingController();
    TextEditingController createdTillController=TextEditingController();
    Timestamp? createdFromDate;
    Timestamp? createdTillDate;
    String? selectedReligion;
    String? selectedCaste;
    String? selectedCountry;
    String? selectedSubscription;
    String? selectedStatus;
    String? selectedGender;
    String? selectedMotherTongue;
    List<String> casteList = [];
    int? ageFrom;
    int? ageTo;
    TextEditingController ageFromController=TextEditingController();
    TextEditingController ageToController=TextEditingController();
    String? selectedAnnualIncome;
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
    
    void onIncomeChanged(String? value) {
      selectedAnnualIncome = value ?? '';
    }
    void onGenderChanged(String? value) {
      selectedGender = value ?? '';
    }
    Future<void> onReligionChanged(String? value) async {
      selectedReligion = value ?? '';
      await fetchCastesForReligion(value!);
      print("Fetched castes: ${castes.toList()}");
      update();
    }
    void onCasteChanged(String? value) {
      selectedCaste= value ?? '';
    }
    void onSubscriptionChanged(String? value) {
      selectedSubscription = value ?? '';
    }
    void onCountryChanged(String? value) {
      selectedCountry = value ?? '';
    }
    void onStatusChanged(String? value) {
      selectedStatus = value ?? '';
    }
    void onMotherTongueChanged(String? value) {
      selectedMotherTongue = value ?? '';
    }
    // Getters for filtered pagination
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
      String? religion = selectedReligion;
      String? caste = selectedCaste;
      String? country = selectedCountry;
      String? subscription = selectedSubscription;
      String? status = selectedStatus?.toLowerCase();
      String? annualIncome = selectedAnnualIncome;
      String? gender = selectedGender;
      String? ageFrom = ageFromController.text.trim();
      String? ageTo = ageToController.text.trim();
      Timestamp? createdFrom = createdFromDate;
      Timestamp? createdTill = createdTillDate;
      String? motherTongue = selectedMotherTongue;

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
            .orderBy('fullName' )
            .where('fullName', isGreaterThanOrEqualTo: prefix)
            .where('fullName', isLessThan: endPrefix);
          }

          // if (phone.isNotEmpty) countQuery = countQuery.where('phoneNumber', isEqualTo: "+91$phone");
          if (phone.isNotEmpty) {
        final prefix = "+91$phone";
        final endPrefix = prefix + '\uf8ff'; // Firestore safe upper bound for string prefix

        countQuery = countQuery
          .orderBy('phoneNumber')
                  .where('phoneNumber', isGreaterThanOrEqualTo: prefix)
                  .where('phoneNumber', isLessThanOrEqualTo: endPrefix);
      }

          if (email.isNotEmpty) {
            final prefix = email.toLowerCase();
            final endPrefix = prefix + '\uf8ff';

            countQuery = countQuery
            .orderBy('email')
            .where('email', isGreaterThanOrEqualTo: prefix)
            .where('email', isLessThan: endPrefix);
          }
        if (createdFrom != null) countQuery = countQuery.where('createdAt', isGreaterThanOrEqualTo: createdFrom);
        if (createdTill != null) countQuery = countQuery.where('createdAt', isLessThanOrEqualTo: createdTill);
        if (ageTo     .isNotEmpty) countQuery = countQuery.where('age', isGreaterThanOrEqualTo: ageFrom);
        if (ageFrom.isNotEmpty) countQuery = countQuery.where('age', isLessThanOrEqualTo: ageTo);
        if (annualIncome != null) countQuery = countQuery.where('annualIncome', isEqualTo: annualIncome);
        if (gender != null) countQuery = countQuery.where('gender', isEqualTo: gender);
        if (religion != null) countQuery = countQuery.where('religion', isEqualTo: religion);
        if (caste != null) countQuery = countQuery.where('caste', isEqualTo: caste);
        if (country != null) countQuery = countQuery.where('Country', isEqualTo: country);
        if (subscription != null) countQuery = countQuery.where('subscription', isEqualTo: subscription);
        if (status != null) countQuery = countQuery.where('status', isEqualTo: status);
        if (motherTongue != null) countQuery = countQuery.where('language', isEqualTo: motherTongue);

        final countSnapshot = await countQuery.count().get();
        filteredTotalRecords = countSnapshot.count ?? 0;

        /// ---------------------- Paginated Query --------------------------
        Query query = FirebaseFirestore.instance.collection('users');

        if (fullName.isNotEmpty) {
          final prefix = fullName.toLowerCase();
          final endPrefix = prefix + '\uf8ff';

              query = query
              .orderBy('fullName')
              .where('fullName', isGreaterThanOrEqualTo: prefix)
              .where('fullName', isLessThan: endPrefix);

            }

        if (phone.isNotEmpty) {
          final prefix = "+91$phone";
          final endPrefix = prefix + '\uf8ff'; // Firestore safe upper bound for string prefix

              query = query
                .orderBy('phoneNumber')
                .where('phoneNumber', isGreaterThanOrEqualTo: prefix)
                .where('phoneNumber', isLessThanOrEqualTo: endPrefix);
        }

        if (email.isNotEmpty) {
          final prefix = email.toLowerCase();
          final endPrefix = prefix + '\uf8ff';

          query = query
          .orderBy('email')
          .where('email', isGreaterThanOrEqualTo: prefix)
          .where('email', isLessThan: endPrefix);
        }
        if (createdFrom != null) query = query.where('createdAt', isGreaterThanOrEqualTo: createdFrom);
        if (createdTill != null) query = query.where('createdAt', isLessThanOrEqualTo: createdTill);
        if (ageFrom.isNotEmpty) query = query.where('age', isGreaterThanOrEqualTo: ageFrom);
        if (ageFrom.isNotEmpty) query = query.where('age', isLessThanOrEqualTo: ageTo);
        if (annualIncome != null) query = query.where('annualIncome', isEqualTo: annualIncome);
        if (gender != null) query = query.where('gender', isEqualTo: gender);
        if (religion != null) query = query.where('religion', isEqualTo: religion);
        if (caste != null) query = query.where('caste', isEqualTo: caste);
        if (country != null) query = query.where('Country', isEqualTo: country);
        if (subscription != null) query = query.where('subscription', isEqualTo: subscription);
        if (status != null) query = query.where('status', isEqualTo: status);
        if (motherTongue != null) query = query.where('language', isEqualTo: motherTongue);

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
  castes=[];
  selectedReligion = null;
  selectedCaste=null;
  selectedCountry = null;
  selectedSubscription = null;
  selectedStatus = null;
  selectedAnnualIncome=null;
  selectedGender=null;
  ageFromController.text="";
  ageToController.text="";
  nameController.text="";
  emailController.text="";
  phoneController.text="";
  createdFromDate=null;
  createdFromDateController.text="";
  createdTillDate=null;
  createdTillController.text="";
  selectedMotherTongue=null;
  fetchUsers(page: 0); // Reset to initial unfiltered state
}
Future<void> fetchReligion() async {

  try {
    loadingFilters(true);
    update();
    final querySnapshot = await _firestore.collection('Religion').get();
    religions.assignAll(
      querySnapshot.docs
        .where((doc) => doc['isActive'] == true)
        .map((doc) => doc['name'] as String)
        .where((name) => name.isNotEmpty),
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to load Religion data');
  } finally {
    loadingFilters(false);
    update();
  }
}
Future<void> fetchCastesForReligion(String religionName) async {
  
    try {
      loadingFilters(true);
      update();
      final religionDoc = await _firestore
          .collection('Religion')
          .where('name', isEqualTo: religionName)
          .limit(1)
          .get();

      if (religionDoc.docs.isNotEmpty) {
        final religionId = religionDoc.docs.first.id;
        final casteSnapshot = await _firestore
            .collection('Religion')
            .doc(religionId)
            .collection('castes')
            .where('isActive', isEqualTo: true)
            .get();

        castes.assignAll(casteSnapshot.docs
            .map((doc) => doc['name'] as String)
            .where((name) => name.isNotEmpty));
      } else {
        castes.clear();
        Get.snackbar('Info', 'No castes found for this religion');
      }
    } catch (e) {
      print('Error'+ 'Failed to load castes: ${e.toString()}');
      castes.clear();
      Get.snackbar('Error', 'Failed to load castes');
    } finally {
      loadingFilters(false);
      update();
    }
  }
  

  }
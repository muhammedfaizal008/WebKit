import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/auth/login_controller.dart';
import 'package:webkit/models/marital_status_model.dart';
import 'package:webkit/views/apps/CRM/contacts_page.dart';
import 'package:webkit/views/apps/CRM/opportunities.dart';
import 'package:webkit/views/apps/calender.dart';
import 'package:webkit/views/apps/chat_page.dart';
import 'package:webkit/views/apps/contacts/edit_profile.dart';
import 'package:webkit/views/apps/contacts/member_list.dart';
import 'package:webkit/views/apps/contacts/profile.dart';
import 'package:webkit/views/apps/ecommerce/add_product.dart';
import 'package:webkit/views/apps/ecommerce/customers.dart';
import 'package:webkit/views/apps/ecommerce/invoice_page.dart';
import 'package:webkit/views/apps/ecommerce/product_detail.dart';
import 'package:webkit/views/apps/ecommerce/products.dart';
import 'package:webkit/views/apps/file/file_manager.dart';
import 'package:webkit/views/apps/file/file_uploader.dart';
import 'package:webkit/views/apps/fitness/fitness_screen.dart';
import 'package:webkit/views/apps/kanban_page.dart';
import 'package:webkit/views/apps/members/add_member/add_member.dart';
import 'package:webkit/views/apps/members/blocked_members.dart';
import 'package:webkit/views/apps/members/edit_member_details/edit_member_details.dart';
import 'package:webkit/views/apps/members/masters/annual_income.dart';
import 'package:webkit/views/apps/members/masters/caste.dart';
import 'package:webkit/views/apps/members/masters/citizenship.dart';
import 'package:webkit/views/apps/members/masters/country.dart';
import 'package:webkit/views/apps/members/masters/education.dart';
import 'package:webkit/views/apps/members/masters/family_values/family_status.dart';
import 'package:webkit/views/apps/members/masters/family_values/family_type.dart';
import 'package:webkit/views/apps/members/masters/family_values/family_values.dart';
import 'package:webkit/views/apps/members/masters/gender.dart';
import 'package:webkit/views/apps/members/masters/horoscope_match.dart';
import 'package:webkit/views/apps/members/masters/lifestyle/drinking_habits.dart';
import 'package:webkit/views/apps/members/masters/lifestyle/eating_habits.dart';
import 'package:webkit/views/apps/members/masters/lifestyle/smoking_habits.dart';
import 'package:webkit/views/apps/members/masters/marital_status.dart';
import 'package:webkit/views/apps/members/masters/mother_tongue.dart';
import 'package:webkit/views/apps/members/masters/occupation.dart';
import 'package:webkit/views/apps/members/masters/physical_status.dart';
import 'package:webkit/views/apps/members/masters/religion.dart';
import 'package:webkit/views/apps/members/masters/resident_status.dart';
import 'package:webkit/views/apps/members/masters/stars.dart';
import 'package:webkit/views/apps/members/masters/state.dart';
import 'package:webkit/views/apps/members/masters/zodiac_sign.dart';
import 'package:webkit/views/apps/settings_screen.dart';
import 'package:webkit/views/apps/members/free_members.dart';
import 'package:webkit/views/apps/members/premium_members.dart';
import 'package:webkit/views/apps/projects/create_project.dart';
import 'package:webkit/views/apps/projects/project_detail.dart';
import 'package:webkit/views/apps/projects/project_list.dart';
import 'package:webkit/views/apps/shopping_customer/shopping_customer_screen.dart';
import 'package:webkit/views/apps/staffs/all_staff.dart';
import 'package:webkit/views/apps/staffs/staff_roles.dart';
import 'package:webkit/views/auth/forgot_password.dart';
import 'package:webkit/views/auth/forgot_password_2.dart';
import 'package:webkit/views/auth/locked.dart';
import 'package:webkit/views/auth/login.dart';
import 'package:webkit/views/auth/login_2.dart';
import 'package:webkit/views/auth/register.dart';
import 'package:webkit/views/auth/register_2.dart';
import 'package:webkit/views/auth/reset_password.dart';
import 'package:webkit/views/auth/reset_password_2.dart';
import 'package:webkit/views/forms/basic_page.dart';
import 'package:webkit/views/forms/form_mask.dart';
import 'package:webkit/views/forms/quill_editor.dart';
import 'package:webkit/views/forms/validation.dart';
import 'package:webkit/views/forms/wizard.dart';
import 'package:webkit/views/other/basic_table.dart';
import 'package:webkit/views/other/google_map.dart';
import 'package:webkit/views/other/sfmap_page.dart';
import 'package:webkit/views/starter.dart';
import 'package:webkit/views/ui/buttons_page.dart';
import 'package:webkit/views/ui/cards_page.dart';
import 'package:webkit/views/ui/carousels.dart';
import 'package:webkit/views/ui/dialogs.dart';
import 'package:webkit/views/ui/drag_drop.dart';
import 'package:webkit/views/ui/notifications.dart';
import 'package:webkit/views/ui/reviews_page.dart';
import 'package:webkit/views/ui/tabs_page.dart';

import 'views/auth/locked_2.dart';
import 'views/dashboard.dart';
import 'views/error_pages/coming_soon_page.dart';
import 'views/error_pages/error_404.dart';
import 'views/error_pages/error_500.dart';
import 'views/error_pages/maintenance_page.dart';
import 'views/extra_pages/faqs_page.dart';
import 'views/extra_pages/pricing.dart';
import 'views/extra_pages/time_line_page.dart';
import 'views/ui/landing_page.dart';
import 'views/ui/nft_dashboard.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // return AuthService.isLoggedIn ? null : const RouteSettings(name: '/auth/login');
    final user = FirebaseAuth.instance.currentUser;
    // print(user);
    return user != null ? null : const RouteSettings(name: '/auth/login1');
  }
}

getPageRoute() {
  var routes = [
    GetPage(
      name: '/',
      page: () => const DashboardPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(name: '/faqs', page: () => const FaqsPage()),

        ///---------------- user ----------------///

    GetPage(
        name: '/user/free_members',
        page: () => const FreeMembers(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/user/blocked_members',
        page: () => BlockedMembers(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/user/add_member',
        page: () => const AddMember(),
        middlewares: [AuthMiddleware()]),
    GetPage(name: "/user/edit_member", page: () => const EditMemberDetails()),
    GetPage(
        name: '/user/profileAttribute/gender',
        page: () =>  Gender (),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/user/profileAttribute/religion',
        page: () => const Religion(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/caste',
        page: () => Caste(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/mother_tongue',
        page: () => const MotherTongue(),
        middlewares: [AuthMiddleware()]),
      GetPage(
        name: '/user/profileAttribute/marital_status',
        page: () =>    MaritalStatus(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/education',
        page: () =>    Education(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/occupation',
        page: () =>    Occupation(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/zodiac_sign',
        page: () =>    ZodiacSign(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/annual_income',
        page: () =>   AnnualIncome(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/physical_status',
        page: () =>   PhysicalStatus(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/stars',
        page: () =>  Stars(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/country',
        page: () =>  Country(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/state',
        page: () =>  States(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/citizenShip',
        page: () =>  Citizenship(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/residentStatus',
        page: () =>  ResidentStatus(),
        middlewares: [AuthMiddleware()]),
            GetPage(
            name: '/user/profileAttribute/eating_habits',
        page: () =>  EatingHabits(),
        middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/user/profileAttribute/drinking_habits',
        page: () =>  DrinkingHabits (),
        middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/user/profileAttribute/smoking_habits',
        page: () =>  SmokingHabits(),
        middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/user/profileAttribute/family_values',   
        page: () =>  FamilyValues(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/family_type',   
        page: () =>  FamilyType(),
        middlewares: [AuthMiddleware()]),
        
        GetPage(
        name: '/user/profileAttribute/family_status',   
        page: () =>  FamilyStatus(),
        middlewares: [AuthMiddleware()]),
        GetPage(
        name: '/user/profileAttribute/horoscope',   
        page: () =>  HoroscopeMatch(),
        middlewares: [AuthMiddleware()]),
          
        



     ///---------------Staff ---------------///
     GetPage(
        name: '/staff/all_staff',
        page: () => const AllStaff(),
        middlewares: [AuthMiddleware()]),
      GetPage(
        name: '/staff/staff_roles',
        page: () => const StaffRoles(),
        middlewares: [AuthMiddleware()]),



     ///--------------- ---------------///

    GetPage(
      name: '/pricing',
      page: () => const Pricing(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
        name: '/starter',
        page: () => const Starter(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard',
        page: () => const DashboardPage(),
        middlewares: [AuthMiddleware()]),

    ///--------------- Ecommerce ---------------///
    GetPage(
        name: '/apps/ecommerce/products',
        page: () => const ProductPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/add_product',
        page: () => const AddProduct(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/product-detail',
        page: () => const ProductDetail(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/customers',
        page: () => const Customers(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/invoice',
        page: () => const InvoicePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/timeline',
        page: () => const TimeLinePage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- File ----------------///

    GetPage(
        name: '/apps/files',
        page: () => const FileManager(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/apps/file-uploader',
        page: () => const FileUploader(),
        middlewares: [AuthMiddleware()]),


    ///---------------- Ntf ----------------///

    GetPage(
        name: '/NFTDashboard',
        page: () => const NFTDashboardScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/calender',
        page: () => const Calender(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/shopping-customer',
        page: () => const ShoppingCustomerScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/fitness',
        page: () => const FitnessScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/settings',
        page: () => const SettingsScreen(),
        middlewares: [AuthMiddleware()]),

    ///---------------- KanBan ----------------///

    GetPage(
        name: '/kanban',
        page: () => const KanBanPage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Projects ----------------///
    GetPage(
        name: '/projects/project-list',
        page: () => const ProjectListPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/projects/project-detail',
        page: () => const ProjectDetail(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/projects/create-project',
        page: () => const CreateProject(),
        middlewares: [AuthMiddleware()]),

    ///---------------- user ----------------///

    GetPage(
        name: '/contacts/profile',
        page: () => const ProfilePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/contacts/members',
        page: () => const MemberList(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/contacts/edit-profile',
        page: () => const EditProfile(),
        middlewares: [AuthMiddleware()]),

    ///---------------- CRM ----------------///

    GetPage(
        name: '/crm/contacts',
        page: () => const ContactsPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/crm/opportunities',
        page: () => const OpportunitiesPage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Auth ----------------///

    GetPage(
      name: '/auth/login',
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),

    GetPage(name: '/auth/login1', page: () =>  Login2()),
    GetPage(name: '/auth/forgot_password', page: () => const ForgotPassword()),
    GetPage(
        name: '/auth/forgot_password1', page: () => const ForgotPassword2()),
    GetPage(name: '/auth/register', page: () => const Register()),
    GetPage(name: '/auth/register1', page: () => const Register2()),
    GetPage(name: '/auth/reset_password', page: () => const ResetPassword()),
    GetPage(name: '/auth/reset_password1', page: () => const ResetPassword2()),
    GetPage(
        name: '/auth/locked',
        page: () => const LockedPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/auth/locked1',
        page: () => const LockedPage2(),
        middlewares: [AuthMiddleware()]),

    ///---------------- UI ----------------///

    GetPage(
        name: '/ui/buttons',
        page: () => const ButtonsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/cards',
        page: () => const CardsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/tabs',
        page: () => const TabsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/dialogs',
        page: () => const Dialogs(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/carousels',
        page: () => const Carousels(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/drag-drop',
        page: () => const DragDropPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/notification',
        page: () => const Notifications(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/reviews',
        page: () => const ReviewsPage(),
        middlewares: [AuthMiddleware()]),
    // GetPage(
    //     name: '/ui/discover',
    //     page: () => const DiscoverJobs(),
    //     middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/landing',
        page: () => const LandingPage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Error ----------------///

    GetPage(
        name: '/coming-soon',
        page: () => const ComingSoonPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/error-404',
        page: () => const Error404(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/error-500',
        page: () => const Error500(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/maintenance',
        page: () => const MaintenancePage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Chat ----------------///

    GetPage(
        name: '/chat',
        page: () => const ChatPage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Form ----------------///

    GetPage(
        name: '/form/basic',
        page: () => const BasicPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/form/validation',
        page: () => const ValidationPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/form/quill-editor',
        page: () => const QuillEditor(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/form/form-mask',
        page: () => const FormMaskPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/form/wizard',
        page: () => const Wizard(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Other ----------------///

    GetPage(
        name: '/other/basic_tables',
        page: () => const BasicTable(),
        middlewares: [AuthMiddleware()]),

    // GetPage(
    //     name: '/other/syncfusion_charts',
    //     page: () => const SyncFusionChart(),
    //     middlewares: [AuthMiddleware()]),
    // GetPage(
    //     name: '/other/fl_chart',
    //     page: () => const FlChartScreen(),
    //     middlewares: [AuthMiddleware()]),

    ///---------------- Maps ----------------///

    GetPage(
        name: '/maps/sf-maps',
        page: () => const SfMapPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/maps/google-maps',
        page: () => const GoogleMapPage(),
        middlewares: [AuthMiddleware()]),
  ];
  return routes
      .map(
        (e) => GetPage(
            name: e.name,
            page: e.page,
            middlewares: e.middlewares,
            transition: Transition.noTransition),
      )
      .toList();
}

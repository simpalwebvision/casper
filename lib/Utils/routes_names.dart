import 'package:caspro_enterprises/Screens/Auth/Login/login_screen.dart';
import 'package:caspro_enterprises/Screens/Auth/Profile/profile_screen.dart';
import 'package:caspro_enterprises/Screens/Type-Admin/Home/admin_home_screen.dart';
import 'package:caspro_enterprises/Screens/Type-Manufacturing-Unit/Home/manufacturing_unit_home_screen.dart';
import 'package:caspro_enterprises/Screens/Type-SuperAdmin/Complaints/Complaints-List/complaints_list.dart';
import 'package:caspro_enterprises/Screens/Type-SuperAdmin/History/history_list.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/Complaints/technician_complaints_list.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/Home/technician_home_screen.dart';
import 'package:caspro_enterprises/Widgets/pdf_viewer_page.dart';
import 'package:get/get.dart';

import '../Screens/Type-SuperAdmin/Employees/Employee-List/employees_list.dart';
import '../Screens/Type-SuperAdmin/Home/super_admin_home_screen.dart';
import '../Screens/splash_screen.dart';

class RouteNames {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";

  //! Super Admin Screen
  static const String superAdminHomeScreen = "/super_admin_home_screen";
  static const String employeesList = "/employees_list";
  static const String complaintsList = "/complaints_list";
  static const String historyList = "/history_list";
  static const String profileScreen = "/profile_screen";
  static const String pdfViewerPage = "/pdf_viewer_page";

  //! Admin Screen
  static const String adminHomeScreen = "/admin_home_screen";

  //! Technician Screen
  static const String technicianHomeScreen = "/technician_home_screen";
  static const String techComplaintsList = "/tech_complaints_list";

  //! Manufacturing Unit Screen
  static const String manufacturingUnitHomeScreen =
      "/manufacturing_unit_screen";
}

class AppRoute {
  static appRoutes() => [
        GetPage(
            name: RouteNames.splashScreen,
            page: () => const SplashScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),
        GetPage(
            name: RouteNames.loginScreen,
            page: () => const LoginScreen(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 500)),

        GetPage(
            name: RouteNames.pdfViewerPage,
            page: () => const PFDViewerPage(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        //! Super Admin Screen
        GetPage(
            name: RouteNames.superAdminHomeScreen,
            page: () => const SuperAdminHomeScreen(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 500)),

        GetPage(
            name: RouteNames.employeesList,
            page: () => const EmployeesList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.complaintsList,
            page: () => const ComplaintsList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.historyList,
            page: () => const HistoryList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.profileScreen,
            page: () => const ProfileScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        //! Admin Screen
        GetPage(
            name: RouteNames.adminHomeScreen,
            page: () => const AdminHomeScreen(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 500)),

        //! Techinician Screen
        GetPage(
            name: RouteNames.technicianHomeScreen,
            page: () => const TechnicianHomeScreen(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 500)),

        GetPage(
            name: RouteNames.techComplaintsList,
            page: () => const TechnicianComplaintsList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 500)),

        //! Admin Screen
        GetPage(
            name: RouteNames.manufacturingUnitHomeScreen,
            page: () => const ManufacturingUnitHomeScreen(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 500)),
      ];
}

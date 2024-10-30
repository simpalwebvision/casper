import 'package:caspro_enterprises/Screens/Auth/Login/login_screen.dart';
import 'package:caspro_enterprises/Screens/Auth/Profile/profile_screen.dart';
import 'package:caspro_enterprises/Screens/Type-Admin/Complaints/Complaints-List/complaints_list.dart';
import 'package:caspro_enterprises/Screens/Type-Admin/History/history_list.dart';
import 'package:caspro_enterprises/Widgets/pdf_viewer_page.dart';
import 'package:get/get.dart';

import '../Screens/Type-Admin/Employees/Employee-List/employees_list.dart';
import '../Screens/Type-Admin/Home/admin_home_screen.dart';
import '../Screens/splash_screen.dart';

class RouteNames {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";

  static const String adminHomeScreen = "/admin_home_screen";
  static const String employeesList = "/employees_list";
  static const String complaintsList = "/complaints_list";
  static const String historyList = "/history_list";
  static const String profileScreen = "/profile_screen";
  static const String pdfViewerPage = "/pdf_viewer_page";
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

        //! Admin Screen
        GetPage(
            name: RouteNames.adminHomeScreen,
            page: () => const AdminHomeScreen(),
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
      ];
}

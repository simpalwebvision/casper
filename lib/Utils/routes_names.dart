import 'package:caspro_enterprises/Screens/Auth/Login/login_screen.dart';
import 'package:caspro_enterprises/Screens/Auth/Profile/TechnicianProfile/tech_profile_screen.dart';
import 'package:caspro_enterprises/Screens/Auth/Profile/Employee-Profile/employee_profile_screen.dart';
import 'package:caspro_enterprises/Screens/Type-Customer/Home/customer_home_screen.dart';
import 'package:caspro_enterprises/Screens/Type-Manufacturing-Unit/Complaint/manufacturing_complaint.dart';
import 'package:caspro_enterprises/Screens/Type-Manufacturing-Unit/Home/manufacturing_unit_home_screen.dart';
import 'package:caspro_enterprises/Screens/Type-Manufacturing-Unit/Upload-Problem-Image/Upload-Image-List/upload_image_list.dart';
import 'package:caspro_enterprises/Screens/Type-SuperAdmin/Complaints/Complaints-List/complaints_list.dart';
import 'package:caspro_enterprises/Screens/Type-SuperAdmin/CustomerList/Create-Customer/create_customer.dart';
import 'package:caspro_enterprises/Screens/Type-SuperAdmin/CustomerList/customer_list.dart';
import 'package:caspro_enterprises/Screens/Type-SuperAdmin/History/history_list.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/Complaints/Add-Complaint/add_complaint.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/Complaints/Complaint-Proceed/complaint_proceed.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/Complaints/technician_complaints_list.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/History/history.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/Home/technician_home_screen.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/Inventory/inventory_list.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/ManageExpense/AddExpense/add_expense.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/ManageExpense/EditExpense/edit_expense.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/ManageExpense/ExpenseList/expense_list.dart';
import 'package:caspro_enterprises/Screens/Type-Technician/Manual/manual_screen.dart';
import 'package:caspro_enterprises/Widgets/pdf_viewer_page.dart';
import 'package:caspro_enterprises/Widgets/photo_view.dart';
import 'package:get/get.dart';

import '../Screens/Type-SuperAdmin/CustomerList/CustomerMachines/customer_machine_list.dart';
import '../Screens/Type-SuperAdmin/Employees/Employee-List/employees_list.dart';
import '../Screens/Type-SuperAdmin/Home/super_admin_home_screen.dart';
import '../Screens/SplashScreen/splash_screen.dart';

class RouteNames {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String photoViewer = "/photo_viewer";
  static const String pdfViewerPageTwo = "/pdf_viewer_page_two";

  //! Super Admin Screen
  static const String superAdminHomeScreen = "/super_admin_home_screen";
  static const String employeesList = "/employees_list";
  static const String complaintsList = "/complaints_list";
  static const String customerMachineList = "/customer_machine_list";
  static const String historyList = "/history_list";
  static const String employeeProfileScreen = "/employee_profile_screen";
  static const String pdfViewerPage = "/pdf_viewer_page";
  //! Customer Screen
  static const String customerList = "/customer_list";
  static const String createCustomerScreen = "/create_customer_screen";

  //! Admin Screen
  static const String customerHomeScreen = "/customer_home_screen";

  //! Technician Screen
  static const String technicianHomeScreen = "/technician_home_screen";
  static const String techComplaintsList = "/tech_complaints_list";
  static const String complaintProceed = "/complaint_proceed";
  static const String historyScreen = "/history_screen";
  static const String expenseList = "/expense_list";
  static const String addExpense = "/add_expense";
  static const String editExpense = "/edit_expense";
  static const String inventoryList = "/inventory_list";
  static const String manualScreen = "/manual_screen";
  static const String addComplaint = "/add_complaint";
  static const String techProfileScreen = "/tech_profile_screen";

  //! Manufacturing Unit Screen
  static const String manufacturingUnitHomeScreen =
      "/manufacturing_unit_screen";

  static const String uploadImageList = "/upload_image_list";
  static const String manufacturingComplaint = "/manufacturing_complaint";
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

        GetPage(
            name: RouteNames.photoViewer,
            page: () => const PhotoViewScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.pdfViewerPageTwo,
            page: () => const PFDViewerPageTwo(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        //! Super Admin Screen
        GetPage(
            name: RouteNames.superAdminHomeScreen,
            page: () => const SuperAdminHomeScreen(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 500)),

        GetPage(
            name: RouteNames.customerList,
            page: () => const CustomerList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.createCustomerScreen,
            page: () => const CreateCustomerScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.customerMachineList,
            page: () => const CustomerMachineList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

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
            name: RouteNames.employeeProfileScreen,
            page: () => const EmployeeProfileScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

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
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.complaintProceed,
            page: () => const ComplaintProceed(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.historyScreen,
            page: () => const HistoryScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.expenseList,
            page: () => const ExpenseList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.addExpense,
            page: () => const AddExpense(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.editExpense,
            page: () => const EditExpense(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.inventoryList,
            page: () => const InventoryList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.manualScreen,
            page: () => const ManualScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.addComplaint,
            page: () => const AddComplaint(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.techProfileScreen,
            page: () => const TechProfileScreen(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        //! Manufacturing unit Screen
        GetPage(
            name: RouteNames.manufacturingUnitHomeScreen,
            page: () => const ManufacturingUnitHomeScreen(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 500)),

        GetPage(
            name: RouteNames.uploadImageList,
            page: () => const UploadImageList(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        GetPage(
            name: RouteNames.manufacturingComplaint,
            page: () => const ManufacturingComplaint(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 250)),

        //! Customer Screen
        GetPage(
            name: RouteNames.customerHomeScreen,
            page: () => const CustomerHomeScreen(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 500)),
      ];
}

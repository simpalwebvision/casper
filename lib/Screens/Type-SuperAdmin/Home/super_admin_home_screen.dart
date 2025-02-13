import 'package:caspro_enterprises/Screens/Type-SuperAdmin/Home/super_admin_home_controller.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Widgets/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuperAdminHomeScreen extends StatefulWidget {
  const SuperAdminHomeScreen({super.key});

  @override
  State<SuperAdminHomeScreen> createState() => _SuperAdminHomeScreenState();
}

class _SuperAdminHomeScreenState extends State<SuperAdminHomeScreen> {
  final controller = Get.put(SuperAdminHomeController());

  @override
  void dispose() {
    Get.delete<SuperAdminHomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        actions: [
          Image.asset(
            AppImages.appLogo,
          )
        ],
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Caspro",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Enterprises",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: secondaryColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: GridView.count(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 20.0,
          children: [
            DashboardWidget(
              widgetText: 'Employees',
              imageAssets: AppImages.users,
              onClicked: () => Get.toNamed(RouteNames.employeesList),
            ),
            DashboardWidget(
              widgetText: 'Customer',
              imageAssets: AppImages.customerManagement,
              onClicked: () => Get.toNamed(RouteNames.customerList),
            ),
            DashboardWidget(
              widgetText: 'Complaints',
              imageAssets: AppImages.complaints,
              onClicked: () => Get.toNamed(RouteNames.complaintsList),
            ),
            DashboardWidget(
              widgetText: 'History',
              imageAssets: AppImages.history,
              onClicked: () => Get.toNamed(RouteNames.historyList),
            ),
            DashboardWidget(
              widgetText: "Catalog",
              imageAssets: AppImages.manualImage,
              onClicked: () => Get.toNamed(RouteNames.manualScreen),
            ),
            DashboardWidget(
              widgetText: "My Account",
              imageAssets: AppImages.account,
              onClicked: () => Get.toNamed(RouteNames.employeeProfileScreen),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () => CommonFunctions().logOut(),
        label: Row(
          children: [
            const Icon(
              Icons.logout,
              color: whiteColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'logout',
              style: GoogleFonts.poppins(color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

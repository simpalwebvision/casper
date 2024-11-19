import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Widgets/dashboard_widget.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'technician_home_controller.dart';

class TechnicianHomeScreen extends StatefulWidget {
  const TechnicianHomeScreen({super.key});

  @override
  State<TechnicianHomeScreen> createState() => _TechnicianHomeScreenState();
}

class _TechnicianHomeScreenState extends State<TechnicianHomeScreen> {
  final controller = Get.put(TechnicianHomeController());

  @override
  void dispose() {
    Get.delete<TechnicianHomeController>();
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
      body: RefreshIndicator(
          onRefresh: () => controller.initData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: purpleColor,
                          border: Border.all(color: blackColor),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Expanded(
                                  child: RechargeWidget(
                                    ispassEnded:
                                        controller.mobileRecharge.value == null
                                            ? false
                                            : controller.mobileRecharge.value!
                                                .isPassEnded,
                                    isPassExpiring:
                                        controller.mobileRecharge.value == null
                                            ? false
                                            : controller.mobileRecharge.value!
                                                .isPassEnding,
                                    bgColor: const Color.fromARGB(
                                        255, 254, 251, 172),
                                    image: AppImages.mobileRecharge,
                                    title: "Recharge",
                                    fromDate: controller.mobileRecharge.value !=
                                            null
                                        ? controller.mobileRecharge.value!.id ==
                                                null
                                            ? "No Present Recharge"
                                            : CommonFunctions()
                                                .convertToApplicationShowDate(
                                                    controller.mobileRecharge
                                                        .value!.fromdate!)
                                        : "-",
                                    toDate: controller.mobileRecharge.value !=
                                            null
                                        ? controller.mobileRecharge.value!.id ==
                                                null
                                            ? "No Present Recharge"
                                            : CommonFunctions()
                                                .convertToApplicationShowDate(
                                                    controller.mobileRecharge
                                                        .value!.todate!)
                                        : "-",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => Expanded(
                                  child: RechargeWidget(
                                    ispassEnded:
                                        controller.trainPass.value == null
                                            ? false
                                            : controller
                                                .trainPass.value!.isPassEnded,
                                    isPassExpiring:
                                        controller.trainPass.value == null
                                            ? false
                                            : controller
                                                .trainPass.value!.isPassEnding,
                                    bgColor: const Color.fromARGB(
                                        255, 172, 244, 254),
                                    image: AppImages.trainPass,
                                    title: "Train Pass",
                                    fromDate: controller.trainPass.value != null
                                        ? controller.trainPass.value!.id == null
                                            ? "No Present Recharge"
                                            : CommonFunctions()
                                                .convertToApplicationShowDate(
                                                    controller.trainPass.value!
                                                        .fromdate!)
                                        : "-",
                                    toDate: controller.trainPass.value != null
                                        ? controller.trainPass.value!.id == null
                                            ? "No Present Recharge"
                                            : CommonFunctions()
                                                .convertToApplicationShowDate(
                                                    controller.trainPass.value!
                                                        .todate!)
                                        : "-",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Expanded(
                                    child: ReportDataWidget(
                                  value: controller
                                              .technicianDashboardExpenseModel
                                              .value ==
                                          null
                                      ? 0.0
                                      : double.parse(controller
                                          .technicianDashboardExpenseModel
                                          .value!
                                          .loanBalance!),
                                  title: "Loan Wallet\nAmount",
                                  bgColor:
                                      const Color.fromARGB(255, 173, 255, 218),
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TechnicianDashBoardWidget(
                                  onPressed: () =>
                                      Get.toNamed(RouteNames.historyScreen),
                                  title: 'Loan Statement',
                                  iconString: AppImages.mytasksHome,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: planColor,
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Expanded(
                                  child: ReportDataWidget(
                                value: controller
                                            .technicianDashboardExpenseModel
                                            .value ==
                                        null
                                    ? 0.0
                                    : double.parse(controller
                                        .technicianDashboardExpenseModel
                                        .value!
                                        .balanceExpense!),
                                title: "Expense\nSummary",
                                bgColor:
                                    const Color.fromARGB(255, 172, 206, 254),
                              )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TechnicianDashBoardWidget(
                                onPressed: () =>
                                    Get.toNamed(RouteNames.expenseList),
                                // onPressed: () =>
                                // Get.toNamed(RouteNames.expenseList)!.then(
                                //     (value) => controller.getProfileData()),
                                title: 'Expense',
                                iconString: AppImages.expenseHome,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TechnicianDashBoardWidget(
                                onPressed: () =>
                                    Get.toNamed(RouteNames.techComplaintsList),
                                title: 'Complaints\nList',
                                iconString: AppImages.complaints,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TechnicianDashBoardWidget(
                                onPressed: () => Get.toNamed(
                                    RouteNames.addComplaint,
                                    arguments: {"from": "technician"}),
                                title: 'Add\nComplaint',
                                iconString: AppImages.complaints,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ColumnImageHelper(
                        onPressed: () =>
                            Get.toNamed(RouteNames.techProfileScreen),
                        image: AppImages.account,
                        title: "My Account",
                      )),
                      Expanded(
                        child: ColumnImageHelper(
                          title: "Catalog",
                          image: AppImages.offer,
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HelperPage()));
                          },
                        ),
                      ),
                      Expanded(
                          child: ColumnImageHelper(
                        onPressed: () => Get.toNamed(RouteNames.inventoryList),
                        image: AppImages.spareParts,
                        title: "Spare Parts",
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ColumnImageHelper(
                          title: "Manual",
                          image: AppImages.manualImage,
                          onPressed: () => Get.toNamed(RouteNames.manualScreen),
                        ),
                      ),
                      Expanded(
                          child: ColumnImageHelper(
                        onPressed: () => CommonFunctions().logOut(),
                        image: AppImages.logout,
                        title: "Logout",
                      )),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )

          // Container(
          //   alignment: Alignment.topCenter,
          //   child: GridView.count(
          //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          //     shrinkWrap: true,
          //     crossAxisCount: 3,
          //     crossAxisSpacing: 8.0,
          //     mainAxisSpacing: 20.0,
          //     children: [
          //       DashboardWidget(
          //         widgetText: 'Complaints',
          //         imageAssets: AppImages.complaints,
          //         onClicked: () => Get.toNamed(RouteNames.techComplaintsList),
          //       ),
          //       DashboardWidget(
          //         widgetText: 'History',
          //         imageAssets: AppImages.history,
          //         onClicked: () => Get.toNamed(RouteNames.historyList),
          //       ),
          //       DashboardWidget(
          //         widgetText: "Catalog",
          //         imageAssets: AppImages.offer,
          //         onClicked: () {},
          //       ),
          //       DashboardWidget(
          //         widgetText: "My Account",
          //         imageAssets: AppImages.account,
          //         onClicked: () => Get.toNamed(RouteNames.profileScreen),
          //       ),
          //       DashboardWidget(
          //         widgetText: "Logout",
          //         imageAssets: AppImages.logout,
          //         onClicked: () => CommonFunctions().logOut(),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}

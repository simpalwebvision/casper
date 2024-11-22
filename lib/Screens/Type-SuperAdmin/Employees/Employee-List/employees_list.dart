import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/custom_image.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:caspro_enterprises/Widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'employee_list_controller.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({super.key});

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  final controller = Get.put(EmployeeListController());
  @override
  void dispose() {
    Get.delete<EmployeeListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Users"),
      body: Column(
        children: [
          SearchTextField(
            controller: controller.ctlSearchController.value,
            hintText: 'Search here ...',
            borderColor: Colors.grey,
            focusedBorderColor: Colors.blue,
            errorBorderColor: Colors.red,
            fillColor: Colors.white,
            onChanged: (value) {
              // Handle change
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              unselectedLabelColor: secondaryColor,
              padding: const EdgeInsets.only(bottom: 5),
              indicatorColor: primaryColor,
              controller: controller.tabController,
              labelColor: primaryColor,
              labelStyle: GoogleFonts.mukta(fontWeight: FontWeight.bold),
              onTap: (value) => controller.onChangeTab(value),
              tabs: const [
                Tab(
                  text: 'Office',
                ),
                Tab(
                  text: 'Technician',
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isSelectTechincian.value
                ? Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.getTechnicianList(),
                      child: controller.isTechnicianLoading.value
                          ? const CommonLoader()
                          : controller.technicianList.isEmpty
                              ? const NoDataFoundScreen(
                                  image: AppImages.emptyData,
                                  passedData: "No Technician Found ..",
                                )
                              : ListView.separated(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(bottom: 15),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: controller.technicianList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var technician =
                                        controller.technicianList[index];
                                    return InkWell(
                                      onTap: () {},
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        shadowColor: blackColor,
                                        clipBehavior: Clip.hardEdge,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: borderColor),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ProfileCustomImage(
                                                image: technician.image ?? "",
                                                errorImage:
                                                    "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg",
                                                imgHeight: 50,
                                                imgWidth: 50,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    DetailWidgetHelper(
                                                      heading: "User name",
                                                      value:
                                                          technician.name ?? "",
                                                      valueColor: blueColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    DetailWidgetHelper(
                                                      heading: "Mobile no.",
                                                      value:
                                                          technician.mobile ??
                                                              "",
                                                      valueColor: blueColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    DetailWidgetHelper(
                                                      heading: "Address",
                                                      value:
                                                          technician.address ??
                                                              "",
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Divider(
                                                      color: blackColor,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Technician",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 13,
                                                                  color:
                                                                      primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  )
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.getEmployeeList(),
                      child: controller.isEmployeeLoading.value
                          ? const CommonLoader()
                          : controller.employeeList.isEmpty
                              ? const NoDataFoundScreen(
                                  image: AppImages.emptyData,
                                  passedData: "No Employee Found ..",
                                )
                              : ListView.separated(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(bottom: 15),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: controller.employeeList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var employee =
                                        controller.employeeList[index];
                                    return InkWell(
                                      onTap: () {},
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        shadowColor: blackColor,
                                        clipBehavior: Clip.hardEdge,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: borderColor),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ProfileCustomImage(
                                                image: employee.image ?? "",
                                                errorImage:
                                                    "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg",
                                                imgHeight: 50,
                                                imgWidth: 50,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    DetailWidgetHelper(
                                                      heading: "User name",
                                                      value:
                                                          employee.fullname ??
                                                              "",
                                                      valueColor: blueColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    DetailWidgetHelper(
                                                      heading: "Mobile no.",
                                                      value:
                                                          employee.mobile ?? "",
                                                      valueColor: blueColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    DetailWidgetHelper(
                                                      heading: "Email",
                                                      value:
                                                          employee.email ?? "",
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Divider(
                                                      color: blackColor,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          employee.type ?? "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 13,
                                                                  color:
                                                                      primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

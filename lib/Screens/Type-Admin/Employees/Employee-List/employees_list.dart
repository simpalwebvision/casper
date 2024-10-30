import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Widgets/custom_image.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.fetchData(),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 15),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      shadowColor: blackColor,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: borderColor),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ProfileCustomImage(
                              image:
                                  "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg",
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
                                    value: "Siddhant mestry",
                                    valueColor: blueColor,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  DetailWidgetHelper(
                                    heading: "Mobile no.",
                                    value: "Inv-150",
                                    valueColor: blueColor,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const DetailWidgetHelper(
                                    heading: "Email",
                                    value: "test@gmail.com",
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(
                                    color: blackColor,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Technician",
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }
}

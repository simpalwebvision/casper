import 'package:caspro_enterprises/Screens/Type-SuperAdmin/Complaints/Complaints-List/complaints_list_controller.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:caspro_enterprises/Widgets/no_data_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintsList extends StatefulWidget {
  const ComplaintsList({super.key});

  @override
  State<ComplaintsList> createState() => _ComplaintsListState();
}

class _ComplaintsListState extends State<ComplaintsList> {
  final controller = Get.put(ComplaintsListController());

  @override
  void dispose() {
    Get.delete<ComplaintsListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Complaints"),
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
                child: Obx(
                  () => controller.isLoading.value
                      ? const CommonLoader()
                      : controller.searchResultList.isEmpty
                          ? const NoDataFoundScreen(
                              image: AppImages.emptyData,
                              passedData: "No Complaint Found ..",
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(bottom: 100),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: controller.searchResultList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = controller.searchResultList[index];
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
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              MultiDetailHelper(
                                                heading: "Sr.No",
                                                value: "${index + 1}",
                                              ),
                                              const Spacer(),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: data.statusColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  data.status!,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Complaint",
                                            value: data.complain!,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Machine",
                                            value: data.machineName!,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Description",
                                            value: data.machineDescription!,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Size/Weight/Litter",
                                            value:
                                                data.machineSizeWeightLitter!,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Card(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            shape: const RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: borderColor)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Customer Details",
                                                    style: GoogleFonts.poppins(
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const Divider(
                                                    height: 10,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  DetailWidgetHelper(
                                                    heading: "Name",
                                                    value: data.name!,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  DetailWidgetHelper(
                                                    heading: "Mobile",
                                                    value: data.mobile!,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  DetailWidgetHelper(
                                                    heading: "Address",
                                                    value: data.address!,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Divider(
                                            color: blackColor,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Date : ",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                data.createdAt!,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Spacer(),
                                              AppSmallButtonBorder(
                                                backColor: successColor,
                                                horizontalPadding: 20,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Assign",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  whiteColor),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const Icon(
                                                      Icons.person,
                                                      color: whiteColor,
                                                      size: 18,
                                                    )
                                                  ],
                                                ),
                                                onPressed: () =>
                                                    controller.assignTechnician(
                                                        context, data),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                )),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          label: Row(
            children: [
              const Icon(
                CupertinoIcons.add,
                color: whiteColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Add Complaint",
                style: GoogleFonts.mukta(color: whiteColor),
              ),
            ],
          ),
          backgroundColor: secondaryColor,
          onPressed: () => Get.toNamed(RouteNames.addComplaint,
                  arguments: {"from": "admin"})!
              .then((e) => controller.fetchData())),
    );
  }
}

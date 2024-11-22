import 'package:caspro_enterprises/Screens/Type-SuperAdmin/History/history_list_controller.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/no_data_found.dart';
import 'package:caspro_enterprises/Widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final ctl = Get.put(HistoryListController());

  @override
  void dispose() {
    Get.delete<HistoryListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "History"),
      body: Column(
        children: [
          SearchWidget(
            fromOnTap: () => ctl.geFromDate(context),
            toOnTap: () => ctl.geToDate(context),
            fromdate: ctl.ctlFromDate.value,
            toDate: ctl.ctlUptoDate.value,
            onSearch: () => {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              unselectedLabelColor: secondaryColor,
              padding: const EdgeInsets.only(bottom: 5),
              indicatorColor: primaryColor,
              controller: ctl.tabController,
              labelColor: primaryColor,
              labelStyle: GoogleFonts.mukta(fontWeight: FontWeight.bold),
              onTap: (value) => ctl.onChangeTab(value),
              tabs: const [
                Tab(
                  text: 'Complete',
                ),
                Tab(
                  text: 'Pending',
                ),
                Tab(
                  text: 'Machine',
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: () => ctl.fetchData(),
                child: GetBuilder<HistoryListController>(
                  builder: (controller) {
                    return controller.isLoading.value
                        ? const CommonLoader()
                        : controller.complaintList.isEmpty
                            ? const NoDataFoundScreen(
                                image: AppImages.emptyData,
                                passedData: "No Complaint Found ..",
                              )
                            : ListView.separated(
                                padding: const EdgeInsets.only(bottom: 15),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                itemCount: controller.complaintList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = controller.complaintList[index];
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
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: purpleColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  data.complainType!,
                                                  style: GoogleFonts.poppins(
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                        color: data
                                                            .statusTextColor,
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
                                              height: 5,
                                            ),
                                            DetailWidgetHelper(
                                              heading: "Assign To",
                                              value: data.createdBy!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Card(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: borderColor)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Customer Details",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  data.createdAt!,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                  },
                )),
          ),
        ],
      ),
    );
  }
}

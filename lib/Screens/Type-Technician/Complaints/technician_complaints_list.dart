import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'technician_complaints_list_controller.dart';

class TechnicianComplaintsList extends StatefulWidget {
  const TechnicianComplaintsList({super.key});

  @override
  State<TechnicianComplaintsList> createState() =>
      _TechnicianComplaintsListState();
}

class _TechnicianComplaintsListState extends State<TechnicianComplaintsList> {
  final controller = Get.put(TechnicianComplaintsListController());

  @override
  void dispose() {
    Get.delete<TechnicianComplaintsListController>();
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
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const DetailWidgetHelper(
                              heading: "Complaint",
                              value: "",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const DetailWidgetHelper(
                              heading: "Assign To",
                              value: "",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const DetailWidgetHelper(
                              heading: "Remark",
                              value: "",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(horizontal: 0),
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: borderColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Customer Details",
                                      style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Divider(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const DetailWidgetHelper(
                                      heading: "Name",
                                      value: "",
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const DetailWidgetHelper(
                                      heading: "Mobile",
                                      value: "+91 1231454645",
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const DetailWidgetHelper(
                                      heading: "Address",
                                      value: "",
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
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "24/10/2024",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                AppSmallButtonBorder(
                                  backColor: blueColor,
                                  horizontalPadding: 10,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Proceed",
                                        style: GoogleFonts.poppins(
                                            color: whiteColor),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: whiteColor,
                                      )
                                    ],
                                  ),
                                  onPressed: () {},
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
            ),
          ),
        ],
      ),
    );
  }
}

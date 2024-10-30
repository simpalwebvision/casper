import 'package:caspro_enterprises/Screens/Type-SuperAdmin/History/history_list_controller.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/pdf_helper.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:caspro_enterprises/Widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final controller = Get.put(HistoryListController());
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
            fromOnTap: () => controller.geFromDate(context),
            toOnTap: () => controller.geToDate(context),
            fromdate: controller.ctlFromDate.value,
            toDate: controller.ctlUptoDate.value,
            onSearch: () => {},
          ),
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
                    onTap: () async {
                      await EasyLoading.show(
                        status: 'Loading PDF Contents',
                        maskType: EasyLoadingMaskType.black,
                      );
                      try {
                        final file = await PdfApi.loadNetworkFile(
                            "https://www.orimi.com/pdf-test.pdf");
                        EasyLoading.dismiss();
                        Get.toNamed(RouteNames.pdfViewerPage, arguments: {
                          "file": file,
                        });
                      } catch (error) {
                        EasyLoading.dismiss();
                        CommonFunctions.showGetxSnackBar("Error",
                            msg: "Network Error..");
                      }
                    },
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
                              height: 5,
                            ),
                            DetailWidgetHelper(
                              heading: "Status",
                              value: "",
                              valueColor: blueColor,
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
                                      valueColor: blackColor,
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
                                      heading: "Email",
                                      value: "test@gmail.com",
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                              ],
                            ),
                            const SizedBox(
                              height: 10,
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

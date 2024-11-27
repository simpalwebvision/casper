import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import 'expense_list_controller.dart';
import 'expense_sheet_detail.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final controller = Get.put(ExpenseSheetController());

  @override
  void dispose() {
    nb.setStatusBarColor(whiteColor);
    Get.delete<ExpenseSheetController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Expense List"),
      body: RefreshIndicator(
          onRefresh: () => controller.getExpenseList(),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(child: CommonLoader())
                : controller.expenseList.isEmpty
                    ? const NoDataFoundScreen(
                        image: AppImages.emptyData,
                        passedData: "No Expense Found",
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: controller.expenseList.length,
                        itemBuilder: (context, index) {
                          var data = controller.expenseList[index];
                          return InkWell(
                            onTap: () => Get.to(
                                () => ExpenseSheetDetail(
                                      expenseModel: data,
                                    ),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 250)),
                            child: Card(
                              shadowColor: blackColor,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: borderColor),
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 7,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            width: 6,
                                            color: data.status == "Pending"
                                                ? Colors.red
                                                : Colors.green))),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                            RouteNames
                                                                .editExpense,
                                                            arguments: {
                                                          'expense_model': data
                                                        })!
                                                        .then((value) => controller
                                                            .getExpenseList());
                                                  },
                                                  child: const Icon(
                                                    FontAwesomeIcons
                                                        .penToSquare,
                                                    size: 20,
                                                    color: primaryColor,
                                                  )),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Status",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: blackColor),
                                                  ),
                                                  Text(
                                                    ":",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: blackColor),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    data.status ?? "",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: data.status ==
                                                                "Pending"
                                                            ? Colors.red
                                                            : Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Call Date",
                                            value: data.callDate ?? "",
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Customer Name",
                                            value: data.customerName ?? "",
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Service Ticket No.",
                                            value: data.serviceTicketNo ?? "",
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Remark",
                                            value: checkNullOperatorFun(
                                                data.remark),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                                color: blueColor,
                                                borderRadius: const BorderRadius
                                                    .vertical(
                                                    top: Radius.circular(8))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Total Claim",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Claim Approve",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Claim Reject",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: blackColor)),
                                                  child: Text(
                                                    checkNullOperatorFun(
                                                        data.totalExpense),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: blackColor)),
                                                  child: Text(
                                                    checkNullOperatorFun(
                                                        data.approvedExpense),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: blackColor)),
                                                  child: Text(
                                                    checkNullOperatorFun(
                                                        data.balanceExpense),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // const Divider(
                                    //   color: blackColor,
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Created At : ",
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          data.createdAt ?? "",
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500),
                                        ),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () => Get.toNamed(RouteNames.addExpense),
        // onPressed: () => Get.toNamed(RouteNames.addExpense)!
        //     .then((value) => controller.getExpenseList()),
        label: Row(
          children: [
            const Icon(
              Icons.add,
              color: whiteColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Add',
              style: GoogleFonts.poppins(color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

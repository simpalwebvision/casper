import 'package:caspro_enterprises/Models/expense_model.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Widgets/custom_image.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class ExpenseSheetDetail extends StatefulWidget {
  final ExpenseModel expenseModel;
  const ExpenseSheetDetail({super.key, required this.expenseModel});

  @override
  State<ExpenseSheetDetail> createState() => _ExpenseSheetDetailState();
}

class _ExpenseSheetDetailState extends State<ExpenseSheetDetail> {
  @override
  void initState() {
    nb.setStatusBarColor(
        widget.expenseModel.status == "Pending" ? Colors.red : Colors.green);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          context: context,
          heading: widget.expenseModel.serviceTicketNo ?? "",
          backColor: widget.expenseModel.status == "Pending"
              ? Colors.red
              : Colors.green),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 6,
                color: widget.expenseModel.status == "Pending"
                    ? Colors.red
                    : Colors.green)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Text(
                        "Status",
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: blackColor),
                      ),
                      Text(
                        ":",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: blackColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.expenseModel.status ?? "",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: widget.expenseModel.status == "Pending"
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
                value: widget.expenseModel.callDate ?? "",
              ),
              const SizedBox(
                height: 10,
              ),
              DetailWidgetHelper(
                heading: "Customer Name",
                value: widget.expenseModel.customerName ?? "",
              ),
              const SizedBox(
                height: 10,
              ),
              DetailWidgetHelper(
                heading: "Mobile",
                value: widget.expenseModel.mobile ?? "",
              ),
              const SizedBox(
                height: 10,
              ),
              DetailWidgetHelper(
                heading: "Remark",
                value: widget.expenseModel.remark ?? "",
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Expense",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.amber[900]),
                  ),
                  Text(
                    " :",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, color: Colors.amber[900]),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.expenseModel.totalExpense ?? "",
                      style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.normal,
                          color: blackColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              widget.expenseModel.journeyString!.isEmpty
                  ? const SizedBox()
                  : Column(
                      children: [
                        Text(
                          "Journey Detail",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.only(bottom: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.expenseModel.journeyString!.length,
                          itemBuilder: (context, index) {
                            JourneyModel journey =
                                widget.expenseModel.journeyString![index];
                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(4)),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 13),
                                child: Column(
                                  children: [
                                    DetailWidgetHelper(
                                      heading: "Travel Type",
                                      value: journey.journeyType ?? "",
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    DetailWidgetHelper(
                                      heading: "Mode Of Transport",
                                      value: journey.modeOfTransport ?? "",
                                    ),
                                    journey.modeOfTransport == "Other"
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              DetailWidgetHelper(
                                                heading: "Transport",
                                                value: journey.otherTransport ??
                                                    "",
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    DetailWidgetHelper(
                                      heading: "Start From",
                                      value: journey.startFrom ?? "",
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    DetailWidgetHelper(
                                      heading: "To From",
                                      value: journey.toFrom ?? "",
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Expense",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                        Text(
                                          ":",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: blackColor),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          journey.totalExpense ?? "",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                        ),
                      ],
                    ),
              const SizedBox(
                height: 3,
              ),
              widget.expenseModel.receipt!.isEmpty
                  ? const SizedBox()
                  : Text(
                      "Receipts",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
              widget.expenseModel.receipt!.isEmpty
                  ? const SizedBox()
                  : const SizedBox(
                      height: 10,
                    ),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    ...widget.expenseModel.receipt!.map(
                      (image) => ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          // onTap: () => Get.toNamed(RouteNames.photoViewer,
                          //     arguments: {"image": image, "title": "Receipt"}),
                          child: CustomImage(
                              image: image,
                              borderRadius: 4,
                              boxFit: BoxFit.fill,
                              errorImage: AppImages.noImageError,
                              imgHeight: 100,
                              imgWidth: 100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

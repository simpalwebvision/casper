import 'dart:io';

import 'package:caspro_enterprises/Models/expense_model.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:caspro_enterprises/Widgets/app_helpers.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/dropdown_widget.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';

import 'edit_expense_controller.dart';

class EditExpense extends StatefulWidget {
  const EditExpense({super.key});

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  final controller = Get.put(EditExpenseController());
  ExpenseModel expenseModel = ExpenseModel();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool colorChange = false;
  CroppedFile? recieptImage;

  @override
  void dispose() {
    Get.delete<EditExpenseController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () => CommonFunctions.hideKeyboard(context),
        child: Scaffold(
            appBar: commonAppBar(context: context, heading: "Edit Claim Sheet"),
            body: Obx(
              () => controller.isInitData.value
                  ? const CommonLoader()
                  : SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              StepperTextField(
                                controllerValue: controller.ctlCallDate.value,
                                inputType: TextInputType.text,
                                hintValue: 'Call Date',
                                //   onTap: () => controller.geFromDate(context),
                                rOnly: true,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Call Date can't empty.";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              StepperTextField(
                                controllerValue:
                                    controller.ctlCustomerName.value,
                                inputType: TextInputType.name,
                                hintValue: 'Customer Name',
                                rOnly: true,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Name can't empty.";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              StepperTextField(
                                controllerValue:
                                    controller.ctlServiceTicketNo.value,
                                inputType: TextInputType.text,
                                hintValue: 'Service Ticket No.',
                                rOnly: true,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Service Ticket can't empty.";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              StepperTextField(
                                controllerValue: controller.ctlMobile.value,
                                inputType: TextInputType.number,
                                mLength: 10,
                                rOnly: true,
                                hintValue: 'Mobile',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Mobile can't empty.";
                                  } else if (val.length < 10) {
                                    return "Mobile number should be 10 digits.";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              controller.journeyList.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Journey Details',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // TextButton(
                                            //     style: ElevatedButton.styleFrom(
                                            //         backgroundColor: whiteColor),
                                            //     onPressed: () {
                                            //       CommonFunctions.hideKeyboard(context);
                                            //       Get.dialog(
                                            //         addEditJourneyDialogue(
                                            //             context, JourneyModel(), "Add"),
                                            //         transitionCurve: Curves.easeInOut,
                                            //         transitionDuration:
                                            //             const Duration(milliseconds: 300),
                                            //       );
                                            //     },
                                            //     child: Row(
                                            //       mainAxisSize: MainAxisSize.min,
                                            //       children: [
                                            //         const Icon(
                                            //           Icons.add,
                                            //           color: primaryColor,
                                            //         ),
                                            //         const SizedBox(
                                            //           width: 10,
                                            //         ),
                                            //         Text(
                                            //           "Add",
                                            //           style: GoogleFonts.poppins(
                                            //               color: primaryColor,
                                            //               fontWeight: FontWeight.bold),
                                            //         ),
                                            //       ],
                                            //     ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),

                              Column(
                                children: [
                                  GetBuilder<EditExpenseController>(
                                      builder: (context) {
                                    return ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.journeyList.length,
                                      itemBuilder: (context, index) {
                                        JourneyModel journey =
                                            controller.journeyList[index];
                                        return Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: borderColor),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          margin: EdgeInsets.zero,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13, vertical: 13),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: DetailWidgetHelper(
                                                        heading: "Sr. No.",
                                                        value: "${index + 1}",
                                                      ),
                                                    ),
                                                    // InkWell(
                                                    //   onTap: () => Get.dialog(
                                                    //     addEditJourneyDialogue(
                                                    //         context, journey, "Edit"),
                                                    //     transitionCurve:
                                                    //         Curves.easeInOut,
                                                    //     transitionDuration:
                                                    //         const Duration(
                                                    //             milliseconds: 300),
                                                    //   ),
                                                    //   child: const Icon(
                                                    //     CupertinoIcons.pencil_circle,
                                                    //     color: darkBlueColor,
                                                    //   ),
                                                    // ),
                                                    // const SizedBox(
                                                    //   width: 10,
                                                    // ),
                                                    // InkWell(
                                                    //   onTap: () => controller
                                                    //       .deleteJourney(index),
                                                    //   child: const Icon(
                                                    //     CupertinoIcons.delete,
                                                    //     color: Colors.red,
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                DetailWidgetHelper(
                                                  heading: "Travel Type",
                                                  value:
                                                      journey.journeyType ?? "",
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                DetailWidgetHelper(
                                                  heading: "Mode Of Transport",
                                                  value:
                                                      journey.modeOfTransport ??
                                                          "",
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                DetailWidgetHelper(
                                                  heading: "Start From",
                                                  value:
                                                      journey.startFrom ?? "",
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
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.green),
                                                    ),
                                                    Text(
                                                      ":",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  blackColor),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      journey.totalExpense ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
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
                                          height: 10,
                                        );
                                      },
                                    );
                                  }),
                                  // controller.journeyList.isEmpty
                                  //     ? const SizedBox()
                                  //     : TextButton(
                                  //         style: ElevatedButton.styleFrom(
                                  //             backgroundColor: whiteColor),
                                  //         onPressed: () {
                                  //           Get.dialog(
                                  //             addEditJourneyDialogue(
                                  //                 context, JourneyModel(), "Add"),
                                  //             transitionCurve: Curves.easeInOut,
                                  //             transitionDuration:
                                  //                 const Duration(milliseconds: 300),
                                  //           );
                                  //         },
                                  //         child: Row(
                                  //           mainAxisSize: MainAxisSize.min,
                                  //           children: [
                                  //             const Icon(
                                  //               Icons.add,
                                  //               color: primaryColor,
                                  //             ),
                                  //             const SizedBox(
                                  //               width: 10,
                                  //             ),
                                  //             Text(
                                  //               "Add More Journey",
                                  //               style: GoogleFonts.poppins(
                                  //                   color: primaryColor,
                                  //                   fontWeight: FontWeight.bold),
                                  //             ),
                                  //           ],
                                  //         )),

                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              Obx(
                                () => Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Total Expense : ${controller.totalExpense.value}',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.amber[900]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Receipt Images",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: [
                                        ...controller.pickedFiles.map(
                                          (passedfile) => InkWell(
                                            // onTap: () => Get.toNamed(
                                            //     RouteNames.photoViewer,
                                            //     arguments: {
                                            //       "image":
                                            //           passedfile.imageString,
                                            //       "title": "Purchase Material"
                                            //     }),
                                            child: SizedBox(
                                              height: size.width * 0.2,
                                              width: size.width * 0.2,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.file(
                                                  File(passedfile.file!.path),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Obx(
                                () => controller.errorDetail.value.isEmpty
                                    ? Container()
                                    : Column(
                                        children: [
                                          ErrorText(
                                            error: controller.errorDetail.value,
                                            errorColor: Colors.red,
                                          ),
                                        ],
                                      ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              Obx(() => AppButton(
                                    onPressed: controller.isSubmitting.value
                                        ? null
                                        : () {
                                            CommonFunctions.hideKeyboard(
                                                context);
                                            final isValid = _formKey
                                                .currentState!
                                                .validate();

                                            if (!isValid) {
                                              return;
                                            }

                                            controller.editClaimSheet();
                                          },
                                    child: controller.isSubmitting.value
                                        ? const CommonButtonLoader(
                                            indicatorColor: whiteColor)
                                        : Text(
                                            "Update",
                                            style: GoogleFonts.poppins(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  )),
                              // AppButton(
                              //   onPressed: () {
                              //     controller.isSubmitting(false);
                              //   },
                              //   child: Text(
                              //     "Submit",
                              //     style: GoogleFonts.poppins(
                              //         color: whiteColor, fontWeight: FontWeight.bold),
                              //   ),
                              // )
                            ],
                          )),
                    )),
            )));
  }

  GestureDetector addEditJourneyDialogue(
      BuildContext context, JourneyModel model, String type) {
    if (model.journeyType == null) {
      controller.fromAddJourneyForm();
    } else {
      controller.fromEditJourneyForm(model);
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: whiteColor,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Journey Form",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blueAccent),
                    ),
                    IconButton(
                        style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            backgroundColor: Colors.red),
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.close,
                          color: whiteColor,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Obx(
                  () => Card(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: borderColor)),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            'Travel Type (Journey)',
                            style: GoogleFonts.poppins(
                                color: whiteColor, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  title: Text(
                                    'Start',
                                    style:
                                        GoogleFonts.poppins(color: whiteColor),
                                  ),
                                  leading: Radio(
                                      value: TravelType.startJourney,
                                      fillColor: const WidgetStatePropertyAll(
                                          whiteColor),
                                      groupValue:
                                          controller.selectedTravelType.value,
                                      onChanged: (TravelType? val) =>
                                          controller.setTravelTypeOption(val!)),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  title: Text(
                                    'Return',
                                    style:
                                        GoogleFonts.poppins(color: whiteColor),
                                  ),
                                  leading: Radio(
                                      fillColor: const WidgetStatePropertyAll(
                                          whiteColor),
                                      value: TravelType.returnJourney,
                                      groupValue:
                                          controller.selectedTravelType.value,
                                      onChanged: (TravelType? val) =>
                                          controller.setTravelTypeOption(val!)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DropDownWidget(
                  isExpand: false,
                  selectedVal: controller.ctlTransportMode.value.text,
                  onChanged: (value) =>
                      controller.selectTransport(value.toString()),
                  labelText: type == "Add"
                      ? "Mode Of Transport"
                      : controller.ctlTransportMode.value.text,
                  hintText: type == "Add"
                      ? "Mode Of Transport"
                      : controller.ctlTransportMode.value.text,
                  validate: (val) {
                    if (val == null) {
                      return "Required";
                    }
                    return null;
                  },
                  dropMenuList: const ["Bus", "Bike", "Auto", "Taxi", "Tempo"],
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlStartFrom.value,
                  inputType: TextInputType.text,
                  hintValue: 'Starting From',
                  validate: (val) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlToFrom.value,
                  inputType: TextInputType.text,
                  hintValue: 'To From',
                  validate: (val) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlTotalExp.value,
                  inputType: TextInputType.number,
                  hintValue: 'Total Expense',
                  validate: (val) {
                    // RegExp regex =
                    //     RegExp(r'^(?!.*[,\-\s])(?!.*\..*\.)[^\s,.-]+$');

                    if (!RegExp(r'^.+$').hasMatch(val!)) {
                      return 'The Expense should not be empty.';
                    } else if (!RegExp(r'^[^,\-\s]+$').hasMatch(val)) {
                      return 'The Expense should not contain whitespace, commas, or hyphens.';
                    } else if (!RegExp(r'^(?!.*\.\d*\..*$)(\d*\.\d+|\d+)$')
                        .hasMatch(val)) {
                      return 'There should be at least one digit after the decimal point.';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                AppButton(
                    onPressed: () => type == "Add"
                        ? controller.addJourney()
                        : controller.editJourney(model),
                    backColor: Colors.blueAccent,
                    child: Text(
                      type == "Add" ? "Add Journey" : "Update Journey",
                      style: GoogleFonts.poppins(color: whiteColor),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

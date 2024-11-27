import 'package:caspro_enterprises/Models/machine_model.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:caspro_enterprises/Widgets/app_helpers.dart';
import 'package:caspro_enterprises/Widgets/dropdown_widget.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_complaint_controller.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({super.key});

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  final ctl = Get.put(AddComplaintController());

  @override
  void dispose() {
    Get.delete<AddComplaintController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CommonFunctions.hideKeyboard(context),
      child: Scaffold(
        appBar: commonAppBar(context: context, heading: "Add Complaint"),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Form(
            key: ctl.formKey,
            child: Column(
              children: [
                IgnorePointer(
                  ignoring: ctl.from == "technician",
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
                        text: 'Service',
                      ),
                      Tab(
                        text: 'Order',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<AddComplaintController>(builder: (controller) {
                  return Column(
                    children: [
                      DropDownWidget(
                        isExpand: false,
                        selectedVal: controller.ctlBagType.value.text,
                        onChanged: (value) =>
                            controller.selectBagType(value.toString()),
                        labelText: "Order Type",
                        hintText: "Order Type",
                        validate: (val) {
                          if (val == null) {
                            return "Required";
                          }
                          return null;
                        },
                        dropMenuList: const [
                          "New Machine",
                          "Bag",
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  );
                }),
                GetBuilder<AddComplaintController>(builder: (controller) {
                  return Column(
                    children: [
                      controller.tabController.index == 0
                          ? TypeAheadField<MachineModel>(
                              controller: ctl.ctlMachineCode.value,
                              suggestionsCallback: (query) {
                                return ctl.searchMachines(query);
                              },
                              builder: (context, ctl, focusNode) {
                                return TextField(
                                  style: GoogleFonts.poppins(
                                    fontSize: Get.width * 0.034,
                                    color: Colors.black,
                                    letterSpacing: 1,
                                  ),
                                  controller: ctl,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                      label: Text(
                                        "Enter Machie code",
                                        style: GoogleFonts.poppins(),
                                      ),
                                      hintText: "Enter Machie code",
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: Get.width * 0.034,
                                        color: Colors.black38,
                                        letterSpacing: 1,
                                      ),
                                      errorStyle: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: secondaryColor,
                                              width: 1.5)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                      labelStyle: GoogleFonts.poppins(
                                        fontSize: Get.width * 0.034,
                                        color: Colors.black,
                                        letterSpacing: 1,
                                      )),
                                );
                              },
                              itemBuilder: (context, machine) {
                                return ListTile(
                                  title: Text(machine.machineCode!),
                                  subtitle: Text(machine.name!),
                                );
                              },
                              onSelected: (machine) => ctl.onSelected(machine),
                            )
                          : TypeAheadField<BagModel>(
                              controller: ctl.ctlBagCode.value,
                              suggestionsCallback: (query) {
                                return ctl.searchBag(query);
                              },
                              builder: (context, ctl, focusNode) {
                                return TextField(
                                  style: GoogleFonts.poppins(
                                    fontSize: Get.width * 0.034,
                                    color: Colors.black,
                                    letterSpacing: 1,
                                  ),
                                  controller: ctl,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                      label: Text(
                                        "Enter Bag code",
                                        style: GoogleFonts.poppins(),
                                      ),
                                      hintText: "Enter Bag code",
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: Get.width * 0.034,
                                        color: Colors.black38,
                                        letterSpacing: 1,
                                      ),
                                      errorStyle: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: secondaryColor,
                                              width: 1.5)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                      labelStyle: GoogleFonts.poppins(
                                        fontSize: Get.width * 0.034,
                                        color: Colors.black,
                                        letterSpacing: 1,
                                      )),
                                );
                              },
                              itemBuilder: (context, bag) {
                                return ListTile(
                                  title: Text(bag.bagCode!),
                                  subtitle: Text(bag.machineName!),
                                );
                              },
                              onSelected: (bag) => ctl.onSelectedBag(bag),
                            ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: ctl.ctlNumber.value,
                  mLength: 10,
                  inputType: TextInputType.number,
                  validate: (val) {
                    if (val!.isEmpty) {
                      return "Mobile can't be empty.";
                    } else {
                      return null;
                    }
                  },
                  hintValue: "Mobile",
                ),
                // const SizedBox(
                //   height: 15,
                // ),
                // StepperTextField(
                //   controllerValue: ctl.ctlEmail.value,
                //   inputType: TextInputType.emailAddress,
                //   validate: (val) {
                //     return null;
                //   },
                //   hintValue: "E-Mail",
                // ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: ctl.ctlName.value,
                  inputType: TextInputType.text,
                  validate: (val) {
                    return null;
                  },
                  hintValue: "Name",
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: ctl.ctlAddress.value,
                  inputType: TextInputType.streetAddress,
                  validate: (val) {
                    return null;
                  },
                  hintValue: "Address",
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: ctl.ctlMachineName.value,
                  inputType: TextInputType.text,
                  rOnly: true,
                  validate: (val) {
                    return null;
                  },
                  hintValue: "Machine name",
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: ctl.ctlMachineDescription.value,
                  inputType: TextInputType.text,
                  rOnly: true,
                  validate: (val) {
                    return null;
                  },
                  hintValue: "Machine Description",
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: ctl.ctlMachineSizeWeightLitter.value,
                  inputType: TextInputType.text,
                  rOnly: true,
                  validate: (val) {
                    return null;
                  },
                  hintValue: "Size / Weight / Litter",
                ),
                GetBuilder<AddComplaintController>(builder: (controller) {
                  return controller.tabController.index == 0
                      ? const SizedBox()
                      : Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            StepperTextField(
                              controllerValue: controller.ctlQuantity.value,
                              inputType: TextInputType.number,
                              mLength: 4,
                              validate: (val) {
                                return null;
                              },
                              hintValue: "Quantity",
                            ),
                          ],
                        );
                }),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: ctl.ctlComplaint.value,
                  inputType: TextInputType.text,
                  validate: (val) {
                    return null;
                  },
                  hintValue: "Write Complaint here ..",
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => AppButton(
                    backColor: headingColor,
                    onPressed: ctl.isBtnLoading.value
                        ? null
                        : () => ctl.addComplaint(context),
                    child: ctl.isBtnLoading.value
                        ? const CommonButtonLoader(indicatorColor: whiteColor)
                        : Text(
                            "Add Complaint",
                            style: GoogleFonts.poppins(color: whiteColor),
                          )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

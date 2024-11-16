import 'package:caspro_enterprises/Models/machine_model.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:caspro_enterprises/Widgets/app_helpers.dart';
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
  final controller = Get.put(AddComplaintController());

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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TypeAheadField<MachineModel>(
                  controller: controller.ctlMachineCode.value,
                  suggestionsCallback: (query) {
                    return controller.searchMachines(query);
                  },
                  builder: (context, controller, focusNode) {
                    return TextField(
                      style: GoogleFonts.poppins(
                        fontSize: Get.width * 0.034,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                      controller: controller,
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
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: secondaryColor, width: 1.5)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.red)),
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
                  onSelected: (machine) => controller.onSelected(machine),
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlNumber.value,
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
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlEmail.value,
                  inputType: TextInputType.emailAddress,
                  validate: (val) {
                    return null;
                  },
                  hintValue: "E-Mail",
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlName.value,
                  inputType: TextInputType.text,
                  validate: (val) {
                    if (val!.isEmpty) {
                      return "Name can't be empty.";
                    } else {
                      return null;
                    }
                  },
                  hintValue: "Name",
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlAddress.value,
                  inputType: TextInputType.streetAddress,
                  validate: (val) {
                    if (val!.isEmpty) {
                      return "Address can't be empty.";
                    } else {
                      return null;
                    }
                  },
                  hintValue: "Address",
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlMachineName.value,
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
                  controllerValue: controller.ctlMachineDescription.value,
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
                  controllerValue: controller.ctlMachineSizeWeightLitter.value,
                  inputType: TextInputType.text,
                  rOnly: true,
                  validate: (val) {
                    return null;
                  },
                  hintValue: "Size / Weight / Litter",
                ),
                const SizedBox(
                  height: 15,
                ),
                StepperTextField(
                  controllerValue: controller.ctlComplaint.value,
                  inputType: TextInputType.text,
                  validate: (val) {
                    if (val!.isEmpty) {
                      return "Complaint can't be empty.";
                    } else {
                      return null;
                    }
                  },
                  hintValue: "Write Complaint here ..",
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => AppButton(
                    backColor: headingColor,
                    onPressed: controller.isBtnLoading.value
                        ? null
                        : () => controller.addComplaint(context),
                    child: controller.isBtnLoading.value
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

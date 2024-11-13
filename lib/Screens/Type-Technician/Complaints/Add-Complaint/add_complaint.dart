import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:caspro_enterprises/Widgets/app_helpers.dart';
import 'package:caspro_enterprises/Widgets/dropdown_widget.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
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
                GetBuilder<AddComplaintController>(
                  builder: (ctl) {
                    return DropDownWidget(
                      isExpand: true,
                      selectedVal: ctl.ctlMachineName.value.text,
                      onChanged: (value) =>
                          ctl.setMachineName(value.toString()),
                      labelText: "Machine name",
                      hintText: "Machine name",
                      validate: (val) {
                        if (val == null) {
                          return "Required";
                        }
                        return null;
                      },
                      dropMenuList: ctl.machineNameList,
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<AddComplaintController>(
                  builder: (ctl) {
                    return DropDownWidget(
                      isExpand: true,
                      selectedVal: ctl.ctlMachineDescription.value.text,
                      onChanged: (value) =>
                          ctl.setMachineDescription(value.toString()),
                      labelText: "Machine Description",
                      hintText: "Machine Description",
                      validate: (val) {
                        if (val == null) {
                          return "Required";
                        }
                        return null;
                      },
                      dropMenuList: ctl.machineDescriptionList,
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<AddComplaintController>(
                  builder: (ctl) {
                    return DropDownWidget(
                      isExpand: true,
                      selectedVal: ctl.ctlMachineSizeWeightLitter.value.text,
                      onChanged: (value) =>
                          ctl.setMachineSizeWeightLitter(value.toString()),
                      labelText: "Size / Weight / Litter",
                      hintText: "Size / Weight / Litter",
                      validate: (val) {
                        if (val == null) {
                          return "Required";
                        }
                        return null;
                      },
                      dropMenuList: ctl.machineSizeWeightLitterList,
                    );
                  },
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

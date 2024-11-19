import 'package:caspro_enterprises/Models/customer_model.dart';
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

import 'create_customer_controller.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  final ctl = Get.put(CreateCustomerController());

  @override
  void dispose() {
    Get.delete<CreateCustomerController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => CommonFunctions.hideKeyboard(context),
        child: Scaffold(
          appBar: commonAppBar(context: context, heading: "Create Customer"),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Form(
              key: ctl.formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TypeAheadField<CustomerModel>(
                    controller: ctl.ctlReferedId.value,
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
                              "Referal Id",
                              style: GoogleFonts.poppins(),
                            ),
                            hintText: "Referal Id",
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
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            labelStyle: GoogleFonts.poppins(
                              fontSize: Get.width * 0.034,
                              color: Colors.black,
                              letterSpacing: 1,
                            )),
                      );
                    },
                    itemBuilder: (context, bag) {
                      return ListTile(
                        title: Text(bag.custCode!),
                        subtitle: Text(bag.name!),
                      );
                    },
                    onSelected: (bag) => ctl.onSelectedBag(bag),
                  ),
                  if (ctl.selectedCustomerModel != null)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Customer : ${ctl.selectedCustomerModel!.name ?? ""}",
                          style: GoogleFonts.mukta(
                              color: purpleColor, fontWeight: FontWeight.bold),
                        )),
                  const SizedBox(
                    height: 15,
                  ),
                  StepperTextField(
                    controllerValue: ctl.ctlName.value,
                    inputType: TextInputType.name,
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
                  const SizedBox(
                    height: 15,
                  ),
                  StepperTextField(
                    controllerValue: ctl.ctlEmail.value,
                    inputType: TextInputType.emailAddress,
                    validate: (val) {
                      return null;
                    },
                    hintValue: "Email",
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
                    controllerValue: ctl.ctlGstInNumber.value,
                    inputType: TextInputType.text,
                    validate: (val) {
                      return null;
                    },
                    hintValue: "GstIn",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StepperTextField(
                    controllerValue: ctl.ctlDescription.value,
                    inputType: TextInputType.text,
                    validate: (val) {
                      return null;
                    },
                    hintValue: "Description",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StepperTextField(
                    pre: const Icon(Icons.calendar_month),
                    controllerValue: ctl.ctlJoiningDate.value,
                    inputType: TextInputType.text,
                    rOnly: true,
                    onTap: () => ctl.geFromDate(context),
                    validate: (val) {
                      return null;
                    },
                    hintValue: "Joining Date",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => AppButton(
                      backColor: headingColor,
                      onPressed: ctl.isBtnLoading.value
                          ? null
                          : () => ctl.createCustomer(context),
                      child: ctl.isBtnLoading.value
                          ? const CommonButtonLoader(indicatorColor: whiteColor)
                          : Text(
                              "Create Complaint",
                              style: GoogleFonts.poppins(color: whiteColor),
                            )))
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Add Complaint"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
            // const SizedBox(
            //   height: 15,
            // ),
            // StepperTextField(
            //   controllerValue: controller.ctlAddress.value,
            //   inputType: TextInputType.streetAddress,
            //   validate: (val) {
            //     if (val!.isEmpty) {
            //       return "Address can't be empty.";
            //     } else {
            //       return null;
            //     }
            //   },
            //   hintValue: "Address",
            // ),
          ],
        ),
      ),
    );
  }
}

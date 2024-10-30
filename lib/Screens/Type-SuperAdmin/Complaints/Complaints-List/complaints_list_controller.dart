import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintsListController extends GetxController {
  Rx<TextEditingController> ctlSearchController = TextEditingController().obs;
  Rx<TextEditingController> ctlTechnician = TextEditingController().obs;
  Rx<TextEditingController> ctlTechnicianName = TextEditingController().obs;

  GlobalKey<FormState> formKey = GlobalKey();

  Future fetchData() async {}

  RxList<dynamic> technicianList = <dynamic>[].obs;
  RxList<dynamic> filteredAreaList = <dynamic>[].obs;

  void searchArea(String query) {
    List<dynamic> results = [];
    if (query.isEmpty) {
      results = technicianList;
    } else {
      results = technicianList
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    filteredAreaList.value = results;
  }

  void onSelectArea(
      // ServiceAreaListModel serviceCity,
      ) {
    // selectedArea.value = serviceCity;
    // ctlServiceArea.value.text = serviceCity.name;
    Get.back();
  }

  @override
  void dispose() {
    ctlSearchController.value.text;
    ctlTechnician.value.text;
    ctlTechnicianName.value.text;
    super.dispose();
  }

  assignTechnician(BuildContext context) {
    ctlTechnician.value.clear();
    ctlTechnicianName.value.clear();
    searchArea("");

    // if (selectedService.value == null) {
    //   CommonFunctions.showGetxSnackBar("Select Service",
    //       msg: "Select one of service to continue.",
    //       backColor: headingColor,
    //       position: SnackPosition.TOP);
    //   return;
    // }
    Get.bottomSheet(Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Assign Technician",
              style: GoogleFonts.mukta(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: headingColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StepperTextField(
              pre: const Icon(
                CupertinoIcons.person,
                color: iconColor,
              ),
              controllerValue: ctlTechnician.value,
              rOnly: true,
              onTap: () => CommonFunctions().stateCityAreaDialogue(
                  titleEndIcon: const Icon(
                    CupertinoIcons.person,
                    color: blackColor,
                  ),
                  serachHint: "search ...",
                  context: context,
                  title: "Choose Technician",
                  controller: ctlTechnicianName.value,
                  onChange: (p0) => searchArea(p0),
                  listWidget: Obx(() => Expanded(
                        child: NotificationListener<UserScrollNotification>(
                            onNotification:
                                (UserScrollNotification notification) {
                              if (notification.direction !=
                                  ScrollDirection.idle) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                              return false;
                            },
                            child: ListView.builder(
                                itemCount: filteredAreaList.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data = filteredAreaList[index];
                                  return InkWell(
                                    onTap: () => onSelectArea(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(data.name.toString(),
                                          style: GoogleFonts.mukta(
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  );
                                })),
                      ))),
              validate: (val) {
                if (val!.isEmpty) {
                  return "Technician is required.";
                }
                return null;
              },
              hintValue: "Technician",
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: const Color(0xFF0dcaf0),
                        padding: const EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();

                      if (!isValid) {
                        return;
                      }

                      Get.back();

                      // Get.toNamed(RouteNames.introScreenTwo, arguments: {
                      //   "service_id": selectedService.value!.id,
                      //   "area_id": selectedArea.value!.id,
                      // });
                    },
                    child: Text(
                      "Assign",
                      style: GoogleFonts.mukta(color: whiteColor),
                    ))),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}

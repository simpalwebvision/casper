import 'dart:convert';

import 'package:caspro_enterprises/Models/complaint_model.dart';
import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:caspro_enterprises/Repository/complaint_repository.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintsListController extends GetxController {
  ComplaintRepository complaintRepository = ComplaintRepository();
  AuthRepository authRepository = AuthRepository();
  Rx<TextEditingController> ctlSearchController = TextEditingController().obs;
  Rx<TextEditingController> ctlTechnician = TextEditingController().obs;
  Rx<TextEditingController> ctlTechnicianName = TextEditingController().obs;

  GlobalKey<FormState> formKey = GlobalKey();

  RxList<ComplaintModel> complaintList = <ComplaintModel>[].obs;
  RxList<ComplaintModel> searchResultList = <ComplaintModel>[].obs;

  RxBool isLoading = false.obs;
  loadingFun(bool val) => isLoading.value = val;

  Future fetchData() async {
    loadingFun(true);
    var response = await complaintRepository.getComplaint("Pending");

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      loadingFun(false);
    }, (data) {
      complaintList.value = data;
      searchResulList();
    });
  }

  Future getTechnicianList() async {
    loadingFun(true);
    var response = await authRepository.getTechincianList();

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      loadingFun(false);
    }, (data) {
      technicianList.value = data;
      searchResulList();
    });
  }

  onSearchChanged() => searchResulList();
  searchResulList() {
    List<ComplaintModel> showResult = [];
    if (ctlSearchController.value.text != '') {
      showResult = complaintList.where((prod) {
        var name = prod.name!.toLowerCase();
        var email = prod.mobile!.toLowerCase();

        return name.contains(ctlSearchController.value.text.toLowerCase()) ||
            email.contains(ctlSearchController.value.text.toLowerCase());
      }).toList();
    } else {
      showResult = List.from(complaintList);
    }

    searchResultList.value = showResult;
    loadingFun(false);
  }

  RxList<TechnicianProfileModel> technicianList =
      <TechnicianProfileModel>[].obs;
  RxList<TechnicianProfileModel> filteredAreaList =
      <TechnicianProfileModel>[].obs;

  void searchArea(String query) {
    List<TechnicianProfileModel> results = [];
    if (query.isEmpty) {
      results = technicianList;
    } else {
      results = technicianList
          .where(
              (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    filteredAreaList.value = results;
  }

  TechnicianProfileModel selectedTechnician = TechnicianProfileModel();

  void onSelectTechnician(
    TechnicianProfileModel technician,
  ) {
    ctlTechnician.value.text = technician.name ?? "";
    ctlTechnicianName.value.text = technician.name ?? "";
    selectedTechnician = technician;
    Get.back();
  }

  @override
  void onInit() {
    ctlSearchController.value.addListener(onSearchChanged);
    initData();
    super.onInit();
  }

  initData() async => await Future.wait([getTechnicianList(), fetchData()]);

  @override
  void dispose() {
    ctlSearchController.value.text;
    ctlTechnician.value.text;
    ctlTechnicianName.value.text;
    super.dispose();
  }

  assignTechnician(BuildContext context, ComplaintModel complaint) {
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
              style: GoogleFonts.poppins(
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
                                    onTap: () => onSelectTechnician(data),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(data.name.toString(),
                                          style: GoogleFonts.poppins(
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
                      assignTechnicianToComplaint(complaint);
                    },
                    child: Text(
                      "Assign",
                      style: GoogleFonts.poppins(color: whiteColor),
                    ))),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  RxBool assigningBool = false.obs;
  assigningBoolFun(bool val) => assigningBool.value = val;

  Future assignTechnicianToComplaint(ComplaintModel complaint) async {
    assigningBoolFun(true);

    var passedBody = json.encode({
      "id": complaint.id!,
      "created_by": selectedTechnician.id,
      "status": "Pending",
      "type": "Technician"
    });

    var response = await complaintRepository.updateComplaint(passedBody);

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      assigningBoolFun(false);
    }, (data) {
      if (data.statusCode == 200) {
        var decodedData = json.decode(data.body);

        if (decodedData["response"]) {
          Get.back();
          CommonFunctions.showGetxSnackBar("Success",
              msg: "Assigned technician.", backColor: successColor);
        } else {
          CommonFunctions.showGetxSnackBar(
            "Error",
            msg: decodedData["msg"],
          );
        }
      } else {
        CommonFunctions.showGetxSnackBar(
          "Error",
          msg: "Something went wrong. try again later.",
        );
      }
      assigningBoolFun(false);
    });
  }
}

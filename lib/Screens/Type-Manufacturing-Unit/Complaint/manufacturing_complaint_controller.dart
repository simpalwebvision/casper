import 'dart:convert';

import 'package:caspro_enterprises/Models/complaint_model.dart';
import 'package:caspro_enterprises/Repository/complaint_repository.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:caspro_enterprises/Widgets/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ManufacturingComplaintController extends GetxController {
  ComplaintRepository complaintRepository = ComplaintRepository();
  Rx<TextEditingController> ctlSearchController = TextEditingController().obs;
  RxList<ComplaintModel> complaintList = <ComplaintModel>[].obs;
  RxList<ComplaintModel> searchResultList = <ComplaintModel>[].obs;

  RxBool isLoading = false.obs;
  loadingFun(bool val) => isLoading.value = val;

  Future fetchData() async {
    loadingFun(true);
    var response = await complaintRepository.getComplaint("Machine");

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      loadingFun(false);
    }, (data) {
      complaintList.value = data;
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

  RxBool assigningBool = false.obs;
  assigningBoolFun(bool val) => assigningBool.value = val;

  confirmationDialogue(ComplaintModel complaint) {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        backgroundColor: const Color(0xFFEDEFF4),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: "Are you sure to approve the complaint.".tr,
        titleStyle: GoogleFonts.mukta(
            fontWeight: FontWeight.bold, color: blackColor, fontSize: 18),
        content: Text(
          "you can't revert this action.".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.mukta(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppSmallButtonBorder(
                backColor: failedColor,
                onPressed: () => Get.back(),
                horizontalPadding: 20,
                borderRadius: 8,
                child: Text(
                  "Cancel",
                  style: GoogleFonts.mukta(color: whiteColor),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(
                () => AppSmallButtonBorder(
                    onPressed: () => assigningBool.value
                        ? null
                        : assignAdminToComplaint(complaint),
                    horizontalPadding: 20,
                    borderRadius: 8,
                    backColor: successColor,
                    child: assigningBool.value
                        ? const CommonButtonLoader(indicatorColor: whiteColor)
                        : Text(
                            "Confirm",
                            style: GoogleFonts.mukta(color: whiteColor),
                          )),
              )
            ],
          )
        ]);
  }

  Future assignAdminToComplaint(ComplaintModel complaint) async {
    assigningBoolFun(true);

    var passedBody = json.encode({
      "id": complaint.id!,
      "created_by": "1",
      "status": "Pending",
      "type": "1"
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
              msg: "Complaint Approved.", backColor: successColor);
          complaintList.removeWhere((comp) => comp.id == complaint.id!);
          searchResultList.removeWhere((comp) => comp.id == complaint.id!);
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

  @override
  void onInit() {
    ctlSearchController.value.addListener(onSearchChanged);
    fetchData();
    super.onInit();
  }

  @override
  void dispose() {
    ctlSearchController.value.dispose();
    super.dispose();
  }
}

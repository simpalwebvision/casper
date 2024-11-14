import 'dart:convert';

import 'package:caspro_enterprises/Models/complaint_model.dart';
import 'package:caspro_enterprises/Repository/complaint_repository.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintProceedController extends GetxController {
  ComplaintRepository complaintRepository = ComplaintRepository();
  final Rx<TextEditingController> ctlRemark = TextEditingController().obs;

  RxBool isBtnLoading = false.obs;

  btnLoadingFun(bool val) => isBtnLoading.value = val;

  Future updateComplaint(String remark) async {
    if (remark.isEmpty) {
      CommonFunctions.showGetxSnackBar("Error",
          msg: "Remark is not submitted.");

      return;
    }
    btnLoadingFun(true);

    var passedBody = json.encode(
        {"id": complaintModel.id!, "remark": "remark", "status": "Complete"});

    var response = await complaintRepository.updateComplaint(passedBody);

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      btnLoadingFun(false);
    }, (data) {
      if (data.statusCode == 200) {
        var decodedData = json.decode(data.body);

        if (decodedData["response"]) {
          Get.back();
          CommonFunctions.showGetxSnackBar("Success",
              msg: decodedData["msg"], backColor: successColor);
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
      btnLoadingFun(false);
    });
  }

  ComplaintModel complaintModel = ComplaintModel();

  @override
  void onInit() {
    var data = Get.arguments;
    complaintModel = data['complain_model'] as ComplaintModel;
    super.onInit();
  }
}

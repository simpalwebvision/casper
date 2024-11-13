import 'dart:convert';

import 'package:caspro_enterprises/Models/machine_model.dart';
import 'package:caspro_enterprises/Repository/complaint_repository.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddComplaintController extends GetxController {
  ComplaintRepository complaintRepository = ComplaintRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  RxBool isBtnLoading = false.obs;

  onBtnLoading(bool val) => isBtnLoading.value = val;

  final Rx<TextEditingController> ctlNumber = TextEditingController().obs;
  final Rx<TextEditingController> ctlName = TextEditingController().obs;
  final Rx<TextEditingController> ctlAddress = TextEditingController().obs;
  final Rx<TextEditingController> ctlMachineName = TextEditingController().obs;
  final Rx<TextEditingController> ctlEmail = TextEditingController().obs;

  final Rx<TextEditingController> ctlMachineDescription =
      TextEditingController().obs;
  final Rx<TextEditingController> ctlComplaint = TextEditingController().obs;

  final Rx<TextEditingController> ctlMachineSizeWeightLitter =
      TextEditingController().obs;

  RxList<MachineModel> machineList = <MachineModel>[].obs;
  RxList<String> machineNameList = <String>[].obs;
  RxList<String> machineDescriptionList = <String>[].obs;
  RxList<String> machineSizeWeightLitterList = <String>[].obs;

  Future<List<MachineModel>> loadMachines() async {
    final String response = await rootBundle.loadString('assets/machines.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => MachineModel.fromJson(json)).toList();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    machineList.value = await loadMachines();
    machineNameList.value =
        machineList.map((e) => e.machineName).toSet().toList();

    machineDescriptionList.value = machineList
        .map((e) => e.machineDescription)
        .where((description) => description.isNotEmpty)
        .toSet()
        .toList();

    machineSizeWeightLitterList.value = machineList
        .map((e) => e.machineSizeWeightLitter)
        .where((machineSizeWeightLitter) => machineSizeWeightLitter.isNotEmpty)
        .toSet()
        .toList();

    update();
  }

  setMachineName(String val) {
    ctlMachineName.value.text = val;
    // List<MachineModel> selectedMachines = machineList
    //     .where((e) => e.machineName == val && e.machineName.isNotEmpty)
    //     .toSet()
    //     .toList();

    // machineDescriptionList.value = selectedMachines
    //     .map((e) => e.machineDescription)
    //     .where((description) => description.isNotEmpty)
    //     .toSet()
    //     .toList();

    // update();
  }

  setMachineDescription(String val) {
    ctlMachineDescription.value.text = val;

    // List<MachineModel> selectedMachines = machineList
    //     .where((e) =>
    //         e.machineDescription == val && e.machineDescription.isNotEmpty)
    //     .toSet()
    //     .toList();

    // machineSizeWeightLitterList.value = selectedMachines
    //     .map((e) => e.machineSizeWeightLitter)
    //     .where((machineSizeWeightLitter) => machineSizeWeightLitter.isNotEmpty)
    //     .toSet()
    //     .toList();

    // update();
  }

  setMachineSizeWeightLitter(String val) =>
      ctlMachineSizeWeightLitter.value.text = val;

  Future addComplaint(BuildContext context) async {
    CommonFunctions.hideKeyboard(context);
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    onBtnLoading(true);

    String userId = await LocalPreferences().getUserid() ?? "";
    String userType = await LocalPreferences().getUserType() ?? "";

    var passedBody = json.encode({
      "name": ctlName.value.text,
      "email": ctlEmail.value.text,
      "mobile": ctlNumber.value.text,
      "address": ctlAddress.value.text,
      "machine_name": ctlMachineName.value.text,
      "machine_description": ctlMachineDescription.value.text,
      "machine_size_weight_litter": ctlMachineSizeWeightLitter.value.text,
      "complain": ctlComplaint.value.text,
      "created_at": CommonFunctions.returnCreatedAtFormat(),
      "type": userType,
      "created_by": userId
    });

    var response = await complaintRepository.addComplaint(passedBody);

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      onBtnLoading(false);
    }, (data) {
      if (data.statusCode == 200) {
        var decodedData = json.decode(data.body);

        if (decodedData['response']) {
          Get.back();
          CommonFunctions.showGetxSnackBar("Success",
              msg: decodedData['msg'], backColor: successColor);
        } else {
          CommonFunctions.showGetxSnackBar("Error",
              msg: "Something went wrong.");
        }
      } else {
        CommonFunctions.showGetxSnackBar("Error", msg: "Something went wrong.");
      }
      onBtnLoading(false);
    });
  }

  @override
  void dispose() {
    ctlNumber.value.dispose();
    ctlName.value.dispose();
    ctlAddress.value.dispose();
    ctlEmail.value.dispose();
    ctlMachineName.value.dispose();
    ctlMachineDescription.value.dispose();
    ctlMachineSizeWeightLitter.value.dispose();
    ctlComplaint.value.dispose();
    super.dispose();
  }
}

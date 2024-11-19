import 'dart:convert';

import 'package:caspro_enterprises/Models/machine_model.dart';
import 'package:caspro_enterprises/Repository/complaint_repository.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddComplaintController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  ComplaintRepository complaintRepository = ComplaintRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  RxBool isBtnLoading = false.obs, hideShowOrder = false.obs;
  String from = "";
  onBtnLoading(bool val) => isBtnLoading.value = val;

  onChangeTab(value) {
    if (from == "technician") {
      return;
    }
    tabController.index = value;
    if (value == 0) {
      hideShowOrder.value = true;
    } else {
      hideShowOrder.value = false;
    }
    update();
  }

  final Rx<TextEditingController> ctlNumber = TextEditingController().obs;
  final Rx<TextEditingController> ctlName = TextEditingController().obs;
  final Rx<TextEditingController> ctlAddress = TextEditingController().obs;
  final Rx<TextEditingController> ctlMachineCode = TextEditingController().obs;
  final Rx<TextEditingController> ctlBagCode = TextEditingController().obs;
  final Rx<TextEditingController> ctlMachineName = TextEditingController().obs;
  final Rx<TextEditingController> ctlEmail = TextEditingController().obs;

  final Rx<TextEditingController> ctlMachineDescription =
      TextEditingController().obs;
  final Rx<TextEditingController> ctlComplaint = TextEditingController().obs;

  final Rx<TextEditingController> ctlMachineSizeWeightLitter =
      TextEditingController().obs;

  RxList<MachineModel> machineList = <MachineModel>[].obs;
  RxList<BagModel> bagList = <BagModel>[].obs;

  @override
  void onInit() {
    var data = Get.arguments;

    from = data["from"];
    tabController = TabController(length: 2, vsync: this);
    initData();
    super.onInit();
  }

  initData() async {
    machineList.value = await CommonFunctions().getMachineList();
    bagList.value = await CommonFunctions().getBagList();
    update();
  }

  onSelected(MachineModel machine) {
    ctlMachineCode.value.text = machine.name!;
    ctlMachineName.value.text = machine.name!;
    ctlMachineDescription.value.text = machine.description!;
    ctlMachineSizeWeightLitter.value.text = machine.size!;

    update();
  }

  List<MachineModel> searchMachines(String query) {
    return machineList.where((machine) {
      return machine.machineCode!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  onSelectedBag(BagModel bag) {
    ctlBagCode.value.text = bag.machineName!;
    ctlMachineName.value.text = bag.machineName!;
    ctlMachineDescription.value.text = bag.module!;
    ctlMachineSizeWeightLitter.value.text = bag.size!;

    update();
  }

  List<BagModel> searchBag(String query) {
    return bagList.where((bag) {
      return bag.machineName!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

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
    ctlMachineCode.value.dispose();
    ctlBagCode.value.dispose();
    super.dispose();
  }
}

import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AuthRepository authRepository = AuthRepository();
  late TabController tabController;
  Rx<TextEditingController> ctlSearchController = TextEditingController().obs;

  RxBool isSelectTechincian = false.obs;

  RxBool isTechnicianLoading = false.obs;
  techListLoadingFun(bool val) => isTechnicianLoading.value = val;

  RxList<TechnicianProfileModel> technicianList =
      <TechnicianProfileModel>[].obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);

    initData();
    super.onInit();
  }

  initData() async {
    await Future.wait([getTechnicianList()]);
  }

  Future getTechnicianList() async {
    techListLoadingFun(true);
    var response = await authRepository.getTechincianList();

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      techListLoadingFun(false);
    }, (data) {
      technicianList.value = data;
      techListLoadingFun(false);
    });
  }

  onChangeTab(value) {
    tabController.index = value;
    if (value == 0) {
      isSelectTechincian.value = false;
    } else {
      isSelectTechincian.value = true;
    }
  }

  @override
  void dispose() {
    ctlSearchController.value.text;
    super.dispose();
  }
}

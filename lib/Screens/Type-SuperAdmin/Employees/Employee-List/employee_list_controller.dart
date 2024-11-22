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

  RxBool isTechnicianLoading = false.obs, isEmployeeLoading = false.obs;
  techListLoadingFun(bool val) => isTechnicianLoading.value = val;
  techmployeeLoadingFun(bool val) => isEmployeeLoading.value = val;

  RxList<TechnicianProfileModel> technicianList =
      <TechnicianProfileModel>[].obs;

  RxList<EmployeeProfileModel> employeeList = <EmployeeProfileModel>[].obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);

    initData();
    super.onInit();
  }

  initData() async {
    await Future.wait([getTechnicianList(), getEmployeeList()]);
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

  Future getEmployeeList() async {
    techmployeeLoadingFun(true);
    var response = await authRepository.getEmployeeList();

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      techmployeeLoadingFun(false);
    }, (data) {
      employeeList.value = data;
      techmployeeLoadingFun(false);
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

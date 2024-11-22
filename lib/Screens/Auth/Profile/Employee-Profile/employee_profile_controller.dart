import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeProfileController extends GetxController {
  RxBool btnIsLoading = false.obs;
  final Rx<TextEditingController> ctlEmail = TextEditingController().obs;
  final Rx<TextEditingController> ctlMobile = TextEditingController().obs;
  final Rx<TextEditingController> ctlName = TextEditingController().obs;
  final Rx<TextEditingController> ctlType = TextEditingController().obs;

  Rxn<EmployeeProfileModel> employeeProfileModel = Rxn<EmployeeProfileModel>();

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  btnLoadingFun(bool val) {
    btnIsLoading.value = val;
  }

  getProfileData() async {
    employeeProfileModel.value =
        await CommonFunctions().getEmployeeProfileData();

    ctlEmail.value.text = employeeProfileModel.value!.email ?? "";
    ctlMobile.value.text = employeeProfileModel.value!.mobile ?? "";
    ctlName.value.text = employeeProfileModel.value!.fullname ?? "";
    ctlType.value.text = employeeProfileModel.value!.type ?? "";
  }

  // Future updateProfile(
  //   dynamic document,
  // ) async {
  //   btnLoadingFun(true);
  //   UserProfileModel userProfileModel =
  //       await CommonFunctions().getProfileData();
  //   dio.FormData formData = dio.FormData.fromMap({
  //     'id': userProfileModel.id,
  //     "image": await dio.MultipartFile.fromFile(
  //       document.path,
  //     ),
  //   });

  //   var result = await authRepository.updateProfile(formData);

  //   result.fold((error) {
  //     CommonFunctions.showErrorSnackbar(error.message);
  //     btnLoadingFun(false);
  //   }, (data) {
  //     if (data != null) {
  //       if (data.data['response'] == false) {
  //         btnLoadingFun(false);
  //         CommonFunctions.showErrorSnackbar(data.data['msg']);
  //       } else {
  //         btnLoadingFun(false);
  //         CommonFunctions.showSuccessSnackbar("Profile Updated.");
  //         Get.back();
  //       }
  //     }
  //   });
  // }

  @override
  void dispose() {
    ctlEmail.value.dispose();
    ctlMobile.value.dispose();
    ctlName.value.dispose();
    ctlType.value.dispose();
    super.dispose();
  }
}

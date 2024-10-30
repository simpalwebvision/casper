import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool btnIsLoading = false.obs;
  final Rx<TextEditingController> ctlEmail = TextEditingController().obs;
  final Rx<TextEditingController> ctlMobile = TextEditingController().obs;
  final Rx<TextEditingController> ctlName = TextEditingController().obs;
  final Rx<TextEditingController> ctlAddress = TextEditingController().obs;
  final Rx<TextEditingController> ctlTechCode = TextEditingController().obs;

  // Rxn<UserProfileModel> userProfileModel = Rxn<UserProfileModel>();

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  btnLoadingFun(bool val) {
    btnIsLoading.value = val;
  }

  getProfileData() async {
    // userProfileModel.value = await CommonFunctions().getProfileData();

    // ctlEmail.value.text = userProfileModel.value!.email ?? "";
    // ctlMobile.value.text = userProfileModel.value!.mobile ?? "";
    // ctlName.value.text = userProfileModel.value!.name ?? "";
    // ctlAddress.value.text = userProfileModel.value!.address ?? "";
    // ctlTechCode.value.text = userProfileModel.value!.technicianCode ?? "";
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
}

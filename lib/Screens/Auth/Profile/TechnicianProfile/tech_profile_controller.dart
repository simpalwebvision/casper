import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class TechProfileController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  RxBool btnIsLoading = false.obs;
  final Rx<TextEditingController> ctlEmail = TextEditingController().obs;
  final Rx<TextEditingController> ctlMobile = TextEditingController().obs;
  final Rx<TextEditingController> ctlName = TextEditingController().obs;
  final Rx<TextEditingController> ctlAddress = TextEditingController().obs;
  final Rx<TextEditingController> ctlTechCode = TextEditingController().obs;

  Rxn<TechnicianProfileModel> userProfileModel = Rxn<TechnicianProfileModel>();

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  btnLoadingFun(bool val) {
    btnIsLoading.value = val;
  }

  getProfileData() async {
    userProfileModel.value = await CommonFunctions().getTechnicianProfileData();

    ctlEmail.value.text = userProfileModel.value!.email ?? "";
    ctlMobile.value.text = userProfileModel.value!.mobile ?? "";
    ctlName.value.text = userProfileModel.value!.name ?? "";
    ctlAddress.value.text = userProfileModel.value!.address ?? "";
    ctlTechCode.value.text = userProfileModel.value!.technicianCode ?? "";
  }

  Future updateProfile(
    dynamic document,
  ) async {
    btnLoadingFun(true);
    TechnicianProfileModel userProfileModel =
        await CommonFunctions().getTechnicianProfileData();
    dio.FormData formData = dio.FormData.fromMap({
      'id': userProfileModel.id,
      "image": await dio.MultipartFile.fromFile(
        document.path,
      ),
    });

    var result = await authRepository.updateProfile(formData);

    result.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      btnLoadingFun(false);
    }, (data) {
      if (data != null) {
        if (data.data['response'] == false) {
          btnLoadingFun(false);
          CommonFunctions.showGetxSnackBar("Error", msg: data.data['msg']);
        } else {
          btnLoadingFun(false);
          CommonFunctions.showGetxSnackBar("", msg: "Success");

          Get.back();
        }
      }
    });
  }
}

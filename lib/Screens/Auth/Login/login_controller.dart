import 'dart:convert';

import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/local_shared_preferences.dart';

//Todo Type (1) : Admin
//Todo Type (2) : Staff
//Todo Type (3) : Manufacturing Unit
//Todo Type (Technician) : Technician

class LoginController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  final Rx<TextEditingController> ctlMobile = TextEditingController().obs;
  final Rx<TextEditingController> ctlPassword = TextEditingController().obs;

  RxBool isLoggingIn = false.obs;
  isLogging(bool val) => isLoggingIn.value = val;

  RxBool showHidePass = true.obs;
  RxString errorEmailText = "".obs;
  RxString errorPasswordText = "".obs;

  void changeShowhidePass() => showHidePass.value = !showHidePass.value;

  void clearPass() => ctlPassword.value.clear();

  Future<void> login() async {
    isLogging(true);

    var passedData = json.encode({
      "mobile": ctlMobile.value.text,
      "password": ctlPassword.value.text,
    });
    var result = await authRepository.loginUser(passedData);

    result.fold((error) {
      isLogging(false);
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
    }, (data) async {
      errorEmailText.value = "";
      errorPasswordText.value = "";

      if (data != null) {
        var responseJson = json.decode(data.body);

        if (data.statusCode == 400) {
          isLogging(false);
          if (responseJson['msg'] == "Validation Error") {
            responseJson['errors'].forEach((k, v) {
              if (k == "email") {
                errorEmailText.value = v;
              }
              if (k == "password") {
                errorPasswordText.value = v;
              }
              if (k == "technician_code") {
                errorEmailText.value = v;
              }
            });
          } else {
            CommonFunctions.showGetxSnackBar("Error", msg: responseJson['msg']);

            isLogging(false);
          }
        } else if (data.statusCode == 200) {
          await LocalPreferences().setUserType(responseJson['Type']);
          await LocalPreferences().setUserid(responseJson['data']["id"]);
          if (responseJson['Type'] == "1") {
            await LocalPreferences().setAdminLoginBool(true);
            Get.offAllNamed(RouteNames.superAdminHomeScreen);
          } else if (responseJson['Type'] == "3") {
            await LocalPreferences().setManufacturingUnitLoginBool(true);
            Get.offAllNamed(RouteNames.manufacturingUnitHomeScreen);
          } else if (responseJson['Type'] == "Technician") {
            await LocalPreferences().setTechnicianLoginBool(true);
            Get.offAllNamed(RouteNames.technicianHomeScreen);
          }

          isLogging(false);
        }
      }
    });
  }

  @override
  void onInit() {
    //! Admin
    // ctlMobile.value.text = "9049623444";
    //! Manufacturing Unit
    // ctlMobile.value.text = "9670451991";
    //! Technician
    ctlMobile.value.text = "9324592094";
    ctlPassword.value.text = "12345";
    super.onInit();
  }

  @override
  void dispose() {
    ctlMobile.value.dispose();
    ctlPassword.value.dispose();
    super.dispose();
  }
}

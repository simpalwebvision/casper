import 'dart:convert';

import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  final Rx<TextEditingController> ctlEmail = TextEditingController().obs;
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
      "email": ctlEmail.value.text,
      "password": ctlPassword.value.text,
    });
    var result = await authRepository.loginUser(passedData);

    result.fold((error) {
      isLogging(false);
      CommonFunctions.showErrorSnackbar(error.message);
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
            CommonFunctions.showErrorSnackbar(responseJson['msg']);
            isLogging(false);
          }
        } else if (data.statusCode == 200) {
          await LocalPreferences().setLoginBool(true);

          isLogging(false);
          //   Get.offAllNamed(RouteNames.homeScreen);
        }
      }
    });
  }

  @override
  void onInit() {
    ctlEmail.value.text = "sunil@gmail.com";
    ctlPassword.value.text = "12345";
    super.onInit();
  }

  @override
  void dispose() {
    ctlEmail.value.dispose();
    ctlPassword.value.dispose();
    super.dispose();
  }
}

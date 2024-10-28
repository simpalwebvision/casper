import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Rx<TextEditingController> ctlEmail = TextEditingController().obs;
  final Rx<TextEditingController> ctlPassword = TextEditingController().obs;

  RxBool isLoggingIn = false.obs;
  isLogging(bool val) => isLoggingIn.value = val;

  RxBool showHidePass = true.obs;
  RxString errorEmailText = "".obs;
  RxString errorPasswordText = "".obs;

  void changeShowhidePass() => showHidePass.value = !showHidePass.value;

  void clearPass() => ctlPassword.value.clear();

  @override
  void dispose() {
    ctlEmail.value.dispose();
    ctlPassword.value.dispose();
    super.dispose();
  }
}

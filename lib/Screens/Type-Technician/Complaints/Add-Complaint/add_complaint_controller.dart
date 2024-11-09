import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddComplaintController extends GetxController {
  final Rx<TextEditingController> ctlNumber = TextEditingController().obs;
  final Rx<TextEditingController> ctlName = TextEditingController().obs;
  final Rx<TextEditingController> ctlAddress = TextEditingController().obs;

  @override
  void dispose() {
    ctlNumber.value.dispose();
    ctlName.value.dispose();
    ctlAddress.value.dispose();
    super.dispose();
  }
}

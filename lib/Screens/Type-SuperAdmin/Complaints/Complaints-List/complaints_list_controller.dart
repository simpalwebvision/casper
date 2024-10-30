import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsListController extends GetxController {
  Rx<TextEditingController> ctlSearchController = TextEditingController().obs;

  Future fetchData() async {}

  @override
  void dispose() {
    ctlSearchController.value.text;
    super.dispose();
  }
}

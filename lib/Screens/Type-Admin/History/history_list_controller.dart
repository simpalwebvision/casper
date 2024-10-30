import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryListController extends GetxController {
  Rx<TextEditingController> ctlSearchController = TextEditingController().obs;

  DateTime? fromDate, uptoDate;

  Rx<TextEditingController> ctlFromDate = TextEditingController().obs;
  Rx<TextEditingController> ctlUptoDate = TextEditingController().obs;

  Future<void> geFromDate(BuildContext context) async {
    List pickedDate = await CommonFunctions().pickDate(context, fromDate);

    ctlFromDate.value.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    fromDate = pickedDate[1];
  }

  Future<void> geToDate(BuildContext context) async {
    List pickedDate = await CommonFunctions().pickDate(context, uptoDate);

    ctlUptoDate.value.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    uptoDate = pickedDate[1];
  }

  Future fetchData() async {}

  @override
  void dispose() {
    ctlSearchController.value.text;
    super.dispose();
  }
}

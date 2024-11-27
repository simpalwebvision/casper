import 'dart:io';

import 'package:caspro_enterprises/Models/expense_model.dart';
import 'package:caspro_enterprises/Models/pur_model.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/pdf_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum TravelType { startJourney, returnJourney }

class EditExpenseController extends GetxController {
  // HomeRepository homeRepository = HomeRepository();
  // ExpenseRepository expenseRepository = ExpenseRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  RxBool isSubmitting = false.obs;
  RxBool serviceCheck = false.obs;
  RxBool isInitData = true.obs;
  loadingFun(bool val) => isInitData.value = val;

  Rx<TextEditingController> ctlCallDate = TextEditingController().obs;
  Rx<TextEditingController> ctlCustomerName = TextEditingController().obs;
  Rx<TextEditingController> ctlServiceTicketNo = TextEditingController().obs;
  Rx<TextEditingController> ctlMobile = TextEditingController().obs;
  Rx<TextEditingController> ctlTransportMode = TextEditingController().obs;
  Rx<TextEditingController> ctlStartFrom = TextEditingController().obs;
  Rx<TextEditingController> ctlToFrom = TextEditingController().obs;
  Rx<TextEditingController> ctlTotalExp = TextEditingController().obs;

  var selectedTravelType = TravelType.startJourney.obs;

  RxList<JourneyModel> journeyList = <JourneyModel>[].obs;

  Rxn<ExpenseModel> expenseModel = Rxn<ExpenseModel>();

  serviceChecking(bool val) => serviceCheck.value = val;
  RxList<PurMaterialModel> pickedFiles = <PurMaterialModel>[].obs;

  @override
  void onInit() {
    loadingFun(false);
    expenseModel.value = ExpenseModel();
    var data = Get.arguments;
    expenseModel.value = data['expense_model'] as ExpenseModel;
    ctlCallDate.value.text = checkNullOperatorFun(expenseModel.value!.callDate);
    ctlCustomerName.value.text =
        checkNullOperatorFun(expenseModel.value!.customerName);
    ctlServiceTicketNo.value.text =
        checkNullOperatorFun(expenseModel.value!.serviceTicketNo);
    ctlMobile.value.text = checkNullOperatorFun(expenseModel.value!.mobile);

    journeyList.addAll(expenseModel.value!.journeyString!);
    getTotalExpense();
    fillFormData();
    loadingFun(false);
    super.onInit();
  }

  fillFormData() async {
    for (var element in expenseModel.value!.receipt!) {
      File file = await PdfApi.loadNetworkFile(element);
      XFile xfile = XFile(file.path);
      pickedFiles.add(PurMaterialModel(file: xfile, imageString: element));
    }
  }

  void addJourney() {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    journeyList.add(JourneyModel(
        journeyType: selectedTravelType.value.name == "startJourney"
            ? "Start"
            : "Return",
        modeOfTransport: ctlTransportMode.value.text,
        startFrom: ctlStartFrom.value.text,
        toFrom: ctlToFrom.value.text,
        totalExpense: ctlTotalExp.value.text));
    getTotalExpense();

    formKey.currentState!.save();
    update();
    Get.back();
  }

  void editJourney(JourneyModel data) {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    data.journeyType =
        selectedTravelType.value.name == "startJourney" ? "Start" : "Return";
    data.modeOfTransport = ctlTransportMode.value.text;
    data.startFrom = ctlStartFrom.value.text;
    data.toFrom = ctlToFrom.value.text;
    data.totalExpense = ctlTotalExp.value.text;
    getTotalExpense();
    update();
    Get.back();
  }

  void deleteJourney(int index) {
    journeyList.removeAt(index);
    getTotalExpense();
  }

  fromAddJourneyForm() {
    setTravelTypeOption(TravelType.startJourney);
    ctlTransportMode.value.clear();
    ctlStartFrom.value.clear();
    ctlToFrom.value.clear();
    ctlTotalExp.value.clear();
  }

  fromEditJourneyForm(JourneyModel model) {
    if (model.journeyType == "Start") {
      setTravelTypeOption(TravelType.startJourney);
    } else {
      setTravelTypeOption(TravelType.returnJourney);
    }
    ctlTransportMode.value.text = model.modeOfTransport ?? "";
    ctlStartFrom.value.text = model.startFrom ?? "";
    ctlToFrom.value.text = model.toFrom ?? "";
    ctlTotalExp.value.text = model.totalExpense ?? "";
  }

  void setTravelTypeOption(TravelType option) =>
      selectedTravelType.value = option;

  RxString errorDetail = "".obs;

  submittingFun(bool val) => isSubmitting.value = val;

  DateTime? callDate;
  Future<void> geFromDate(BuildContext context) async {
    List pickedDate = await CommonFunctions().pickDate(
      context,
      callDate,
    );

    ctlCallDate.value.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    callDate = pickedDate[1];
  }

  selectTransport(String problem) => ctlTransportMode.value.text = problem;

  RxDouble totalExpense = 0.0.obs;

  getTotalExpense() {
    totalExpense.value = 0.0;
    totalExpense.value = journeyList.fold(
        0.0,
        (totalExpense, JourneyModel journey) =>
            totalExpense + double.parse(journey.totalExpense ?? "0.0"));
  }

  Future editClaimSheet() async {
    // submittingFun(true);
    // var passedBody = json.encode({
    //   "id": expenseModel.value!.id, //primary id
    //   "date": CommonFunctions()
    //       .convertToApplicationShowDate(ctlCallDate.value.text) // date (Y-m-d)
    // });
    // var result = await expenseRepository.editExpense(passedBody);

    // result.fold((error) {
    //   CommonFunctions.showErrorSnackbar(error.message);
    //   submittingFun(false);
    // }, (data) {
    //   if (data != null) {
    //     if (data['response'] == false) {
    //       submittingFun(false);
    //       CommonFunctions.showErrorSnackbar(data['msg']);
    //     } else {
    //       submittingFun(false);
    //       CommonFunctions.showSuccessSnackbar(data['msg']);
    //       Get.back();
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    ctlCallDate.value.dispose();
    ctlCustomerName.value.dispose();
    ctlServiceTicketNo.value.dispose();
    ctlMobile.value.dispose();
    ctlTransportMode.value.dispose();
    ctlStartFrom.value.dispose();
    ctlToFrom.value.dispose();
    ctlTotalExp.value.dispose();
    super.dispose();
  }
}

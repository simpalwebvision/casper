import 'dart:convert';

import 'package:caspro_enterprises/Models/expense_model.dart';
import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Repository/exxpense_repository.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

enum TravelType { startJourney, returnJourney }

class AddExpenseController extends GetxController {
  // HomeRepository homeRepository = HomeRepository();
  ExpenseRepository expenseRepository = ExpenseRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  RxBool isSubmitting = false.obs;

  RxBool serviceCheck = false.obs;

  Rx<TextEditingController> ctlCallDate = TextEditingController().obs;
  Rx<TextEditingController> ctlCustomerName = TextEditingController().obs;
  Rx<TextEditingController> ctlMobile = TextEditingController().obs;
  Rx<TextEditingController> ctlTransportMode = TextEditingController().obs;
  Rx<TextEditingController> ctlStartFrom = TextEditingController().obs;
  Rx<TextEditingController> ctlToFrom = TextEditingController().obs;
  Rx<TextEditingController> ctlTotalExp = TextEditingController().obs;
  Rx<TextEditingController> ctlOtherTransport = TextEditingController().obs;
  var selectedTravelType = TravelType.startJourney.obs;

  RxList<JourneyModel> journeyList = <JourneyModel>[].obs;

  serviceChecking(bool val) => serviceCheck.value = val;

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
        otherTransport: ctlOtherTransport.value.text,
        startFrom: ctlStartFrom.value.text,
        toFrom: ctlToFrom.value.text,
        totalExpense: ctlTotalExp.value.text));
    getTotalExpense();

    formKey.currentState!.save();
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
    data.otherTransport = ctlOtherTransport.value.text;
    data.startFrom = ctlStartFrom.value.text;
    data.toFrom = ctlToFrom.value.text;
    data.totalExpense = ctlTotalExp.value.text;
    getTotalExpense();
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

  selectTransport(String problem) {
    if (problem != "Other") ctlOtherTransport.value.clear();

    ctlTransportMode.value.text = problem;

    update();
  }

  RxDouble totalExpense = 0.0.obs;

  getTotalExpense() {
    totalExpense.value = 0.0;
    totalExpense.value = journeyList.fold(
        0.0,
        (totalExpense, JourneyModel journey) =>
            totalExpense + double.parse(journey.totalExpense ?? "0.0"));
  }

  // ? ------------------------------------------------------------------------------------
  // ! Receipt Image Picker
  RxList<XFile?> pickedFiles = <XFile?>[].obs;

  pickMultiAndCropImage({required String from}) async {
    final picker = ImagePicker();
    List<XFile?> files = [];
    if (from == "gallery") {
      try {
        files = await picker.pickMultiImage(imageQuality: 60);
      } catch (e) {
        //  print(e);
      }
    } else {
      final img =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      if (img != null) {
        pickedFiles.add(img);
      }
    }

    if (files.isNotEmpty) {
      pickedFiles.addAll(files);
    }
  }

  removeFromSelectedImages(XFile file) {
    pickedFiles.removeWhere((element) => file.hashCode == element!.hashCode);
  }

  // ? ------------------------------------------------------------------------------------
  // ! Check For Service Ticket Number
  RxBool errorEnable = false.obs, status = false.obs;
  RxString errorFailed = "".obs;

  Future addExpenseSheet(
    dynamic document,
  ) async {
    var journeyString = jsonEncode(journeyList.map((e) => e.toJson()).toList());

    submittingFun(true);
    await EasyLoading.show(
      status: 'Uploading ....',
      maskType: EasyLoadingMaskType.black,
    );
    TechnicianProfileModel userProfileModel =
        await CommonFunctions().getTechnicianProfileData();

    List<dio.MultipartFile> files = [];
    for (var image in pickedFiles) {
      files.add(
          await dio.MultipartFile.fromFile(image!.path, filename: image.name));
    }

    var passedBody = dio.FormData.fromMap({
      "tech_id": userProfileModel.id,
      "date": CommonFunctions()
          .convertToApplicationShowDate(ctlCallDate.value.text),
      "customer_name": ctlCustomerName.value.text,
      "mobile": ctlMobile.value.text,
      "journey_string": journeyString,
      "total_expense": totalExpense.value.toStringAsFixed(2),
      "created_at": CommonFunctions.returnCreatedAtFormat(),
      "receipt": files.isEmpty ? [] : files
    }, dio.ListFormat.multiCompatible);
    if (document != null) {
      passedBody.files.add(MapEntry(
          "receipt",
          await dio.MultipartFile.fromFile(
            document!.path,
          )));
    }

    // // print(passedBody);
    // // submittingFun(false);
    // // return;

    var result = await expenseRepository.addTechnicianExpense(passedBody);

    result.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      submittingFun(false);
      EasyLoading.dismiss();
    }, (data) async {
      if (data != null) {
        var responseJson = data.data;

        if (data.statusCode == 400) {
          EasyLoading.dismiss();
          submittingFun(false);
          if (responseJson['msg'] == "Validation Error") {
            responseJson['errors'].forEach((k, v) {
              if (k == "total_expense") {
                errorDetail.value = v;
              }
              // if (k == "password") {
              //   errorPasswordText.value = v;
              // }
              // if (k == "technician_code") {
              //   errorEmailText.value = v;
              // }
            });

            CommonFunctions.showGetxSnackBar("Error", msg: errorDetail.value);
          } else {
            CommonFunctions.showGetxSnackBar("Error",
                msg: responseJson['msg'], backColor: successColor);
            EasyLoading.dismiss();
            submittingFun(false);
          }
        } else if (data.statusCode == 200) {
          EasyLoading.dismiss();
          submittingFun(false);
          Get.back();
          CommonFunctions.showGetxSnackBar("Success",
              msg: responseJson['msg'], backColor: successColor);
        }
      }
    });
  }

  @override
  void onInit() {
    ctlCallDate.value.text =
        CommonFunctions().returnAppDateFormat(DateTime.now());
    super.onInit();
  }

  @override
  void dispose() {
    ctlCallDate.value.dispose();
    ctlCustomerName.value.dispose();
    ctlMobile.value.dispose();
    ctlTransportMode.value.dispose();
    ctlStartFrom.value.dispose();
    ctlToFrom.value.dispose();
    ctlTotalExp.value.dispose();
    super.dispose();
  }
}

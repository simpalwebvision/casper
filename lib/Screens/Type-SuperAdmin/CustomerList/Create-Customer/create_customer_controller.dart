import 'dart:convert';

import 'package:caspro_enterprises/Models/customer_model.dart';
import 'package:caspro_enterprises/Repository/customer_repository.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/local_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateCustomerController extends GetxController {
  CustomerRepository customerRepository = CustomerRepository();
  GlobalKey<FormState> formKey = GlobalKey();
  final Rx<TextEditingController> ctlName = TextEditingController().obs;
  final Rx<TextEditingController> ctlNumber = TextEditingController().obs;
  final Rx<TextEditingController> ctlEmail = TextEditingController().obs;
  final Rx<TextEditingController> ctlAddress = TextEditingController().obs;
  final Rx<TextEditingController> ctlGstInNumber = TextEditingController().obs;
  final Rx<TextEditingController> ctlReferedId = TextEditingController().obs;
  final Rx<TextEditingController> ctlDescription = TextEditingController().obs;
  final Rx<TextEditingController> ctlJoiningDate = TextEditingController().obs;

  RxBool isBtnLoading = false.obs;
  onBtnLoading(bool val) => isBtnLoading.value = val;

  DateTime? callDate;
  Future<void> geFromDate(BuildContext context) async {
    List pickedDate = await CommonFunctions().pickDate(
      context,
      callDate,
    );

    ctlJoiningDate.value.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    callDate = pickedDate[1];
  }

  CustomerModel? selectedCustomerModel;
  RxList<CustomerModel> customerList = <CustomerModel>[].obs;

  onSelectedBag(CustomerModel customer) {
    selectedCustomerModel = customer;
    ctlReferedId.value.text = customer.custCode!;

    update();
  }

  List<CustomerModel> searchBag(String query) {
    return customerList.where((bag) {
      return bag.custCode!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future createCustomer(BuildContext context) async {
    CommonFunctions.hideKeyboard(context);
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    onBtnLoading(true);

    String userId = await LocalPreferences().getUserid() ?? "";

    var passedBody = json.encode({
      "name": ctlName.value.text,
      "email": ctlEmail.value.text,
      "address": ctlAddress.value.text,
      "gstinnumber": ctlGstInNumber.value.text,
      "refered_id": ctlReferedId.value.text,
      "description": ctlDescription.value.text,
      "joining_date": callDate != null
          ? CommonFunctions().returnApiDateFormat(callDate!)
          : "", //Y-m-d
      "created_at": CommonFunctions.returnCreatedAtFormat(),
      "created_by": userId
    });

    var response = await customerRepository.addCustomer(passedBody);

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      onBtnLoading(false);
    }, (data) {
      if (data.statusCode == 200) {
        var decodedData = json.decode(data.body);

        if (decodedData['response']) {
          Get.back();
          CommonFunctions.showGetxSnackBar("Success",
              msg: decodedData['msg'], backColor: successColor);
        } else {
          CommonFunctions.showGetxSnackBar("Error",
              msg: "Something went wrong.");
        }
      } else {
        CommonFunctions.showGetxSnackBar("Error", msg: "Something went wrong.");
      }
      onBtnLoading(false);
    });
  }

  @override
  void onInit() {
    var data = Get.arguments;

    customerList.value = data["customer_list"] as List<CustomerModel>;
    callDate = DateTime.now();
    ctlJoiningDate.value.text = DateFormat('dd-MM-yyyy').format(callDate!);
    super.onInit();
  }

  @override
  void dispose() {
    ctlName.value.dispose();
    ctlEmail.value.dispose();
    ctlAddress.value.dispose();
    ctlGstInNumber.value.dispose();
    ctlReferedId.value.dispose();
    ctlDescription.value.dispose();
    ctlJoiningDate.value.dispose();
    super.dispose();
  }
}

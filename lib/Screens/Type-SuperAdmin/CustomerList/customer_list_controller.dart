import 'package:caspro_enterprises/Models/customer_model.dart';
import 'package:caspro_enterprises/Repository/customer_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerListController extends GetxController {
  CustomerRepository customerRepository = CustomerRepository();
  Rx<TextEditingController> ctlSearchController = TextEditingController().obs;
  RxList<CustomerModel> customerList = <CustomerModel>[].obs;
  RxList<CustomerModel> searchResultList = <CustomerModel>[].obs;

  RxBool isLoading = false.obs;

  loadingFun(bool val) => isLoading.value = val;

  Future fetchData() async {
    loadingFun(true);
    var response = await customerRepository.getCustomers();

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      loadingFun(false);
    }, (data) {
      customerList.value = data;
      searchResulList();
    });
  }

  onSearchChanged() => searchResulList();
  searchResulList() {
    List<CustomerModel> showResult = [];
    if (ctlSearchController.value.text != '') {
      showResult = customerList.where((prod) {
        var name = prod.name!.toLowerCase();
        var email = prod.email!.toLowerCase();

        return name.contains(ctlSearchController.value.text.toLowerCase()) ||
            email.contains(ctlSearchController.value.text.toLowerCase());
      }).toList();
    } else {
      showResult = List.from(customerList);
    }

    searchResultList.value = showResult;
    loadingFun(false);
  }

  @override
  void onInit() {
    ctlSearchController.value.addListener(onSearchChanged);
    fetchData();
    super.onInit();
  }

  @override
  void dispose() {
    ctlSearchController.value.text;
    super.dispose();
  }
}

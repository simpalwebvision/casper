import 'package:caspro_enterprises/Models/complaint_model.dart';
import 'package:caspro_enterprises/Repository/complaint_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechnicianComplaintsListController extends GetxController {
  ComplaintRepository complaintRepository = ComplaintRepository();
  Rx<TextEditingController> ctlSearchController = TextEditingController().obs;

  RxList<ComplaintModel> complaintList = <ComplaintModel>[].obs;
  RxList<ComplaintModel> searchResultList = <ComplaintModel>[].obs;

  RxBool isLoading = false.obs;

  loadingFun(bool val) => isLoading.value = val;

  Future fetchData() async {
    loadingFun(true);
    var response = await complaintRepository.getComplaint("Pending");

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      loadingFun(false);
    }, (data) {
      complaintList.value = data;
      searchResulList();
    });
  }

  onSearchChanged() => searchResulList();
  searchResulList() {
    List<ComplaintModel> showResult = [];
    if (ctlSearchController.value.text != '') {
      showResult = complaintList.where((prod) {
        var name = prod.name!.toLowerCase();
        var email = prod.mobile!.toLowerCase();

        return name.contains(ctlSearchController.value.text.toLowerCase()) ||
            email.contains(ctlSearchController.value.text.toLowerCase());
      }).toList();
    } else {
      showResult = List.from(complaintList);
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

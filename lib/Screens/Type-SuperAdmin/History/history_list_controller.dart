import 'package:caspro_enterprises/Models/complaint_model.dart';
import 'package:caspro_enterprises/Repository/complaint_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
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

  onChangeTab(value) {
    tabController.index = value;
    if (value == 0) {
      complaintList.value = completeComplaintList;
    } else if (value == 1) {
      complaintList.value = pendingComplaintList;
    } else {
      complaintList.value = machineComplaintList;
    }
    update();
  }

  ComplaintRepository complaintRepository = ComplaintRepository();

  RxBool isLoading = false.obs;
  loadingFun(bool val) => isLoading.value = val;

  RxList<ComplaintModel> complaintList = <ComplaintModel>[].obs;
  RxList<ComplaintModel> completeComplaintList = <ComplaintModel>[].obs;
  RxList<ComplaintModel> pendingComplaintList = <ComplaintModel>[].obs;
  RxList<ComplaintModel> machineComplaintList = <ComplaintModel>[].obs;

  Future fetchData() async {
    completeComplaintList.clear();
    pendingComplaintList.clear();
    machineComplaintList.clear();
    loadingFun(true);
    var response = await complaintRepository.getComplaintHistory();

    response.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      loadingFun(false);
    }, (data) {
      for (var element in data) {
        if (element.status == "Complete") {
          completeComplaintList.add(element);
        } else if (element.status == "Pending") {
          pendingComplaintList.add(element);
        } else {
          machineComplaintList.add(element);
        }
      }

      onChangeTab(tabController.index);

      loadingFun(false);
      update();
    });
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);

    fetchData();
    super.onInit();
  }
}

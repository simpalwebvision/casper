import 'package:caspro_enterprises/Models/tech_history_model.dart';
import 'package:caspro_enterprises/Repository/home_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  HomeRepository homeRepository = HomeRepository();

  RxBool isLoadingLoan = true.obs, isLoadingAdc = true.obs;

  fromType(String type) {
    getHistory(type);
  }

  final RxList<TechHistoryModel> historyList = <TechHistoryModel>[].obs;

  loadingLoanFun(bool val) => isLoadingLoan.value = val;
  loadingAdvFun(bool val) => isLoadingAdc.value = val;

  Future getHistory(String type) async {
    if (type == "LOAN") {
      loadingLoanFun(true);
    } else {
      loadingAdvFun(true);
    }

    var result = await homeRepository.getHistoryByType(type);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      if (type == "LOAN") {
        loadingLoanFun(false);
      } else {
        loadingAdvFun(false);
      }
    }, (data) {
      historyList.value = data;
      if (type == "LOAN") {
        loadingLoanFun(false);
      } else {
        loadingAdvFun(false);
      }
    });
  }
}

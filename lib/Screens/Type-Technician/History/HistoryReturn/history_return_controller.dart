import 'package:caspro_enterprises/Models/tech_history_model.dart';
import 'package:caspro_enterprises/Repository/home_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:get/get.dart';

class HistoryReturnController extends GetxController {
  HomeRepository homeRepository = HomeRepository();

  RxBool isLoading = true.obs;

  final RxList<TechHistoryModel> historyList = <TechHistoryModel>[].obs;

  loadingFun(bool val) => isLoading.value = val;

  Future getReturnHistory() async {
    loadingFun(true);

    var result = await homeRepository.getHistoryReturn();

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      loadingFun(false);
    }, (data) {
      historyList.value = data;

      loadingFun(false);
    });
  }
}

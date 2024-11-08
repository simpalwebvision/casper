import 'package:caspro_enterprises/Models/inventory_models.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController {
  // HomeRepository homeRepository = HomeRepository();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getInventoryList();
    super.onInit();
  }

  final RxList<TechnicianStockModel> inventoryList =
      <TechnicianStockModel>[].obs;

  loadingFun(bool val) => isLoading.value = val;

  Future getInventoryList() async {
    // loadingFun(true);

    // var result = await homeRepository.getTechnicianStockList();

    // result.fold((error) {
    //   CommonFunctions.showErrorSnackbar(error.message);
    //   loadingFun(false);
    // }, (data) {
    //   inventoryList.value = data;
    //   loadingFun(false);
    // });
  }
}

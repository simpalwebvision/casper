import 'package:caspro_enterprises/Models/expense_model.dart';
import 'package:caspro_enterprises/Repository/exxpense_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:get/get.dart';

class ExpenseSheetController extends GetxController {
  ExpenseRepository expenseRepository = ExpenseRepository();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getExpenseList();
    super.onInit();
  }

  final RxList<ExpenseModel> expenseList = <ExpenseModel>[].obs;

  loadingFun(bool val) => isLoading.value = val;

  Future getExpenseList() async {
    loadingFun(true);

    var result = await expenseRepository.getAllExpenseListsheet();

    result.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      loadingFun(false);
    }, (data) {
      expenseList.value = data;
      loadingFun(false);
    });
  }
}

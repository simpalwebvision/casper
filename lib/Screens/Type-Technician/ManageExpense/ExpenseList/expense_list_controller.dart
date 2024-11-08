import 'package:caspro_enterprises/Models/expense_model.dart';
import 'package:get/get.dart';

class ExpenseSheetController extends GetxController {
  // ExpenseRepository expenseRepository = ExpenseRepository();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getExpenseList();
    super.onInit();
  }

  final RxList<ExpenseModel> expenseList = <ExpenseModel>[].obs;

  loadingFun(bool val) => isLoading.value = val;

  // openJourneyDetails(ExpenseModel model, bool value) {
  //   expenseList.map((element) => element.isExpanded = false);
  //   for (int i = 0; i < expenseList.length; i++) {
  //     expenseList[i].isExpanded = false;
  //   }
  //   model.isExpanded = value;
  // }

  Future getExpenseList() async {
    // loadingFun(true);

    // var result = await expenseRepository.getAllExpenseListsheet();

    // result.fold((error) {
    //   CommonFunctions.showErrorSnackbar(error.message);
    //   loadingFun(false);
    // }, (data) {
    //   expenseList.value = data;
    //   loadingFun(false);
    // });
  }
}

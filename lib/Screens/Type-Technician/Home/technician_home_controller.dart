import 'package:caspro_enterprises/Models/technician_dashboard_model.dart';
import 'package:caspro_enterprises/Models/technician_recharge_model.dart';
import 'package:get/get.dart';

class TechnicianHomeController extends GetxController {
  RxBool isLoading = true.obs;
  loadingFun(bool val) => isLoading.value = val;

  Rxn<TechnicianRechargeModel> trainPass = Rxn<TechnicianRechargeModel>();
  Rxn<TechnicianRechargeModel> mobileRecharge = Rxn<TechnicianRechargeModel>();
  Rxn<TechnicianDashboardExpenseModel> technicianDashboardExpenseModel =
      Rxn<TechnicianDashboardExpenseModel>();

  Future<void> initData() async {
    // isLoading.value = true;
    // await getProfileData();
  }
}

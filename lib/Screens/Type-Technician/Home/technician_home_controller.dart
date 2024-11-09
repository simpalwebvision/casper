import 'package:caspro_enterprises/Models/technician_dashboard_model.dart';
import 'package:caspro_enterprises/Models/technician_recharge_model.dart';
import 'package:caspro_enterprises/Models/user_profile_model.dart';
import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:caspro_enterprises/Repository/home_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:get/get.dart';

class TechnicianHomeController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  HomeRepository homeRepository = HomeRepository();
  RxBool isLoading = true.obs;
  loadingFun(bool val) => isLoading.value = val;

  Rxn<TechnicianProfileModel> technicianProfileModel =
      Rxn<TechnicianProfileModel>();

  Rxn<TechnicianRechargeModel> trainPass = Rxn<TechnicianRechargeModel>();
  Rxn<TechnicianRechargeModel> mobileRecharge = Rxn<TechnicianRechargeModel>();
  Rxn<TechnicianDashboardExpenseModel> technicianDashboardExpenseModel =
      Rxn<TechnicianDashboardExpenseModel>();

  RxDouble claimSheetAmt = 0.0.obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    isLoading.value = true;
    await getProfileData();
  }

  Future getProfileData() async {
    loadingFun(true);

    var result = await authRepository.getProfileData();

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      loadingFun(false);
    }, (data) {
      technicianProfileModel.value = data;

      Future.wait([
        getRechargeData(),
        getTechnicianAllExpenseAmt(),
        getClaimSheetAmt(),
      ]);
    });
  }

  TechnicianRechargeModel finadByRechargeType(
      List<TechnicianRechargeModel> list, String passType) {
    try {
      return list.lastWhere((prod) => prod.rechargeType == passType);
    } catch (e) {
      return TechnicianRechargeModel();
    }
  }

  Future getRechargeData() async {
    var result = await authRepository.getRechargeData();

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      loadingFun(false);
    }, (data) {
      trainPass.value = finadByRechargeType(data, "PASS");
      mobileRecharge.value = finadByRechargeType(data, "MOBILE");

      loadingFun(false);
    });
  }

  Future getTechnicianAllExpenseAmt() async {
    var result = await homeRepository.technicianAllExpense();

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      loadingFun(false);
    }, (data) {
      technicianDashboardExpenseModel.value = data;

      loadingFun(false);
    });
  }

  Future getClaimSheetAmt() async {
    var result = await homeRepository.getClaimSheetAmt();

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      loadingFun(false);
    }, (data) {
      claimSheetAmt.value = data;

      loadingFun(false);
    });
  }
}

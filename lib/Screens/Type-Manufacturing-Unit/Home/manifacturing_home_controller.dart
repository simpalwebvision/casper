import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:get/get.dart';

class ManifacturingHomeController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  RxBool isLoading = true.obs;
  loadingFun(bool val) => isLoading.value = val;

  // Rxn<EmployeeProfileModel> employeeProfileModel = Rxn<EmployeeProfileModel>();

  Future getProfileData() async {
    loadingFun(true);

    var result = await authRepository.getEmployeeProfileData();

    result.fold((error) {
      CommonFunctions.showGetxSnackBar("Error", msg: error.message);
      loadingFun(false);
    }, (data) {
      // employeeProfileModel.value = data;
    });
  }

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }
}

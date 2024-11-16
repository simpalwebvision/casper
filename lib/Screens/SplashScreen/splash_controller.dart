import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  Future getMachineList() async => await authRepository.getMachineList();

  @override
  void onInit() {
    getMachineList();
    super.onInit();
  }
}

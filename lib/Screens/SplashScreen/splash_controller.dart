import 'package:caspro_enterprises/Repository/auth_repository.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  AuthRepository authRepository = AuthRepository();

  @override
  void onInit() {
    fetchInitData();
    super.onInit();
  }

  fetchInitData() async => await Future.wait([getMachineList(), getBagList()]);

  Future getMachineList() async => await authRepository.getMachineList();
  Future getBagList() async => await authRepository.getBagList();
}

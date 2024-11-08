import 'package:caspro_enterprises/Models/manuals_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManualsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // ManualsRepository manualsRepository = ManualsRepository();
  late AnimationController animationController;
  final RxBool isOpen = false.obs;
  RxBool isLoading = false.obs;
  loadingFun(bool val) => isLoading.value = val;

  RxList<ManualsModel> imageList = <ManualsModel>[].obs;
  RxList<ManualsModel> fileList = <ManualsModel>[].obs;

  RxInt initialIndex = 0.obs;

  onChangeTab(
    BuildContext context,
    int index,
  ) {
    initialIndex.value = index;
    DefaultTabController.of(context).animateTo(index);
  }

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    getManuals();
    super.onInit();
  }

  void toggleOpenClose() {
    isOpen.value = !isOpen.value;
    if (isOpen.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  Future getManuals() async {
    // loadingFun(true);

    // var result = await manualsRepository.getManualsList();

    // result.fold((error) {
    //   CommonFunctions.showErrorSnackbar(error.message);
    //   loadingFun(false);
    // }, (data) {
    //   imageList.value =
    //       data.where((elements) => elements.type == "Image").toList();
    //   fileList.value =
    //       data.where((elements) => elements.type == "PDF").toList();
    //   loadingFun(false);
    // });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

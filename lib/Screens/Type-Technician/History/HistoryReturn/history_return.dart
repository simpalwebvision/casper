import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../history_card.dart';
import 'history_return_controller.dart';

class LoanReturnHistory extends StatefulWidget {
  const LoanReturnHistory({super.key});

  @override
  State<LoanReturnHistory> createState() => _LoanReturnHistoryState();
}

class _LoanReturnHistoryState extends State<LoanReturnHistory> {
  HistoryReturnController controller = Get.find();
  @override
  void initState() {
    controller.getReturnHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getReturnHistory(),
      child: Obx(() => controller.isLoading.value
          ? const CommonLoader()
          : controller.historyList.isEmpty
              ? const NoDataFoundScreen(
                  image: AppImages.emptyData,
                  passedData: "No History Found",
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: controller.historyList.length,
                  itemBuilder: (context, index) {
                    var data = controller.historyList[index];
                    return HistoryCard(
                      model: data,
                    );
                  },
                )),
    );
  }
}

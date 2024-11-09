import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'history_card.dart';
import 'history_controller.dart';

class AdvanceHistory extends StatefulWidget {
  const AdvanceHistory({super.key});

  @override
  State<AdvanceHistory> createState() => _AdvanceHistoryState();
}

class _AdvanceHistoryState extends State<AdvanceHistory> {
  HistoryController controller = Get.find();
  @override
  void initState() {
    controller.getHistory("OFFICE");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getHistory("OFFICE"),
      child: Obx(() => controller.isLoadingAdc.value
          ? const Center(child: CommonLoader())
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

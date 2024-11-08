import 'package:caspro_enterprises/Screens/Type-Technician/Inventory/inventory_controller.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nb_utils/nb_utils.dart' as nb;

class InventoryList extends StatefulWidget {
  const InventoryList({super.key});

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  final controller = Get.put(InventoryController());

  @override
  void dispose() {
    nb.setStatusBarColor(whiteColor);
    Get.delete<InventoryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Inventory"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Required"),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4)),
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Not Required")
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: () => controller.getInventoryList(),
                child: Obx(
                  () => controller.isLoading.value
                      ? const CommonLoader()
                      : controller.inventoryList.isEmpty
                          ? const NoDataFoundScreen(
                              image: AppImages.emptyData,
                              passedData: "No Inventory Found",
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: controller.inventoryList.length,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              itemBuilder: (context, index) {
                                var data = controller.inventoryList[index];
                                return Card(
                                  shadowColor: blackColor,
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: borderColor),
                                      borderRadius: BorderRadius.circular(12)),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 6,
                                                color:
                                                    data.defective == "Required"
                                                        ? Colors.red
                                                        : Colors.green))),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // String totalInWords =
                                                //     NumberToWordsEnglish
                                                //         .convert(
                                                //             int.parse("2562"));
                                                // var helper = totalInWords
                                                //     .capitalizeEachWord();
                                                // print(helper);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: data.defective ==
                                                            "Required"
                                                        ? Colors.red
                                                        : Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  checkNullOperatorFun(
                                                      "Defective Type : ${data.defective}"),
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: whiteColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DetailWidgetHelper(
                                          heading: "Type",
                                          value: data.purchaseType ?? "",
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DetailWidgetHelper(
                                          heading: "Product",
                                          value: data.productName ?? "",
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DetailWidgetHelper(
                                          heading: "Model",
                                          value: data.model ?? "",
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DetailWidgetHelper(
                                          heading: "Part Code ",
                                          value: data.partCode ?? "",
                                          valueColor: primaryColor,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: MultiDetailHelper(
                                                heading: "Material Value ",
                                                value: data.materialValue ?? "",
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MultiDetailHelper(
                                              heading: "Quantity ",
                                              value: data.qty ?? "",
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DetailWidgetHelper(
                                          heading: "Part Desc",
                                          value: data.partDescription ?? "",
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DetailWidgetHelper(
                                          valueColor: Colors.green[800],
                                          heading: "Created",
                                          value: CommonFunctions()
                                              .returnAppDateFormat(
                                                  data.createdAt!),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                )),
          ),
        ],
      ),
    );
  }
}

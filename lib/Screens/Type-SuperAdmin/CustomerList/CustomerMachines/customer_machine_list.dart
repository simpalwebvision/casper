import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'customer_machine_list_controller.dart';

class CustomerMachineList extends StatefulWidget {
  const CustomerMachineList({super.key});

  @override
  State<CustomerMachineList> createState() => _CustomerMachineListState();
}

class _CustomerMachineListState extends State<CustomerMachineList> {
  final controller = Get.put(CustomerMachineListController());

  @override
  void dispose() {
    Get.delete<CustomerMachineListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Machines"),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchData(),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 15, top: 10),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: 2,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                shadowColor: blackColor,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const DetailWidgetHelper(
                        heading: "Name",
                        value: "Ultra sonic cleaner",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const DetailWidgetHelper(
                        heading: "Description",
                        value:
                            "ULTRA SONIC CLEANER MACHINE - 150 w built ss body",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const DetailWidgetHelper(
                        heading: "Size/Wgt/Litter",
                        value: "6.ltr",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const DetailWidgetHelper(
                        heading: "HSN CODE",
                        value: "8479",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: MultiDetailHelper(
                              heading: "S price",
                              value: "19000",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DetailWidgetHelper(
                              heading: "GST 18%",
                              value: "3420",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const DetailWidgetHelper(
                        heading: "GRAND TOTAL",
                        value: "22420",
                        headingColor: primaryColor,
                        valueColor: primaryColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        color: blackColor,
                      ),
                      Row(
                        children: [
                          Text(
                            "Date : ",
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "24/10/2024",
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

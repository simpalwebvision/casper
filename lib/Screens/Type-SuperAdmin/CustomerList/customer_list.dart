import 'package:caspro_enterprises/Screens/Type-SuperAdmin/CustomerList/customer_list_controller.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final controller = Get.put(CustomerListController());

  @override
  void dispose() {
    Get.delete<CustomerListController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Customers"),
      body: Column(
        children: [
          SearchTextField(
            controller: controller.ctlSearchController.value,
            hintText: 'Search here ...',
            borderColor: Colors.grey,
            focusedBorderColor: Colors.blue,
            errorBorderColor: Colors.red,
            fillColor: Colors.white,
            onChanged: (value) {
              // Handle change
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.fetchData(),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 15),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 6,
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
                              value: "Siddhant Test",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const DetailWidgetHelper(
                              heading: "Mobile",
                              value: "1234567890",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const DetailWidgetHelper(
                              heading: "Address",
                              value:
                                  "G4, Mangal Adesh Bldg, 4th Road, Off Khar Subway Rd, Santacruz (east)",
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
                                  "Created at : ",
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
                                InkWell(
                                  onTap: () => Get.toNamed(
                                      RouteNames.customerMachineList),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: headingColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.settings,
                                          color: whiteColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Machines",
                                          style: GoogleFonts.poppins(
                                              color: whiteColor),
                                        )
                                      ],
                                    ),
                                  ),
                                )
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
          ),
        ],
      ),
    );
  }
}

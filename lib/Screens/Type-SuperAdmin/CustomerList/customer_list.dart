import 'package:caspro_enterprises/Screens/Type-SuperAdmin/CustomerList/customer_list_controller.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/routes_names.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:caspro_enterprises/Widgets/no_data_found.dart';
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
                child: Obx(
                  () => controller.isLoading.value
                      ? const CommonLoader()
                      : controller.searchResultList.isEmpty
                          ? const NoDataFoundScreen(
                              image: AppImages.emptyData,
                              passedData: "No Complaint Found ..",
                            )
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 100),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: controller.searchResultList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = controller.searchResultList[index];
                                return InkWell(
                                  onTap: () {},
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    shadowColor: blackColor,
                                    clipBehavior: Clip.hardEdge,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: borderColor),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "CustId",
                                            value: data.custCode ?? "",
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Name",
                                            value: data.name ?? "",
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Mobile",
                                            value: checkNullOperatorFun(
                                                data.mobile),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Email",
                                            value: checkNullOperatorFun(
                                                data.email),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          DetailWidgetHelper(
                                            heading: "Address",
                                            value: checkNullOperatorFun(
                                                data.address),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                data.createdAt ?? "",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () => Get.toNamed(
                                                    RouteNames
                                                        .customerMachineList),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: headingColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
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
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color:
                                                                    whiteColor),
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
                )),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: secondaryColor,
        onPressed: () {
          CommonFunctions.hideKeyboard(context);
          Get.toNamed(RouteNames.createCustomerScreen,
                  arguments: {"customer_list": controller.customerList})!
              .then(
            (value) => controller.fetchData(),
          );
        },
        label: Row(
          children: [
            const Icon(
              Icons.add,
              color: whiteColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Add Customer',
              style: GoogleFonts.poppins(color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

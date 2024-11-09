import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nb_utils/nb_utils.dart' as nb;

import 'HistoryReturn/history_return.dart';
import 'HistoryReturn/history_return_controller.dart';
import 'advance_history.dart';
import 'history_controller.dart';
import 'loan_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(HistoryController());
  final controllerReturnHistory = Get.put(HistoryReturnController());
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    nb.setStatusBarColor(whiteColor);
    Get.delete<HistoryController>();
    // Get.delete<HistoryReturnController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Loan Statement"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                unselectedLabelColor: primaryColor,
                padding: const EdgeInsets.only(bottom: 5),
                controller: tabController,
                labelColor: primaryColor,
                indicatorColor: primaryColor,
                isScrollable: true,
                labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: 'Loan',
                  ),
                  Tab(
                    text: 'Advance',
                  ),
                  Tab(
                    text: 'Loan Return',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
                LoanHistory(),
                AdvanceHistory(),
                LoanReturnHistory()
              ]))
        ],
      ),
    );
  }
}

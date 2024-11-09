import 'package:caspro_enterprises/Models/tech_history_model.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/detail_widget_helper.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final TechHistoryModel model;
  const HistoryCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: blackColor,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MultiDetailHelper(
                    heading: "Pay Type ",
                    value: model.paymentMode ?? "",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MultiDetailHelper(
                  heading: "Amount ",
                  value: model.amount ?? "",
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            DetailWidgetHelper(
              heading: "Created",
              value: CommonFunctions().returnAppDateFormat(model.createdAt!),
            ),
            const SizedBox(
              height: 5,
            ),
            DetailWidgetHelper(
              heading: "Remark",
              value: model.remark ?? "",
            ),
          ],
        ),
      ),
    );
  }
}

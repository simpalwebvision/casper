import 'dart:convert';

import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Utils/remote_urls.dart';

class ExpenseModel {
  final String? id;
  final String? techId;
  final String? callDate;
  final String? customerName;
  final String? serviceTicketNo;
  final String? mobile;
  final String? totalExpense;
  final String? approvedExpense;
  final String? balanceExpense;
  final String? status;
  final String? createdAt;
  final String? remark;
  final List<String>? receipt;
  final List<JourneyModel>? journeyString;

  ExpenseModel({
    this.id,
    this.techId,
    this.callDate,
    this.customerName,
    this.serviceTicketNo,
    this.mobile,
    this.journeyString,
    this.totalExpense,
    this.approvedExpense,
    this.balanceExpense,
    this.remark,
    this.status,
    this.receipt,
    this.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    List<JourneyModel> journeyList = [];

    dynamic journeyStr = json["journey_string"];

    if (journeyStr != null && journeyStr.isNotEmpty) {
      List helperData = jsonDecode(json["journey_string"]);

      journeyList =
          helperData.map((element) => JourneyModel.fromJson(element)).toList();
    }
    var balance = "";
    if (json["total_expense"] != null && json["approved_expense"] != null) {
      var bal = double.parse(json["total_expense"]) -
          double.parse(json["approved_expense"]);
      balance = bal.toStringAsFixed(2);
    }

    return ExpenseModel(
        id: json["id"] ?? "",
        techId: json["tech_id"] ?? "",
        callDate: json["date"] == null
            ? ""
            : CommonFunctions().convertToApplicationShowDate(
                checkNullOperatorFun(json["date"])),
        customerName: checkNullOperatorFun(json["customer_name"]),
        serviceTicketNo: json["service_ticket_no"] ?? "",
        mobile: json["mobile"] ?? "",
        totalExpense: json["total_expense"] ?? "",
        approvedExpense: json["approved_expense"] ?? "",
        remark: json["remark"] ?? "",
        balanceExpense: balance,
        journeyString: journeyList,
        receipt: json["image"] == null
            ? []
            : List<String>.from(json["image"]!
                .map((x) => "${RemoteUrls.imageUrl}/${x["receipt"]}")),
        status: json["status"] ?? "",
        createdAt: json["created_at"] == null
            ? ""
            : checkNullOperatorFun(CommonFunctions()
                .returnAppDateTimeFormat(DateTime.parse(json["created_at"]))));
  }
}

class JourneyModel {
  String? journeyType;
  String? modeOfTransport;
  String? startFrom;
  String? toFrom;
  String? totalExpense;

  JourneyModel({
    this.journeyType,
    this.modeOfTransport,
    this.startFrom,
    this.toFrom,
    this.totalExpense,
  });

  factory JourneyModel.fromJson(Map<String, dynamic> json) {
    return JourneyModel(
      journeyType: json["journeyType"] ?? "",
      modeOfTransport: json["modeOfTransport"] ?? "",
      startFrom: json["startFrom"] ?? "",
      toFrom: json["toFrom"] ?? "",
      totalExpense: json["totalExpense"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "journeyType": journeyType,
        "modeOfTransport": modeOfTransport,
        "startFrom": startFrom,
        "toFrom": toFrom,
        "totalExpense": totalExpense,
      };
}

import 'package:caspro_enterprises/Utils/common_functions.dart';

class TechnicianRechargeModel {
  final String? id;
  final String? techId;
  final String? rechargeType;
  final String? fromdate;
  final String? todate;
  final String? amount;
  final String? remark;
  final bool isPassEnding;
  final bool isPassEnded;

  TechnicianRechargeModel({
    this.id,
    this.techId,
    this.rechargeType,
    this.fromdate,
    this.todate,
    this.amount,
    this.remark,
    this.isPassEnding = false,
    this.isPassEnded = false,
  });

  factory TechnicianRechargeModel.fromJson(Map<String, dynamic> json) {
    bool isPassEndingVal = false, isPassEndedVal = false;
    var todate = DateTime.now();
    if (json['todate'] != null || json['todate'] != "") {
      List<String> dateSplit = json['todate'].toString().split("-");

      DateTime rechargeTime = DateTime(int.parse(dateSplit[0]),
          int.parse(dateSplit[1]), int.parse(dateSplit[2]));

      if (rechargeTime.isBefore(todate)) {
        isPassEndedVal = true;
        isPassEndingVal = true;
      } else {
        DateTime twoDaysBeforeDate =
            rechargeTime.subtract(const Duration(days: 2));
        DateTime oneDayBeforeDate =
            rechargeTime.subtract(const Duration(days: 1));
        String todateString = CommonFunctions().returnAppDateFormat(todate);
        String twoDaysBefore =
            CommonFunctions().returnAppDateFormat(twoDaysBeforeDate);

        String oneDaysBefore =
            CommonFunctions().returnAppDateFormat(oneDayBeforeDate);

        if (todateString == twoDaysBefore || todateString == oneDaysBefore) {
          isPassEndingVal = true;
        }
      }
    }

    return TechnicianRechargeModel(
        id: json["id"] ?? "",
        techId: json["tech_id"] ?? "",
        rechargeType: json["recharge_type"] ?? "",
        fromdate: json["fromdate"] ?? "",
        todate: json["todate"] ?? "",
        amount: json["amount"] ?? "",
        remark: json["remark"] ?? "",
        isPassEnding: isPassEndingVal,
        isPassEnded: isPassEndedVal);
  }
}

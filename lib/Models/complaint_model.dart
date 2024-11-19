import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:flutter/material.dart';

class ComplaintModel {
  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? address;
  final String? machineName;
  final String? machineDescription;
  final String? machineSizeWeightLitter;
  final String? complain;
  final String? createdAt;
  final String? createdBy;
  final String? type;
  final String? status;
  final Color? statusTextColor;
  final Color? statusColor;
  final String? remark;
  final String? complainType;
  final String? machineId;
  final String? machineObject;

  ComplaintModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.address,
    this.machineName,
    this.machineDescription,
    this.machineSizeWeightLitter,
    this.complain,
    this.createdAt,
    this.createdBy,
    this.type,
    this.status,
    this.statusTextColor,
    this.statusColor,
    this.remark,
    this.complainType,
    this.machineId,
    this.machineObject,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    var defaultColor = const Color(0xFFF7CB73);
    var defaultTextColor = blackColor;
    var defaultStatus = "Pending";
    defaultStatus = json["status"];

    if (defaultStatus != "") {
      if (defaultStatus == "Pending") {
        defaultColor = const Color(0xFFF7CB73);
        defaultTextColor = blackColor;
      } else {
        defaultColor = successColor;
        defaultTextColor = whiteColor;
      }
    }
    return ComplaintModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      address: json["address"] ?? "",
      machineName: json["machine_name"] ?? "",
      machineDescription: json["machine_description"] ?? "",
      machineSizeWeightLitter: json["machine_size_weight_litter"] ?? "",
      complain: json["complain"] ?? "",
      status: defaultStatus,
      remark: json["remark"] ?? "",
      statusColor: defaultColor,
      statusTextColor: defaultTextColor,
      createdAt: json["created_at"] == null
          ? ""
          : checkNullOperatorFun(CommonFunctions()
              .returnAppDateTimeFormat(DateTime.parse(json["created_at"]))),
      createdBy: json["created_by"] ?? "",
      type: json["type"] ?? "",
      complainType: json["complain_type"] ?? "",
      machineId: json["machine_id"] ?? "",
      machineObject: json["object"] ?? "",
    );
  }
}

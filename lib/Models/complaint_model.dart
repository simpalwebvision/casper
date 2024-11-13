import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';

class ComplaintModel {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String address;
  final String machineName;
  final String machineDescription;
  final String machineSizeWeightLitter;
  final String complain;
  final String createdAt;
  final String createdBy;
  final String type;

  ComplaintModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.machineName,
    required this.machineDescription,
    required this.machineSizeWeightLitter,
    required this.complain,
    required this.createdAt,
    required this.createdBy,
    required this.type,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) => ComplaintModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        mobile: json["mobile"] ?? "",
        address: json["address"] ?? "",
        machineName: json["machine_name"] ?? "",
        machineDescription: json["machine_description"] ?? "",
        machineSizeWeightLitter: json["machine_size_weight_litter"] ?? "",
        complain: json["complain"] ?? "",
        createdAt: json["created_at"] == null
            ? ""
            : checkNullOperatorFun(CommonFunctions()
                .returnAppDateTimeFormat(DateTime.parse(json["created_at"]))),
        createdBy: json["created_by"] ?? "",
        type: json["type"] ?? "",
      );
}

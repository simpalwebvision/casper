class MachineModel {
  final String id;
  final String machineName;
  final String machineDescription;
  final String machineSizeWeightLitter;
  final String machineHsnCode;
  final String machineSellingPrice;
  final String machineGST;
  final String machineGrandTotal;

  MachineModel({
    required this.id,
    required this.machineName,
    required this.machineDescription,
    required this.machineSizeWeightLitter,
    required this.machineHsnCode,
    required this.machineSellingPrice,
    required this.machineGST,
    required this.machineGrandTotal,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) => MachineModel(
        id: json["id"],
        machineName: json["machineName"],
        machineDescription: json["machineDescription"],
        machineSizeWeightLitter: json["machineSizeWeightLitter"],
        machineHsnCode: json["machineHsnCode"],
        machineSellingPrice: json["machineSellingPrice"],
        machineGST: json["machineGST"],
        machineGrandTotal: json["machineGrandTotal"],
      );
}

class MachineNameModel {
  final String id;
  final String machineName;

  MachineNameModel({required this.id, required this.machineName});
}

class MachineDescriptionModel {
  final String id;
  final String description;
  final String mainDescriptionTitle;

  MachineDescriptionModel(
      {required this.id,
      required this.description,
      required this.mainDescriptionTitle});
}

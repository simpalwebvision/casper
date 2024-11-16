class MachineModel {
  final String? id;
  final String? name;
  final String? description;
  final String? size;
  final String? hsn;
  final String? sprice;
  final String? gst;
  final String? gtotal;
  final String? machineCode;

  MachineModel({
    this.id,
    this.name,
    this.description,
    this.size,
    this.hsn,
    this.sprice,
    this.gst,
    this.gtotal,
    this.machineCode,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) => MachineModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        size: json["size"],
        hsn: json["hsn"],
        sprice: json["sprice"],
        gst: json["gst"],
        gtotal: json["gtotal"],
        machineCode: json["machine_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "size": size,
        "hsn": hsn,
        "sprice": sprice,
        "gst": gst,
        "gtotal": gtotal,
        "machine_code": machineCode,
      };
}

class CustomerModel {
  final String? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? address;
  final String? gstinnumber;
  final String? referedId;
  final String? description;
  final String? joiningDate;
  final String? custCode;
  final String? createdAt;
  final String? createdBy;

  CustomerModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.gstinnumber,
    this.referedId,
    this.description,
    this.joiningDate,
    this.custCode,
    this.createdAt,
    this.createdBy,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        name: json["name"].toString(),
        mobile: json['mobile'] ?? "",
        email: json["email"] ?? "",
        address: json["address"] ?? "",
        gstinnumber: json["gstinnumber"] ?? "",
        referedId: json["refered_id"] ?? "",
        description: json["description"] ?? "",
        joiningDate: json["joining_date"] ?? "",
        custCode: json["cust_code"] ?? "",
        createdAt: json["created_at"],
        createdBy: json["created_by"],
      );
}

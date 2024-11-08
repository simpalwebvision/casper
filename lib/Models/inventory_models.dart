class TechnicianStockModel {
  final String? id;
  final String? purchaseType;
  final String? productName;
  final String? materialValue;
  final String? partDescription;
  final String? techId;
  final String? qty;
  final String? drQty;
  final String? customerName;
  final String? ticketNumber;
  final String? location;
  final DateTime? createdAt;
  final String? createdBy;
  final String? partCode;
  final String? model;
  final String? defective;

  TechnicianStockModel({
    this.id,
    this.purchaseType,
    this.productName,
    this.materialValue,
    this.partDescription,
    this.techId,
    this.qty,
    this.drQty,
    this.model,
    this.customerName,
    this.ticketNumber,
    this.location,
    this.createdAt,
    this.createdBy,
    this.partCode,
    this.defective,
  });

  factory TechnicianStockModel.fromJson(Map<String, dynamic> json) =>
      TechnicianStockModel(
        id: json["id"] ?? "",
        purchaseType: json["purchase_type"] ?? "",
        productName: json["product_name"] ?? "",
        materialValue: json["material_value"] ?? "",
        partDescription: json["part_description"] ?? "",
        model: json["model"] ?? "",
        techId: json["tech_id"] ?? "",
        qty: json["qty"] ?? "",
        drQty: json["DrQty"] ?? "",
        customerName: json["customer_name"] ?? "",
        ticketNumber: json["ticket_number"] ?? "",
        location: json["location"] ?? "",
        partCode: json["part_code"] ?? "",
        defective: json["defective"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "purchase_type": purchaseType,
        "product_name": productName,
        "tech_id": techId,
        "qty": qty,
        "DrQty": drQty,
        "customer_name": customerName,
        "ticket_number": ticketNumber,
        "location": location,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
      };
}

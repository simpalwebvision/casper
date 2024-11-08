class TechHistoryModel {
  final String? id;
  final String? techId;
  final String? paymentMode;
  final String? expenses;
  final String? amount;
  final String? remark;
  final DateTime? createdAt;

  TechHistoryModel({
    this.id,
    this.techId,
    this.paymentMode,
    this.expenses,
    this.amount,
    this.remark,
    this.createdAt,
  });

  factory TechHistoryModel.fromJson(Map<String, dynamic> json) =>
      TechHistoryModel(
        id: json["id"],
        techId: json["tech_id"],
        paymentMode: json["payment_mode"],
        expenses: json["expenses"],
        amount: json["amount"],
        remark: json["remark"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tech_id": techId,
        "payment_mode": paymentMode,
        "expenses": expenses,
        "amount": amount,
        "remark": remark,
        "created_at": createdAt?.toIso8601String(),
      };
}

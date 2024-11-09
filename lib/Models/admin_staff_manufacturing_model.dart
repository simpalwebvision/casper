class AdminStaffManufacturingModel {
  final String id;
  final String type;
  final String fullname;
  final String mobile;
  final String email;
  final String password;
  final String isLogin;
  final String sId;
  final String isEnable;
  final String attempt;
  final String resetCode;
  final String resetAttempt;
  final String resetValidity;
  final String image;

  AdminStaffManufacturingModel({
    required this.id,
    required this.type,
    required this.fullname,
    required this.mobile,
    required this.email,
    required this.password,
    required this.isLogin,
    required this.sId,
    required this.isEnable,
    required this.attempt,
    required this.resetCode,
    required this.resetAttempt,
    required this.resetValidity,
    required this.image,
  });

  factory AdminStaffManufacturingModel.fromJson(Map<String, dynamic> json) =>
      AdminStaffManufacturingModel(
        id: json["id"],
        type: json["type"],
        fullname: json["fullname"],
        mobile: json["mobile"],
        email: json["email"],
        password: json["password"],
        isLogin: json["isLogin"],
        sId: json["s_id"],
        isEnable: json["isEnable"],
        attempt: json["attempt"],
        resetCode: json["resetCode"],
        resetAttempt: json["resetAttempt"],
        resetValidity: json["resetValidity"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "fullname": fullname,
        "mobile": mobile,
        "email": email,
        "password": password,
        "isLogin": isLogin,
        "s_id": sId,
        "isEnable": isEnable,
        "attempt": attempt,
        "resetCode": resetCode,
        "resetAttempt": resetAttempt,
        "resetValidity": resetValidity,
        "image": image,
      };
}

import 'package:caspro_enterprises/Utils/remote_urls.dart';

class TechnicianProfileModel {
  final String? id;
  final String? technicianCode;
  final String? password;
  final String? name;
  final String? email;
  final String? mobile;
  final double? otAmt;
  final double? owAmt;
  final double? okAmt;
  final double? ltLmt;
  final double? lwAmt;
  final double? lkAmt;
  final String? address;
  final String? image;
  final String? aadharcard;
  final String? pancard;

  TechnicianProfileModel({
    this.id,
    this.technicianCode,
    this.password,
    this.name,
    this.email,
    this.mobile,
    this.otAmt,
    this.owAmt,
    this.okAmt,
    this.ltLmt,
    this.lwAmt,
    this.lkAmt,
    this.address,
    this.image,
    this.aadharcard,
    this.pancard,
  });

  factory TechnicianProfileModel.fromJson(Map<String, dynamic> json) {
    String image = json["image"].toString(), profileUrl = "";
    String aadharImage = json["aadharcard"].toString(), aadharUrl = "";
    String panImage = json["pancard"].toString(), panUrl = "";

    if (image.isEmpty || image == "null") {
      profileUrl = "";
    } else {
      profileUrl = "${RemoteUrls.imageUrl}/$image";
    }

    if (aadharImage.isEmpty || aadharImage == "null") {
      aadharUrl = "";
    } else {
      aadharUrl = "${RemoteUrls.imageUrl}/$aadharImage";
    }

    if (panImage.isEmpty || panImage == "null") {
      panUrl = "";
    } else {
      panUrl = "${RemoteUrls.imageUrl}/$panImage";
    }
    return TechnicianProfileModel(
        id: json["id"] ?? "",
        technicianCode: json["technician_code"] ?? "",
        password: json["password"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        mobile: json["mobile"] ?? "",
        otAmt: json["OTAmt"] != null ? double.parse(json["OTAmt"]) : 0.0,
        owAmt: json["OWAmt"] != null ? double.parse(json["OWAmt"]) : 0.0,
        okAmt: json["OKAmt"] != null ? double.parse(json["OKAmt"]) : 0.0,
        ltLmt: json["LTLmt"] != null ? double.parse(json["LTLmt"]) : 0.0,
        lwAmt: json["LWAmt"] != null ? double.parse(json["LWAmt"]) : 0.0,
        lkAmt: json["LKAmt"] != null ? double.parse(json["LKAmt"]) : 0.0,
        address: json["address"] ?? "",
        aadharcard: aadharUrl,
        pancard: panUrl,
        image: profileUrl);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "technician_code": technicianCode,
        "password": password,
        "name": name,
        "email": email,
        "mobile": mobile,
        "OTAmt": otAmt,
        "OWAmt": owAmt,
        "OKAmt": okAmt,
        "LTLmt": ltLmt,
        "LWAmt": lwAmt,
        "LKAmt": lkAmt,
        "address": address,
      };
}

import 'package:caspro_enterprises/Utils/remote_urls.dart';

class ManualsModel {
  final String? id;
  final String? type;
  final String? urlLink;
  final String? fileName;

  final DateTime? createdAt;

  ManualsModel({
    this.id,
    this.type,
    this.fileName,
    this.urlLink,
    this.createdAt,
  });

  factory ManualsModel.fromJson(Map<String, dynamic> json) => ManualsModel(
        id: json["id"],
        type: json["type"],
        fileName: json["file_name"],
        urlLink: "${RemoteUrls.imageUrl}/${json["url_link"]}",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "url_link": urlLink,
        "created_at": createdAt?.toIso8601String(),
      };
}

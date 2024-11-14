import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HelperPage extends StatefulWidget {
  const HelperPage({super.key});

  @override
  State<HelperPage> createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {
  String userId = "", title = "", id = "";

  List<HelperModel> almubList = [];

  Future fetchAlbum() async {
    var response =
        await http.get(Uri.parse("https://api.restful-api.dev/objects"));

    if (response.statusCode == 200) {
      List decodedData = json.decode(response.body);

      List<HelperModel> helper = [];

      helper = decodedData
          .map<HelperModel>(
            (e) => HelperModel.fromJson(e),
          )
          .toList();

      almubList = helper;

      setState(() {});
    }
  }

  @override
  void initState() {
    fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  fetchAlbum();
                },
                child: const Text("data")),
            Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = almubList[index];
                      return Card(
                        child: Column(
                          children: [
                            Text(data.name),
                            Text(data.data == null
                                ? ""
                                : data.data!.capacity ?? ""),
                            Text(data.data == null
                                ? ""
                                : data.data!.hardDiskSize ?? ""),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext, int) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: almubList.length))
          ],
        ),
      ),
    );
  }
}

class HelperModel {
  final String id;
  final String name;
  final Data? data;

  HelperModel({
    required this.id,
    required this.name,
    required this.data,
  });

  factory HelperModel.fromJson(Map<String, dynamic> json) => HelperModel(
        id: json["id"],
        name: json["name"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "data": data?.toJson(),
      };
}

class Data {
  final String? dataColor;
  final String? dataCapacity;
  final int? capacityGb;
  final double? dataPrice;
  final String? dataGeneration;
  final int? year;
  final String? cpuModel;
  final String? hardDiskSize;
  final String? strapColour;
  final String? caseSize;
  final String? color;
  final String? description;
  final String? capacity;
  final double? screenSize;
  final String? generation;
  final String? price;

  Data({
    this.dataColor,
    this.dataCapacity,
    this.capacityGb,
    this.dataPrice,
    this.dataGeneration,
    this.year,
    this.cpuModel,
    this.hardDiskSize,
    this.strapColour,
    this.caseSize,
    this.color,
    this.description,
    this.capacity,
    this.screenSize,
    this.generation,
    this.price,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dataColor: json["color"],
        dataCapacity: json["capacity"],
        capacityGb: json["capacity GB"],
        dataPrice: json["price"]?.toDouble(),
        dataGeneration: json["generation"],
        year: json["year"],
        cpuModel: json["CPU model"],
        hardDiskSize: json["Hard disk size"],
        strapColour: json["Strap Colour"],
        caseSize: json["Case Size"],
        color: json["Color"],
        description: json["Description"],
        capacity: json["Capacity"],
        screenSize: json["Screen size"]?.toDouble(),
        generation: json["Generation"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "color": dataColor,
        "capacity": dataCapacity,
        "capacity GB": capacityGb,
        "price": dataPrice,
        "generation": dataGeneration,
        "year": year,
        "CPU model": cpuModel,
        "Hard disk size": hardDiskSize,
        "Strap Colour": strapColour,
        "Case Size": caseSize,
        "Color": color,
        "Description": description,
        "Capacity": capacity,
        "Screen size": screenSize,
        "Generation": generation,
        "Price": price,
      };
}

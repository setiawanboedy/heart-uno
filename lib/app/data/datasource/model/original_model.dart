import 'dart:convert';

OriginalModel oriModelFromJson(String str) =>
    OriginalModel.fromJson(json.decode(str));

String originalDetailToJson(OriginalModel? data) => json.encode(data?.toJson());

class OriginalModel {
  OriginalModel({
    required this.ecg,
  });

  List<int> ecg;

  factory OriginalModel.fromJson(Map<String, dynamic> json) => OriginalModel(
        ecg: List<int>.from(json["ecg"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ecg": List<int>.from(ecg.map((x) => x)),
      };
}

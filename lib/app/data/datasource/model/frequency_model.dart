import 'dart:convert';

import 'package:heart_usb/app/data/domain/entities/frequency.dart';

FrequencyModel frequencyModelFromJson(String str) =>
    FrequencyModel.fromJson(json.decode(str));

String frequencyModelToJson(FrequencyModel data) => json.encode(data.toJson());

class FrequencyModel {
  double vlf;
  double lf;
  double hf;

  Frequency toEntity() {
    return Frequency(
      vlf: vlf,
      lf: lf,
      hf: hf
    );
  }

  FrequencyModel({
    required this.vlf,
    required this.lf,
    required this.hf,
  });

  factory FrequencyModel.fromJson(Map<String, dynamic> json) => FrequencyModel(
        vlf: json["vlf"]?.toDouble(),
        lf: json["lf"]?.toDouble(),
        hf: json["hf"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "vlf": vlf,
        "lf": lf,
        "hf": hf,
      };
}

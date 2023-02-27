import 'dart:convert';

import '../../domain/entities/heart.dart';

HeartAnalysisModel analisModelFromJson(String str) =>
    HeartAnalysisModel.fromJson(json.decode(str));

String analysisToJson(HeartAnalysisModel? data) => json.encode(data?.toJson());

class HeartAnalysisModel {
  HeartAnalysisModel({
    this.data,
  });

  Data? data;

  factory HeartAnalysisModel.fromJson(Map<String, dynamic> json) =>
      HeartAnalysisModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  Heart toEntity() => Heart(data);
}

class Data {
  Data({
    this.ibi,
    this.sdnn,
    this.sdsd,
    this.rmssd,
    this.bpm,
    this.lf,
    this.hf,
  });

  double? ibi;
  double? sdnn;
  double? sdsd;
  double? rmssd;
  double? bpm;
  double? lf;
  double? hf;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ibi: json["ibi"].toDouble(),
        sdnn: json["sdnn"].toDouble(),
        sdsd: json["sdsd"].toDouble(),
        rmssd: json["rmssd"].toDouble(),
        bpm: json["bpm"].toDouble(),
        lf: json["lf"].toDouble(),
        hf: json["hf"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ibi": ibi,
        "sdnn": sdnn,
        "sdsd": sdsd,
        "rmssd": rmssd,
        "bpm": bpm,
        "lf": lf,
        "hf": hf,
      };
}

import 'dart:convert';

import 'package:heart_usb/app/data/domain/entities/heart.dart';


HeartAnalysisModel analisModelFromJson(String str) =>
    HeartAnalysisModel.fromJson(json.decode(str));

String analysisToJson(HeartAnalysisModel? data) => json.encode(data?.toJson());


class HeartAnalysisModel {
  HeartAnalysisModel({
    this.ibi,
    this.sdnn,
    this.rmssd,
    this.bpm,
  });

  double? ibi;
  double? sdnn;
  double? sdsd;
  double? rmssd;
  double? bpm;
  double? lf;
  double? hf;

Heart toEntity() {
    return Heart(
      ibi: ibi,
      sdnn: sdnn,
      rmssd: rmssd,
      bpm: bpm,
    );
  }

  factory HeartAnalysisModel.fromJson(Map<String, dynamic> json) => HeartAnalysisModel(
        ibi: json["ibi"].toDouble(),
        sdnn: json["sdnn"].toDouble(),
        rmssd: json["rmssd"].toDouble(),
        bpm: json["bpm"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ibi": ibi,
        "sdnn": sdnn,
        "rmssd": rmssd,
        "bpm": bpm
      };
}

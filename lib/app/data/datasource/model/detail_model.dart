import 'dart:convert';

DetailModel detailModelFromJson(String str) =>
    DetailModel.fromMap(json.decode(str));

String detailModelToJson(DetailModel data) => json.encode(data.toMap());

class DetailModel {
  DetailModel({
    this.id,
    this.original,
    this.spectrum,
    this.analysis,
  });

  int? id;
  String? original;
  String? spectrum;
  String? analysis;

  factory DetailModel.fromMap(Map<String, dynamic> json) => DetailModel(
        id: json["id"],
        original: json["original"],
        spectrum: json["spectrum"],
        analysis: json["analysis"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "original": original,
        "spectrum": spectrum,
        "analysis": analysis,
      };
}

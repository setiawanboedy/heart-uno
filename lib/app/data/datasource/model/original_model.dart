class OriginalModel {
  OriginalModel({
    required this.ecg,
  });

  List<double> ecg;

  factory OriginalModel.fromJson(Map<String, dynamic> json) => OriginalModel(
        ecg: List<double>.from(json["ecg"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ecg": List<double>.from(ecg.map((x) => x)),
      };
}

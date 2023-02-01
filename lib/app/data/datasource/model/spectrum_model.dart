class SpectrumModel {
  SpectrumModel({required this.freq, required this.psd});

  List<double> freq;
  List<double> psd;

  factory SpectrumModel.fromJson(Map<String, dynamic> json) => SpectrumModel(
        freq: List<double>.from(json["freq"].map((x) => x)),
        psd: List<double>.from(json["psd"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "freq": List<double>.from(freq.map((x) => x)),
        "psd": List<double>.from(psd.map((x) => x)),
      };
}

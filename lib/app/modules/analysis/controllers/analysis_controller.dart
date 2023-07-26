import 'package:get/get.dart';
import 'package:heart_usb/app/data/domain/entities/frequency.dart';
import 'package:heart_usb/app/data/domain/entities/heart.dart';
import 'package:heart_usb/app/data/domain/entities/image_entity.dart';
import 'package:heart_usb/app/data/domain/usecase/get_deteksi.dart';
import 'package:heart_usb/app/data/domain/usecase/get_frequency.dart';
import 'package:heart_usb/app/data/domain/usecase/get_koreksi.dart';
import '../../../data/datasource/model/original_model.dart';
import '../../../data/domain/usecase/get_analysis.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../data/datasource/model/heart_analysis_model.dart';
import '../../../data/domain/usecase/get_original.dart';
import '../../../data/domain/usecase/get_spectrum.dart';

class OriChart {
  final int x;
  final int y;

  OriChart(this.x, this.y);
}

class AnalysisController extends GetxController {
  final GetOriginal getOriginal = Get.put(GetOriginal());
  final GetSpectrum getSpectrum = Get.put(GetSpectrum());
  final GetAnalysis analysis = Get.put(GetAnalysis());
  final GetFrequency frequency = Get.put(GetFrequency());
  final GetDeteksi deteksi = Get.put(GetDeteksi());
  final GetKoreksi koreksi = Get.put(GetKoreksi());

  final Rxn<Heart> heartResult = Rxn<Heart>();
  final Rxn<Frequency> freqResult = Rxn<Frequency>();
  final Rxn<ImageEntity> deteksiR = Rxn<ImageEntity>();
  final Rxn<ImageEntity> koreksiR = Rxn<ImageEntity>();
  final Rxn<HeartAnalysisModel> analysisResult = Rxn<HeartAnalysisModel>();

  final RxList<OriChart> oriImage = RxList.empty(growable: true);

  final Rxn<ImageEntity> spectrumImage = Rxn<ImageEntity>();
  final Rxn<OriginalModel> ori = Rxn<OriginalModel>();

  Future<void> getOriUrlImage() async {
    final data = await getOriginal.call(NoParams());
    oriImage.clear();
    data.fold(
      (l) {},
      (r) {
        ori(r);
        for (int i = 0; i < r.ecg.length; i++) {
          oriImage.add(OriChart(i, r.ecg[i]));
        }
      },
    );
  }

  Future<void> getSpecUrlImage() async {
    final data = await getSpectrum.call(NoParams());

    data.fold(
      (l) {
        printError();
      },
      (r) {
        spectrumImage(r);
      },
    );
  }

  Future<void> getAnalysis() async {
    final data = await analysis.call(NoParams());

    data.fold((l) {
      if (l is ServerFailure) {}
    }, (r) {
      heartResult(r);
    });
  }

  Future<void> getFrequency() async {
    final data = await frequency.call(NoParams());

    data.fold((l) {
      if (l is ServerFailure) {}
    }, (r) {
      freqResult(r);
    });
  }

  Future<void> getDeteksi() async {
    final data = await deteksi.call(NoParams());

    data.fold((l) {
      if (l is ServerFailure) {}
    }, (r) {
      deteksiR(r);
    });
  }

  Future<void> getKoreksi() async {
    final data = await koreksi.call(NoParams());

    data.fold((l) {
      if (l is ServerFailure) {}
    }, (r) {
      koreksiR(r);
    });
  }

  @override
  void onInit() {
    getOriUrlImage();
    getSpecUrlImage();
    getAnalysis();
    getFrequency();
    getDeteksi();
    getKoreksi();
    super.onInit();
  }
}

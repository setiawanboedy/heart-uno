import 'package:get/get.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../data/datasource/model/heart_analysis_response.dart';
import '../../../data/domain/usecase/get_original.dart';
import '../../../data/domain/usecase/get_spectrum.dart';
import '../../../data/domain/usecase/post_csv.dart';

class AnalysisController extends GetxController {
  final GetOriginal getOriginal = Get.put(GetOriginal());
  final GetSpectrum getSpectrum = Get.put(GetSpectrum());
  // final PostCsv postCsv = Get.put(PostCsv());

  // var heartAnalysisResult = Rxn<Data>();

  final RxnString oriImage = RxnString();
  final RxnString spectrumImage = RxnString();

  Future<void> getOriUrlImage() async {
    final data = await getOriginal.call(NoParams());

    data.fold(
      (l) {
        oriImage(l.toString());
      },
      (r) {
        oriImage(r);
      },
    );
  }

  Future<void> getSpecUrlImage() async {
    final data = await getSpectrum.call(NoParams());

    data.fold(
      (l) {
        spectrumImage(l.toString());
      },
      (r) {
        spectrumImage(r);
      },
    );
  }

  // Future<void> postUploadCsv(HeartParams params) async {
  //   final data = await postCsv.call(params);

  //   data.fold((l) {
  //     if (l is ServerFailure) {}
  //   }, (r) {
  //     heartAnalysisResult(r.data);
  //   });
  // }

  @override
  void onInit() async {
    await getOriUrlImage();
    await getSpecUrlImage();

    super.onInit();
  }
}

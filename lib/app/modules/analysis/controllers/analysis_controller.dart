import 'package:get/get.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../data/domain/usecase/get_original.dart';
import '../../../data/domain/usecase/get_spectrum.dart';
import '../../receive_data_graphe/controllers/receive_data_graphe_controller.dart';

class AnalysisController extends GetxController {
  final GetOriginal getOriginal = Get.put(GetOriginal());
  final GetSpectrum getSpectrum = Get.put(GetSpectrum());

  final ReceiveDataGrapheController receive =
      Get.find<ReceiveDataGrapheController>();

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

  @override
  void onInit() async {
    await getOriUrlImage();
    await getSpecUrlImage();

    super.onInit();
  }

}

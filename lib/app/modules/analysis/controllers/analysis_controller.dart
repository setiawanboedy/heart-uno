import 'package:get/get.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../data/domain/usecase/get_original.dart';
import '../../receive_data_graphe/controllers/receive_data_graphe_controller.dart';

class AnalysisController extends GetxController with StateMixin<String> {
  final GetOriginal getOriginal = Get.put(GetOriginal());
  
  final ReceiveDataGrapheController receive =
      Get.find<ReceiveDataGrapheController>();

  Future<void> getOriUrlImage() async {
    final data = await getOriginal.call(NoParams());
    change(null, status: RxStatus.loading());
    data.fold(
      (l) => change(
        null,
        status: RxStatus.error(),
      ),
      (r) => change(
        r,
        status: RxStatus.success(),
      ),
    );
  }



  @override
  void onInit() async {
    await getOriUrlImage();
    
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

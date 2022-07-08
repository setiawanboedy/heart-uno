import 'package:get/get.dart';

import '../controllers/receive_data_graphe_controller.dart';

class ReceiveDataGrapheBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveDataGrapheController>(
      () => ReceiveDataGrapheController(),
    );
  }
}

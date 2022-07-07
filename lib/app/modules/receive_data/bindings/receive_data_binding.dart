import 'package:get/get.dart';

import '../controllers/receive_data_controller.dart';

class ReceiveDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveDataController>(
      () => ReceiveDataController(),
    );
  }
}

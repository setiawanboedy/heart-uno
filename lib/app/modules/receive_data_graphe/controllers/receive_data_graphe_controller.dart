import 'dart:async';

import 'package:get/get.dart';
import 'package:heart_usb/app/data/graph_model.dart';
import 'package:heart_usb/app/modules/home/controllers/home_controller.dart';

class ReceiveDataGrapheController extends GetxController {
  final HomeController _homeC = Get.find<HomeController>();

  RxList<GraphModel> serialData = RxList();

  Timer? timer;

  @override
  void onInit() {
    serialData(_homeC.serialData);
    if (serialData.isNotEmpty) {
      serialData.clear();
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}

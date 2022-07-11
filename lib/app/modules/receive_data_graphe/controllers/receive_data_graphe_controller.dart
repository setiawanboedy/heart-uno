import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/graph_model.dart';
import '../../home/controllers/home_controller.dart';
import 'package:oktoast/oktoast.dart';

class ReceiveDataGrapheController extends GetxController {
  final HomeController _homeC = Get.find<HomeController>();

  RxList<GraphModel> serialData = RxList();
  RxList<int> beats = RxList();

  Timer? timer;

  RxInt bpm = 0.obs;

  int threshold = 210;
  RxBool belowThreshold = RxBool(true);

  /// Smoth the raw using Exponential averaging
  /// realtime data using formula
  /// ```
  /// $y_n = alpha * x_n + (1 - alpha) * y_{n-1}$
  /// ```

  void getBPM() {
    bpm.value = beats.length * 10;
    beats.clear();
    update();
  }

  @override
  void onInit() {
    serialData(_homeC.serialData);
    beats(_homeC.beats);

    if (serialData.isNotEmpty) {
      serialData.clear();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onClose();
  }
}

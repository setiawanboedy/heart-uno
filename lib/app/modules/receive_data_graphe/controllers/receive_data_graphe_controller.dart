import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/graph_model.dart';
import '../../home/controllers/home_controller.dart';


class ReceiveDataGrapheController extends GetxController {
  final HomeController _homeC = Get.find<HomeController>();

  RxList<GraphModel> serialData = RxList();
  RxList<int> beats = RxList();

  Timer? timer;

  RxInt bpm = 0.obs;

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

  Future<void> generateCsv() async {
    // List<int> list = [6, 6, 7, 7, 7, 7, 7, 7, 8, 8,10000];
    List<List<dynamic>> data = [
      ["heart"],
    ];
    for (var lis in serialData) {
      data.add([lis.y]);
    }
    String csvData = const ListToCsvConverter().convert(data);
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory/data.csv";
    final File file = File(path);
    await file.writeAsString(csvData);
    Get.offNamed(Routes.ANALYSIS, arguments: path);
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

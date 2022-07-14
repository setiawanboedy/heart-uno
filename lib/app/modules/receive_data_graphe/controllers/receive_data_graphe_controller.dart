import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/datasource/model/heart_analysis_response.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/failure/failure.dart';
import '../../../data/domain/usecase/post_csv.dart';
import '../../../data/graph_model.dart';
import '../../home/controllers/home_controller.dart';
import '../../utils/dummy.dart';

class ReceiveDataGrapheController extends GetxController {
  final HomeController _homeC = Get.find<HomeController>();
  final PostCsv postCsv = Get.put(PostCsv());

  RxList<GraphModel> serialData = RxList();
  RxList<int> beats = RxList();
  var heart = Rxn<Data>();

  Timer? timer;

  RxInt bpm = 0.obs;

  void getBPM() {
    bpm.value = beats.length * 10;
    beats.clear();
    update();
  }

  Future<void> postUploadCsv(HeartParams params) async {
    final data = await postCsv.call(params);

    data.fold((l) {
      if (l is ServerFailure) {}
    }, (r) {
      heart(r.data);
    });
  }

  Future<void> generateCsv() async {
    List<List<dynamic>> data = [
      ["hart"],
    ];
    for (var lis in Dummy.dataList) {
      data.add([lis]);
    }
    String csvData = const ListToCsvConverter().convert(data);
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory/data.csv";
    final File file = File(path);

    await file.writeAsString(csvData);
    await postUploadCsv(HeartParams(file));
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

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';

class AnalysisController extends GetxController {
  Future<List<List<dynamic>>> loadingDataCsv(String path) async {
    final csvFile = File(path).openRead();
    return await csvFile
        .transform(utf8.decoder)
        .transform(
          const CsvToListConverter(),
        )
        .toList();
  }


  @override
  void onClose() {
    super.onClose();
  }
}

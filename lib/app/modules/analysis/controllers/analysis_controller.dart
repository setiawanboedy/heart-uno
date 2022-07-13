import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import '../../../data/domain/entities/heart.dart';
import '../../../data/domain/usecase/post_csv.dart';
import '../../../../core/failure/failure.dart';

class AnalysisController extends GetxController with StateMixin<Heart> {
  final PostCsv postCsv = Get.put(PostCsv());

  Future<void> postUploadCsv(HeartParams params) async {
    change(null, status: RxStatus.empty());
    final data = await postCsv.call(params);
    data.fold((l) {
      if (l is ServerFailure) {
        change(null, status: RxStatus.error());
      }
    }, (r) {
      change(
        r,
        status: RxStatus.success(),
      );
    });
  }

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

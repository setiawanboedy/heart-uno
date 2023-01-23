import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/failure/failure.dart';
import '../../../data/domain/usecase/post_csv.dart';
import '../../../routes/app_pages.dart';

class RecordController extends GetxController {
  final PostCsv postCsv = Get.put(PostCsv());

  // var heartAnalysisResult = Rxn<Data>();
  RxBool loading = RxBool(false);

  RxList<FileSystemEntity> files = RxList.empty();

  void _getRecordDirectory() async {
    List<FileSystemEntity> csvs = List.empty(growable: true);
    String directory = (await getApplicationDocumentsDirectory()).path;
    List<FileSystemEntity> datas = Directory(directory).listSync();
    for (var data in datas) {
      if (p.extension(data.path) == ".csv") {
        csvs.add(data);
      }
    }
    files(csvs);
  }

  String fileName(Uri pathName) {
    final pathString = pathName.pathSegments.last;
    return pathString.substring(0, pathString.length - 4);
  }

  Future<void> postUploadCsv(HeartParams params) async {
    final data = await postCsv.call(params);
    loading(true);
    data.fold((l) {
      if (l is ServerFailure) {
        loading(false);
      }
    }, (r) {
      Get.toNamed(Routes.ANALYSIS, arguments: r.data);
      loading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
    _getRecordDirectory();
  }
}

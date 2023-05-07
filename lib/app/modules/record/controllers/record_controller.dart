import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heart_usb/app/data/datasource/model/detail_model.dart';
import 'package:heart_usb/app/modules/utils/strings.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/datasource/model/heart_item_model.dart';
import '../../../data/domain/usecase/delete_heart.dart';
import '../../../data/domain/usecase/get_hearts.dart';
import '../../resources/dimens.dart';
import '../../../../core/usecase/usecase.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import '../../../../core/failure/failure.dart';
import '../../../data/domain/usecase/post_csv.dart';
import '../../../routes/app_pages.dart';

class DataAnalysis {
  final int id;
  final DetailModel detail;

  DataAnalysis(this.id, this.detail);
}

class RecordController extends GetxController {
  final PostCsv postCsv = Get.put(PostCsv());
  final GetHearts hearts = Get.put(GetHearts());
  final DeleteHeart deleteHeart = Get.put(DeleteHeart());

  RxList<FileSystemEntity> files = RxList.empty();
  Rxn<HeartListModel> heartList = Rxn<HeartListModel>();

  void _getRecordLocal() async {
    final data = await hearts.call(NoParams());
    data.fold((l) {
      if (l is ServerFailure) {
        if (kDebugMode) {
          print(l.message);
        }
      }
    }, (r) {
      heartList(r);
    });
  }

  Future<void> postUploadCsv(HeartParams params, int id) async {
    popLoading();
    final data = await postCsv.call(params);

    data.fold((l) {
      if (l is ServerFailure) {
        Get.back();
        popError();
      }
    }, (r) {
      Get.back();
      Get.toNamed(Routes.ANALYSIS);
    });
  }

  void deleteFile(String? path, int id) {
    popDelete(path, id);
  }

  void _getRecordDirectory() async {
    List<FileSystemEntity> csvs = List.empty(growable: true);
    String directory = (await getApplicationDocumentsDirectory()).path;
    List<FileSystemEntity> datas = Directory(directory).listSync();
    for (var data in datas) {
      if (p.extension(data.path) == ".csv") {
        csvs.add(data);
        print(data.path);
      }
    }
    // print(object)
  }

  void getDetailHeart(int id, HeartItemModel file) async {
    File fileCsv = File(
        file.path!);
    // print(fileCsv.path);
    // print(file.path);
    postUploadCsv(HeartParams(fileCsv), file.id!);
    // _getRecordDirectory();
  }

  void popDelete(String? path, int id) {
    Get.defaultDialog(
      title: Strings.delete_record,
      contentPadding: EdgeInsets.symmetric(horizontal: Dimens.space24),
      content: const Text(Strings.do_delete_title),
      confirm: ElevatedButton(
        onPressed: () {
          deleteHeart.call(id);
          final dir = Directory("$path");
          dir.deleteSync(recursive: true);
          _getRecordLocal();
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(Strings.yes),
      ),
      cancel: OutlinedButton(
        onPressed: () {
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(Strings.no),
      ),
    );
  }

  void popLoading() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 140),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height * 0.07;
            var width = MediaQuery.of(context).size.width;

            return SizedBox(
              height: height,
              width: width,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          },
        ),
      ),
    );
  }

  void popError() {
    showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 100),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height * 0.15;
            var width = MediaQuery.of(context).size.width;

            return SizedBox(
              height: height,
              width: width,
              child: Center(
                  child: Column(
                children: [
                  const Icon(
                    Icons.close_outlined,
                    size: 65,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(Strings.back),
                  )
                ],
              )),
            );
          },
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _getRecordLocal();
  }
}

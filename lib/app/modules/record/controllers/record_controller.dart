import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heart_usb/app/modules/resources/dimens.dart';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/failure/failure.dart';
import '../../../data/domain/usecase/post_csv.dart';
import '../../../routes/app_pages.dart';

class RecordController extends GetxController {
  final PostCsv postCsv = Get.put(PostCsv());

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
    popLoading();
    final data = await postCsv.call(params);

    data.fold((l) {
      if (l is ServerFailure) {
        Get.back();
        popError();
      }
    }, (r) {
      Get.back();
      Get.toNamed(Routes.ANALYSIS, arguments: r.data);
    });
  }

  void deleteFile(String path) {
    popDelete(path);
  }

  void popDelete(String path) {
    Get.defaultDialog(
      title: "Hapus rekaman",
      contentPadding: EdgeInsets.symmetric(horizontal: Dimens.space24),
      content: const Text("Apakah anda ingin hapus file rekaman ?"),
      confirm: ElevatedButton(
        onPressed: () {
          final dir = Directory(path);
          dir.deleteSync(recursive: true);
          _getRecordDirectory();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text("Ya"),
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
        child: const Text("Tidak"),
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
                    child: const Text("Kembali"),
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

    _getRecordDirectory();
  }
}

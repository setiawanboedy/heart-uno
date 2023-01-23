import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heart_usb/app/data/domain/usecase/post_csv.dart';
import 'package:heart_usb/app/modules/resources/dimens.dart';

import '../../../routes/app_pages.dart';
import '../../resources/palette.dart';
import '../controllers/record_controller.dart';
import 'package:path/path.dart' as p;

class RecordView extends GetView<RecordController> {
  const RecordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Rekaman'),
        centerTitle: true,
        backgroundColor: Palette.bgColor,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.files.length,
          itemBuilder: (context, index) {
            return _cardRecord(controller.files[index]);
          },
        ),
      ),
    );
  }

  Widget _cardRecord(FileSystemEntity file) {
    return InkWell(
      onTap: () {
        File fileCsv = File(file.path);
        controller.loading(true);
        controller.postUploadCsv(HeartParams(fileCsv));
      },
      child: Container(
        margin: EdgeInsets.all(Dimens.space8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.red,
                ),
                SizedBox(
                  width: Dimens.space12,
                ),
                Text(
                  controller.fileName(file.uri),
                  style: TextStyle(fontSize: Dimens.body1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

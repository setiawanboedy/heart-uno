import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heart_usb/app/modules/utils/strings.dart';
import '../../../data/datasource/model/heart_item_model.dart';
import '../../resources/dimens.dart';

import '../../../routes/app_pages.dart';
import '../../resources/palette.dart';
import '../controllers/record_controller.dart';

class RecordView extends GetView<RecordController> {
  const RecordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.record_result_title),
        centerTitle: true,
        backgroundColor: Palette.bgColor,
        leading: IconButton(
            onPressed: () {
              Get.offNamed(Routes.HOME);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.heartList.value?.items?.length ?? 0,
          itemBuilder: (context, index) {
            return _cardRecord(controller.heartList.value?.items?[index]);
          },
        ),
      ),
    );
  }

  Widget _cardRecord(HeartItemModel? file) {
    return InkWell(
      onLongPress: () {
        controller.deleteFile(file?.path, file!.id!);
      },
      onTap: () {
        controller.getDetailHeart(file!.id!, file);
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${Strings.name_record} : ${file?.name}",
                      style: TextStyle(fontSize: Dimens.body1),
                    ),
                    SizedBox(
                      height: Dimens.space8,
                    ),
                    Text(
                      "${Strings.desc_record} : ${file?.desc}, umur: ${file?.age}",
                      style: TextStyle(fontSize: Dimens.body1),
                    ),
                    SizedBox(
                      height: Dimens.space8,
                    ),
                    Text(
                      "${Strings.age} : ${file?.age} years old",
                      style: TextStyle(fontSize: Dimens.body1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

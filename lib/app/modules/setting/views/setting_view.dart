import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../data/datasource/local/storage_manager.dart';
import '../../resources/dimens.dart';
import '../../resources/palette.dart';
import '../../utils/strings.dart';
import '../../../routes/app_pages.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pengaturan Uno'),
          centerTitle: true,
          backgroundColor: Palette.bgColor,
          
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: Dimens.space8, vertical: Dimens.space16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Port",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: const [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Palette.bgColor,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Pilih Port',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.bgColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: controller.ports
                            .map(
                              (port) => DropdownMenuItem<String>(
                                value: port,
                                child: Text(
                                  port,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.bgColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        value: controller.selected.value,
                        onChanged: (value) {
                          controller.selected.value = value as String;
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                        buttonElevation: 2,
                        itemHeight: 40,
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                      ),
                    );
                  }),
                ],
              ),
              const Spacer(),
              InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Dimens.cornerRadius),
                ),
                onTap: (() {
                  var port = controller.selected;
                  if (port.value != Strings.defaultValue) {
                    Get.find<StorageManager>().port = int.tryParse(port.value);
                  }

                  Get.toNamed(Routes.HOME);
                }),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Palette.bgColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(Dimens.cornerRadius)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),);
  }
}

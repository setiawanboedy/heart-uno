import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heart_usb/app/modules/pages/parent.dart';
import 'package:heart_usb/app/modules/resources/dimens.dart';
import 'package:heart_usb/app/modules/widgets/spacer_v.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(
        title: const Text('Analisis Detak Jantung'),
        centerTitle: true,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            Text(
              "Koneksikan Alat EKG",
              style: TextStyle(fontSize: Dimens.space24),
            ),
            const SpacerV(),
            Obx(
              () => Expanded(
                flex: 4,
                child: SizedBox(
                  width: Get.size.width * 0.4,
                  height: Get.size.width * 0.4,
                  child: controller.status == "Connected"
                      ? Image.asset(
                          "assets/icons/connected.png",
                          scale: 0.5,
                        )
                      : Image.asset(
                          "assets/icons/disconnected.png",
                          scale: 0.5,
                        ),
                ),
              ),
            ),
            const SpacerV(),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.RECEIVE_DATA_GRAPHE),
              child: Container(
                  padding: EdgeInsets.all(Dimens.button),
                  child: const Text("Lihat Grafik")),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

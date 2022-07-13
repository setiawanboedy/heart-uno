import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ripple_animation/ripple_animation.dart';

import '../../../routes/app_pages.dart';
import '../../pages/parent.dart';
import '../../resources/dimens.dart';
import '../../resources/palette.dart';
import '../../utils/strings.dart';
import '../../widgets/spacer_v.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white38,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Palette.statusBarColor,
        ),
      ),
      child: Obx(
        () {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.status == Strings.connected)
                  RippleAnimation(
                    repeat: true,
                    color: Colors.green,
                    minRadius: 100,
                    ripplesCount: 2,
                    child: SizedBox(
                      width: Get.size.width * 0.4,
                      height: Get.size.width * 0.4,
                      child: Image.asset(
                        "assets/icons/connected.png",
                        scale: 0.5,
                      ),
                    ),
                  )
                else
                  RippleAnimation(
                    repeat: true,
                    color: Colors.red,
                    minRadius: 100,
                    ripplesCount: 2,
                    child: SizedBox(
                      width: Get.size.width * 0.4,
                      height: Get.size.width * 0.4,
                      child: Image.asset(
                        "assets/icons/disconnected.png",
                        scale: 1,
                      ),
                    ),
                  ),
                SpacerV(value: Dimens.h1),
                if (controller.status == Strings.connected)
                  Column(
                    children: [
                      Text(
                        "Connected",
                        style: TextStyle(
                            fontSize: Dimens.h5, color: Palette.bgColor),
                      ),
                      SpacerV(
                        value: Dimens.h4,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.RECEIVE_DATA_GRAPHE);
                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimens.button),
                          child: const Text("Lihat grafik"),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Text(
                        "Disconnected",
                        style: TextStyle(
                          fontSize: Dimens.h5,
                          color: Palette.bgColor,
                        ),
                      ),
                      SpacerV(
                        value: Dimens.h4,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.RECEIVE_DATA_GRAPHE);
                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimens.button),
                          child: const Text("Lihat grafik"),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

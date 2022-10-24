import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

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
        automaticallyImplyLeading: false,
        backgroundColor: Palette.bgColor,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Palette.statusBarColor,
        // ),
        leading: InkWell(
          onTap: () => Get.toNamed(Routes.RECORD),
          child: const Icon(Icons.save),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(Dimens.cornerRadius),
            onTap: () => Get.toNamed(Routes.SETTING),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.button),
              child: const Icon(Icons.settings),
            ),
          ),
        ],
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

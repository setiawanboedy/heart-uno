import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../data/domain/usecase/post_csv.dart';
import '../../../routes/app_pages.dart';
import '../../../data/domain/entities/heart.dart';
import '../../pages/parent.dart';
import '../../resources/dimens.dart';
import '../../resources/palette.dart';
import '../../widgets/spacer_v.dart';

import '../controllers/analysis_controller.dart';
import 'widgets/card_analysis.dart';
import 'widgets/card_graph.dart';

class AnalysisView extends GetView<AnalysisController> {
  // final Heart heart = Get.arguments as Heart;
  AnalysisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.bgColor,
        title: const Text("Analysis Sinyal Jantung"),
        leading: IconButton(
            onPressed: () {
              Get.toNamed(Routes.RECEIVE_DATA_GRAPHE);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Sinyal jantung",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            const SpacerV(),
            CardGraph(
              image: controller.obx(
                (state) {
                  return state != null
                      ? Image.memory(
                          base64Decode(state),
                          fit: BoxFit.cover,
                        )
                      : Container();
                },
                onLoading: const Center(child: CircularProgressIndicator()),
                onError: (error) => Text(error ?? "no data"),
              ),
            ),
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Time Domain Analysis",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            const SpacerV(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: Get.size.width,
                height: Get.size.height * 0.35,
                child: Obx(() {
                  if (controller.receive.heart.value != null) {
                    return GridView.count(
                      shrinkWrap: false,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        CardAnalysis(
                          value: controller.receive.heart.value?.ibi,
                          title: "IBI",
                        ),
                        CardAnalysis(
                          value: controller.receive.heart.value?.rmssd,
                          title: "RMSSD",
                        ),
                        CardAnalysis(
                          value: controller.receive.heart.value?.sdnn,
                          title: "SDNN",
                        ),
                        CardAnalysis(
                          value: controller.receive.heart.value?.sdsd,
                          title: "SDSD",
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
              ),
            ),
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Frequency Domain Analysis",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            const SpacerV(),
            const CardGraph(),
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: Get.size.width,
                height: Get.size.height * 0.2,
                child: Obx(() {
                  if (controller.receive.heart.value != null) {
                    return GridView.count(
                      shrinkWrap: false,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        CardAnalysis(
                          value: controller.receive.heart.value?.hf,
                          title: "HF",
                        ),
                        CardAnalysis(
                          value: controller.receive.heart.value?.lf,
                          title: "LF",
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

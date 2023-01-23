import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/datasource/model/heart_analysis_response.dart';

import '../../../routes/app_pages.dart';
import '../../pages/parent.dart';
import '../../resources/dimens.dart';
import '../../resources/palette.dart';
import '../../widgets/spacer_v.dart';
import '../controllers/analysis_controller.dart';
import 'widgets/card_analysis.dart';
import 'widgets/card_graph.dart';

class AnalysisView extends GetView<AnalysisController> {
  const AnalysisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final file = Get.arguments as Data;
    return Parent(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.bgColor,
        title: const Text("Analysis Sinyal Jantung"),
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
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
              image: Obx(
                () => controller.oriImage.value != null
                    ? Image.memory(
                        base64Decode(controller.oriImage.value!),
                        fit: BoxFit.cover,
                      )
                    : const Center(child: CircularProgressIndicator()),
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
                  child: (file.bpm != null)
                      ? GridView.count(
                          shrinkWrap: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            CardAnalysis(
                              value: file.ibi,
                              title: "IBI",
                            ),
                            CardAnalysis(
                              value: file.rmssd,
                              title: "RMSSD",
                            ),
                            CardAnalysis(
                              value: file.sdnn,
                              title: "SDNN",
                            ),
                            CardAnalysis(
                              value: file.sdsd,
                              title: "SDSD",
                            ),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator())),
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
            CardGraph(
              image: Obx(
                () => controller.spectrumImage.value != null
                    ? Image.memory(
                        base64Decode(controller.spectrumImage.value!),
                        fit: BoxFit.cover,
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: Get.size.width,
                height: Get.size.height * 0.2,
                child: (file.bpm != null)
                    ? GridView.count(
                        shrinkWrap: false,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          CardAnalysis(
                            value: file.hf,
                            title: "HF",
                          ),
                          CardAnalysis(
                            value: file.lf,
                            title: "LF",
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

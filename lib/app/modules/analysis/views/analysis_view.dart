import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/datasource/model/detail_model.dart';
import '../../../data/datasource/model/heart_analysis_model.dart';
import '../../../data/datasource/model/original_model.dart';
import '../../../routes/app_pages.dart';
import '../../pages/parent.dart';
import '../../record/controllers/record_controller.dart';
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
    // final data = Get.arguments as DataAnalysis;
    // controller.getAnalysisFromJson(data);
    // if (data.detail.spectrum == null) {
    //   controller.getOriUrlImage();
    //   controller.getSpecUrlImage();
    //   controller.getAnalysis();
    // }
    return Parent(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.bgColor,
        title: const Text("Analysis Sinyal Jantung"),
        leading: IconButton(
            onPressed: () {
              Get.offNamed(Routes.RECORD);
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
                () => controller.oriImage.value.isNotEmpty
                    ? SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        plotAreaBorderColor: Colors.red,
                        primaryXAxis: NumericAxis(
                          maximumLabelWidth: 100,
                          axisLine: const AxisLine(width: 1),
                          majorTickLines: const MajorTickLines(width: 0),
                          title: AxisTitle(
                            text: "Time (ms)",
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          maximumLabelWidth: 400,
                          axisLine: const AxisLine(width: 1),
                          majorTickLines: const MajorTickLines(size: 0),
                          title: AxisTitle(
                            text: "ECG (mV)",
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                        ),
                        series: <SplineSeries<OriChart, num>>[
                          SplineSeries<OriChart, num>(
                            dataSource: controller.oriImage.value,
                            xValueMapper: (OriChart rate, _) => rate.x,
                            yValueMapper: (OriChart rate, _) => rate.y,
                            width: 2,
                          ),
                        ],
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
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: SizedBox(
                height: 85,
                child: Obx(
                  () => controller.heartResult.value != null
                      ? CardAnalysis(
                          value: controller.heartResult.value?.bpm,
                          title: "BPM",
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ),
            const SpacerV(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(
                () => SizedBox(
                  width: Get.size.width,
                  height: Get.size.height * 0.35,
                  child: (controller.heartResult.value?.bpm != null)
                      ? GridView.count(
                          shrinkWrap: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            CardAnalysis(
                              value: controller.heartResult.value?.ibi,
                              title: "IBI",
                            ),
                            CardAnalysis(
                              value: controller.heartResult.value?.rmssd,
                              title: "RMSSD",
                            ),
                            CardAnalysis(
                              value: controller.heartResult.value?.sdnn,
                              title: "SDNN",
                            ),
                            CardAnalysis(
                              value: controller.heartResult.value?.sdsd,
                              title: "SDSD",
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
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
            CardGraph(
              image: Obx(
                () => controller.spectrumImage.value.isNotEmpty
                    ? Image.memory(
                        base64Decode(controller.spectrumImage.value),
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
              child: Obx(
                () => SizedBox(
                  width: Get.size.width,
                  height: Get.size.height * 0.2,
                  child: (controller.heartResult.value?.bpm != null)
                      ? GridView.count(
                          shrinkWrap: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            CardAnalysis(
                              value: controller.heartResult.value?.hf,
                              title: "HF",
                            ),
                            CardAnalysis(
                              value: controller.heartResult.value?.lf,
                              title: "LF",
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ),
            // Obx(() {
            //   var original = originalDetailToJson(controller.ori.value);
            //   var analysis = analysisToJson(controller.analysisResult.value);
            //   var spectrum = controller.spectrumImage.value;
            //   if (original.isNotEmpty &&
            //       analysis.isNotEmpty &&
            //       spectrum.isNotEmpty) {
            //     var detail = DetailModel(
            //       id: data.id,
            //       original: original,
            //       spectrum: spectrum,
            //       analysis: analysis,
            //     );
            //     // controller.saveDetailToLocal(data.id!, detail);
            //   }
            //   return (controller.heartResult.value?.bpm != null)
            //       ? const SizedBox()
            //       : const SizedBox();
            // }),
          ],
        ),
      ),
    );
  }
}

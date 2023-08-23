
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/modules/utils/strings.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    return Parent(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.bgColor,
        title: const Text(Strings.heart_analysis_title),
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
                Strings.heart_signal,
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
                            dataSource:
                                controller.oriImage.value.sublist(0, 300),
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
                "Deteksi puncak R",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            Card(
              child: Container(
                height: Get.size.height * 0.27,
                width: Get.size.width,
                color: Colors.white,
                child: Obx(
                  () => controller.deteksiR.value != null
                      ? Image.network(
                          "${controller.deteksiR.value?.image}",
                          fit: BoxFit.cover,
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Koreksi interval R",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            Card(
              child: Container(
                height: Get.size.height * 0.2,
                // width: Get.size.width,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.white,
                child: Obx(
                  () => controller.koreksiR.value != null
                      ? Image.network(
                          "${controller.koreksiR.value?.image}",
                          fit: BoxFit.fill,
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
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
                              value: controller.heartResult.value?.bpm
                                  ?.toStringAsFixed(0),
                              title: "BPM",
                            ),
                            CardAnalysis(
                              value:
                                  controller.heartResult.value?.ibi.toString(),
                              title: "IBI (ms)",
                            ),
                            CardAnalysis(
                              value: controller.heartResult.value?.rmssd
                                  .toString(),
                              title: "RMSSD (ms)",
                            ),
                            CardAnalysis(
                              value:
                                  controller.heartResult.value?.sdnn.toString(),
                              title: "SDNN (ms)",
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
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(
                () => SizedBox(
                  width: Get.size.width,
                  height: Get.size.height * 0.2,
                  child: (controller.freqResult.value?.hf != null)
                      ? GridView.count(
                          shrinkWrap: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            CardAnalysis(
                              value: controller.freqResult.value?.hf.toString(),
                              title: "HF (ms^2)",
                            ),
                            CardAnalysis(
                              value: controller.freqResult.value?.lf.toString(),
                              title: "LF (ms^2)",
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ),
            Card(
              child: Container(
                height: Get.size.height * 0.2,
                color: Colors.white,
                child: Obx(
                  () => controller.spectrumImage.value != null
                      ? Image.network(
                          "${controller.spectrumImage.value?.image}",
                          fit: BoxFit.fill,
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/modules/utils/strings.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/graph_model.dart';
import '../../../routes/app_pages.dart';
import '../../resources/palette.dart';
import '../controllers/receive_data_graphe_controller.dart';
import 'widgets/bottom_graph.dart';

class ReceiveDataGrapheView extends GetView<ReceiveDataGrapheController> {
  const ReceiveDataGrapheView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hourC = TextEditingController();
    final minuteC = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: const Text(Strings.heart_graph_title),
        backgroundColor: Palette.bgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 4,
              child: Obx(
                () {
                  return SfCartesianChart(
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
                    series: <SplineSeries<GraphModel, num>>[
                      SplineSeries<GraphModel, num>(
                        dataSource: controller.serialData,
                        xValueMapper: (GraphModel rate, _) => rate.x,
                        yValueMapper: (GraphModel rate, _) => rate.y,
                        width: 2,
                      ),
                    ],
                  );
                },
              ),
            ),
            if (context.isLandscape == true)
              Container()
            else
              Obx(
                () => BottomGraph(
                  duration: controller.duration.value ?? const Duration(),
                  startPressed: () {
                    controller.dialogAnalysis();
                  },
                  func: () async {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return buildDialog(hourC, minuteC);
                        }));
                  },
                  textButton: const Text(Strings.set_timer),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDialog(
          TextEditingController hourC, TextEditingController minuteC) =>
      AlertDialog(
        title: const Text(Strings.time_record),
        content: Row(
          children: [
            SizedBox(
              width: 35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: hourC,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: "00"),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(Strings.hour),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              width: 35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: minuteC,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: "00"),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(Strings.minutes)
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
            }, // function used to perform after pressing the button
            child: const Text(Strings.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            onPressed: () {
              controller.setTimerRecord(hourC.text, minuteC.text);
              Get.back();
            },
            child: const Text(Strings.record),
          ),
        ],
      );
}

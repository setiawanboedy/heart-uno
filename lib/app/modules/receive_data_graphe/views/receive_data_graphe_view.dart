import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heart_usb/app/data/graph_model.dart';
import 'package:heart_usb/app/modules/utils/constants.dart';
import 'package:heart_usb/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../resources/palette.dart';
import '../controllers/receive_data_graphe_controller.dart';
import 'widgets/bottom_graph.dart';

class ReceiveDataGrapheView extends GetView<ReceiveDataGrapheController> {
  const ReceiveDataGrapheView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Grafik Detak Jantung'),
        backgroundColor: Palette.bgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(Routes.HOME);
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
              GetBuilder<ReceiveDataGrapheController>(
                init: ReceiveDataGrapheController(),
                initState: (_) {
                  Timer.periodic(const Duration(seconds: Constants.timer), (timer) {
                    controller.getBPM();
                  });
                },
                builder: (ctr) {
                  return BottomGraph(bpm: ctr.bpm.value);
                },
              )
          ],
        ),
      ),
    );
  }
}

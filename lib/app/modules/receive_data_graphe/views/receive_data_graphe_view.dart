import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/graph_model.dart';
import '../../../routes/app_pages.dart';
import '../../resources/palette.dart';
import '../../utils/constants.dart';
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
        title: const Text('Grafik Detak Jantung'),
        backgroundColor: Palette.bgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.save_as_rounded),
          )
        ],
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
                    title: ChartTitle(text: "${controller.bpm.value} BPM"),
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
                  controller.timer = Timer.periodic(
                      const Duration(seconds: Constants.timer), (timer) {
                    controller.getBPM();
                  });
                },
                builder: (ctr) {
                  return Obx(() => BottomGraph(
                        duration: controller.duration.value ?? const Duration(),
                        startPressed: () {
                          controller.startTimer();
                        },
                        func: () async {
                          // controller.startTimer();
                          // final network = NetworkInfoImpl();
                          // if (await network.isConnected) {
                          // controller.gotToAnalysis();

                          // } else {
                          //   Get.defaultDialog(
                          //     title: "Tidak ada internet",
                          //     middleText:
                          //         "Pastikan koneksi ada untuk melakukan analisis",
                          //     textConfirm: "OK",
                          //     confirmTextColor: Colors.white,
                          //     onConfirm: () => Get.back(),
                          //   );
                          // }

                          showDialog(
                              context: context,
                              builder: ((context) {
                                return buildDialog(hourC, minuteC);
                              }));
                        },
                        textButton: const Text("Atur Waktu"),
                      ));
                },
              )
          ],
        ),
      ),
    );
  }

  Widget buildDialog(
          TextEditingController hourC, TextEditingController minuteC) =>
      AlertDialog(
        title: const Text('Waktu rekam'),
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
            const Text("Jam"),
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
            const Text("Menit")
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
            child: const Text('BATAL'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            onPressed: () {
              controller.setTimerRecord(hourC.text, minuteC.text);
              Get.back();
            },
            child: const Text('REKAM'),
          ),
        ],
      );
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heart_usb/app/data/graph_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/receive_data_graphe_controller.dart';

class ReceiveDataGrapheView extends GetView<ReceiveDataGrapheController> {
  const ReceiveDataGrapheView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik Detak Jantung'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Obx(() {
            Timer.periodic(const Duration(milliseconds: 10), (timer) {
              controller.serialData;
            });
            return SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: NumericAxis(
                maximumLabelWidth: 100,
                axisLine: const AxisLine(width: 1),
                majorTickLines: const MajorTickLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                maximumLabelWidth: 400,
                axisLine: const AxisLine(width: 1),
                majorTickLines: const MajorTickLines(size: 0),
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
          }))
        ],
      )),
    );
  }
}

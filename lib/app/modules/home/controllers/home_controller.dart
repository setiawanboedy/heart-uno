import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/graph_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:usb_serial/usb_serial.dart';

class HomeController extends GetxController {
  RxString detected = "".obs;

  /// Get device information
  Future<void> _getPorts() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();
    detected("");
    for (var device in devices) {
      detected(device.deviceName);
    }
  }

  @override
  void onInit() {
    UsbSerial.usbEventStream?.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onInit();
  }

  // void test() async {
  //   final serialDataSave = [
  //     GraphModel(y: 4, x: 2, time: DateTime.now()),
  //     GraphModel(y: 5, x: 12, time: DateTime.now()),
  //     GraphModel(y: 32, x: 423, time: DateTime.now()),
  //     GraphModel(y: 54, x: 34, time: DateTime.now()),
  //     GraphModel(y: 456, x: 223, time: DateTime.now()),
  //     GraphModel(y: 75, x: 342, time: DateTime.now())
  //   ];
  //   List<List<dynamic>> data = [
  //     ['hr', 'time'],
  //   ];

  //   for (var lis in serialDataSave) {
  //     data.add([lis.y, lis.x]);
  //   }
  //   String csvData = const ListToCsvConverter().convert(data);
  //   final String directory = (await getApplicationDocumentsDirectory()).path;

  //   final path = "$directory/ecg.csv";
  //   final File file = File(path);

  //   await file.writeAsString(csvData);
  // }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onClose();
  }
}

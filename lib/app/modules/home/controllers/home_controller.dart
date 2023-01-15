import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

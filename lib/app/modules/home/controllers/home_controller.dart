import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/datasource/local/storage_manager.dart';
import '../../../data/data_model.dart';
import '../../../data/graph_model.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

class HomeController extends GetxController {
  final Rxn<UsbPort> _port = Rxn<UsbPort>();
  final RxString _status = Strings.idle.obs;

  final RxList<DataModel> _ports = RxList<DataModel>();

  final RxList<GraphModel> _serialData = RxList();

  final RxList<int> _beats = RxList.empty(growable: true);

  final Rxn<StreamSubscription<String>> _subscription =
      Rxn<StreamSubscription<String>>();
  final Rxn<Transaction<String>> _transaction = Rxn<Transaction<String>>();

  final Rxn<UsbDevice> _device = Rxn<UsbDevice>();

  final RxString _portUsb = Strings.defaultValue.obs;

  String get portUsb => _portUsb.value;

  /// Count time for data
  int count = 0;

  /// Status of device
  String get status => _status.value;

  /// Data input from device
  List<GraphModel> get serialData => _serialData;

  /// Data calculate fro BPM
  List<int> get beats => _beats;

  /// Connect device with app
  Future<bool> connectTo(UsbDevice? device) async {
    _serialData.clear();

    if (_subscription.value != null) {
      _subscription.value?.cancel();
      _subscription(null);
    }

    if (_transaction.value != null) {
      _transaction.value?.dispose();
      _transaction(null);
    }

    if (_port.value != null) {
      _port.value?.close();
      _port(null);
    }

    if (device == null) {
      _device(null);
      _status(Strings.disconnected);
    }

    _port(await device?.create());
    if (_port.value == null) {
      _status(Strings.disconnected);
      return false;
    }

    if (await (_port.value?.open()) == true) {
      _device(device);
      _status(Strings.connected);
    }

    await _port.value?.setDTR(true);
    await _port.value?.setRTS(true);
    await _port.value?.setPortParameters(int.parse(portUsb), UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction(Transaction.stringTerminated(
      _port.value?.inputStream as Stream<Uint8List>,
      Uint8List.fromList([13, 10]),
    ).stream.listen((String line) {
      _serialData.add(GraphModel(y: int.parse(line), x: count++));
      calcualteBPM(int.parse(line));
      update();
      if (_serialData.length > Constants.lenghtData) {
        _serialData.removeAt(0);
      }
    }) as Transaction<String>);
    update();
    return true;
  }

  /// Get device information
  Future<void> _getPorts() async {
    _ports([]);
    List<UsbDevice> devices = await UsbSerial.listDevices();
    if (!devices.contains(_device.value)) {
      connectTo(null);
    }

    for (var device in devices) {
      _ports.add(DataModel(device));
      connectTo(_device.value == device ? null : device)
          .then((value) => _getPorts());
      update();
    }
  }

  /// add peak data
  void calcualteBPM(int data) {
    if (data > Constants.threshold) {
      _beats.add(data);
    }
  }

  @override
  void onInit() {
    _portUsb((Get.find<StorageManager>().port ?? Constants.port).toString());
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
    connectTo(null);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onClose();
  }
}

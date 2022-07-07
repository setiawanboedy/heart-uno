import 'dart:async';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:heart_usb/app/data/data_model.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

class HomeController extends GetxController {
  final Rxn<UsbPort> _port = Rxn<UsbPort>();
  final _status = "Idle".obs;

  String get status => _status.value;

  final RxList<DataModel> _ports = RxList<DataModel>();
  List<DataModel> get model => _ports;

  final RxList<String> _serialData = RxList<String>();
  List<String> get serialData => _serialData;

  final Rxn<StreamSubscription<String>> _subscription =
      Rxn<StreamSubscription<String>>();
  final Rxn<Transaction<String>> _transaction = Rxn<Transaction<String>>();

  final Rxn<UsbDevice> _device = Rxn<UsbDevice>();

  Future<bool> connectTo(UsbDevice? device) async {
    _serialData.clear();

    if (_subscription.value != null) {
      _subscription.value?.cancel();
      _subscription.value = null;
    }

    if (_transaction.value != null) {
      _transaction.value?.dispose();
      _transaction.value = null;
    }

    if (_port.value != null) {
      _port.value?.close();
      _port.value = null;
    }

    if (device == null) {
      _device.value = null;
      _status.value = "Disconnected";
    }

    _port.value = await device?.create();
    if (_port.value == null) {
      _status.value = "Disconnected";
      return false;
    }

    if (await (_port.value?.open()) == true) {
      _device.value = device;
      _status.value = "Connected";
    }

    await _port.value?.setDTR(true);
    await _port.value?.setRTS(true);
    await _port.value?.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction.value = Transaction.stringTerminated(
      _port.value?.inputStream as Stream<Uint8List>,
      Uint8List.fromList([13, 10]),
    ).stream.listen((String line) {
      _serialData.add(line);
      if (_serialData.length > 10) {
        _serialData.removeAt(0);
      }
      update();
    }) as Transaction<String>;

    return true;
  }

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

  @override
  void onInit() {
    UsbSerial.usbEventStream?.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
    super.onInit();
  }


  @override
  void onClose() {
    connectTo(null);
    super.onClose();
  }
}

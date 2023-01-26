import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/modules/resources/dimens.dart';
import 'package:heart_usb/app/modules/utils/constants.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';
import '../../../data/data_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/graph_model.dart';
import '../../utils/strings.dart';

class ReceiveDataGrapheController extends GetxController {
  RxInt bpm = 0.obs;
  Timer? timer;

  final Rxn<UsbPort> _port = Rxn<UsbPort>();
  final RxString _status = Strings.idle.obs;

  final RxList<DataModel> _ports = RxList<DataModel>();

  final RxList<GraphModel> _serialData = RxList();
  final RxList<GraphModel> _serialDataSave = RxList();

  final RxList<int> _beats = RxList.empty(growable: true);

  final Rxn<StreamSubscription<String>> _subscription =
      Rxn<StreamSubscription<String>>();
  final Rxn<Transaction<String>> _transaction = Rxn<Transaction<String>>();

  final Rxn<UsbDevice> _device = Rxn<UsbDevice>();

  /// Count time for data
  int count = 0;

  /// Status of device
  String get status => _status.value;

  /// Data input from device
  List<GraphModel> get serialData => _serialData.value;
  List<GraphModel> get serialDataSave => _serialDataSave.value;

  /// Data calculate fro BPM
  List<int> get beats => _beats;

  // Recording time
  Rxn<Duration> countdownDuration = Rxn<Duration>();
  Rxn<Duration> startCountdownRecord = Rxn<Duration>();
  Rxn<Duration> duration = Rxn<Duration>();
  Timer? timerRecord;

  bool countDown = true;

  void reset() {
    if (countDown) {
      duration(countdownDuration.value);
    } else {
      duration(const Duration());
    }
  }

  void startTimer() {
    startCountdownRecord(countdownDuration.value);
    resetData();
    timerRecord = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;

    final seconds = duration.value!.inSeconds + addSeconds;
    if (seconds < 0) {
      timerRecord?.cancel();
      dialogAnalysis();
    } else {
      duration(Duration(seconds: seconds));
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timerRecord?.cancel();
  }

  /// Connect device with app
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
      _status.value = Strings.disconnected;
    }

    _port.value = await device?.create();
    if (_port.value == null) {
      _status.value = Strings.disconnected;
      return false;
    }

    if (await (_port.value?.open()) == true) {
      _device.value = device;
      _status.value = Strings.connected;
    }

    await _port.value?.setDTR(true);
    await _port.value?.setRTS(true);
    await _port.value?.setPortParameters(Constants.port, UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction.value = Transaction.stringTerminated(
      _port.value?.inputStream as Stream<Uint8List>,
      Uint8List.fromList([13, 10]),
    ).stream.listen((String line) {
      final time = DateTime.now();
      _serialData.add(GraphModel(y: int.parse(line), x: count++));
      _serialDataSave
          .add(GraphModel(y: int.parse(line), x: count++, time: time));
      // calcualteBPM(int.parse(line));
      if (_serialData.length > Constants.lenghtData) {
        _serialData.removeAt(0);
      }
      if (_serialDataSave.length >
          (startCountdownRecord.value?.inMilliseconds as int)) {
        _serialDataSave.removeAt(0);
      }
      update();
    }) as Transaction<String>?;
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
    timer?.cancel();

    for (var device in devices) {
      _ports.add(DataModel(device));
      connectTo(_device.value == device ? null : device)
          .then((value) => _getPorts());
      update();
    }
  }

  /// add peak data
  // void calcualteBPM(int data) {
  //   if (data > Constants.threshold) {
  //     _beats.add(data);
  //   }
  // }

  void getBPM() {
    bpm.value = beats.length * 10;
    beats.clear();
    update();
  }

  Future<void> generateCsv() async {
    List<List<dynamic>> data = [
      ["hart", "time"],
    ];
    for (var lis in serialDataSave) {
      data.add([lis.y, lis.time]);
    }
    String csvData = const ListToCsvConverter().convert(data);
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final date = DateTime.now();
    final path = "$directory/$date-ecg.csv";
    final File file = File(path);

    await file.writeAsString(csvData);
    // print(serialDataSave.length);
    // Get.toNamed(Routes.ANALYSIS, arguments: file);
  }

  void dialogAnalysis() {
    Get.defaultDialog(
      title: "Simpan untuk Analisis?",
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.space16),
        child: const Text(
            "Simpan untuk mengetahui informasi lebih lanjut pada analisis nanti"),
      ),
      confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: () {
            generateCsv();
            connectTo(null);
            Get.back();
          },
          child: const Text("Simpan")),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 0),
        onPressed: () {
          Get.back();
        },
        child: const Text("Tidak"),
      ),
    );
  }

  void resetData() {
    if (serialData.isNotEmpty && serialDataSave.isNotEmpty) {
      serialData.clear();
      serialDataSave.clear();
    }
  }

  void setTimerRecord(String hour, String minute) {
    countdownDuration(Duration(minutes: int.parse(minute)));
    reset();
    timerRecord?.cancel();
  }

  @override
  void onInit() {
    UsbSerial.usbEventStream?.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();

    resetData();

    duration(const Duration());
    countdownDuration(const Duration(minutes: 0));
    startCountdownRecord(const Duration(minutes: 2));

    reset();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    connectTo(null);
    timer?.cancel();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onClose();
  }
}

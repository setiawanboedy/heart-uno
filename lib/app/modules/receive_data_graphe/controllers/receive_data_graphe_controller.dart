import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/datasource/model/heart_item_model.dart';
import '../../../data/domain/usecase/save_heart.dart';
import '../../resources/dimens.dart';
import '../../utils/constants.dart';
import '../../../../core/failure/failure.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';
import '../../../data/data_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/graph_model.dart';
import '../../utils/strings.dart';

class ReceiveDataGrapheController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController desc = TextEditingController();

  final SaveHeart saveHeart = Get.put(SaveHeart());

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
      generateCsv();
      connectTo(null);
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
    saveToLocal(path);
  }

  void saveToLocal(String path) async {
    final params = HeartItemModel(
      name: name.text,
      age: int.parse(age.text),
      desc: desc.text,
      path: path,
    );
    final data = await saveHeart.call(params);
    data.fold((l) {
      if (l is ServerFailure) {
        if (kDebugMode) {
          print(l.message);
        }
      }
    }, (r) {
      if (kDebugMode) {
        print(r);
      }
    });
  }

  void dialogAnalysis() {
    Get.defaultDialog(
      title: "Simpan untuk Analisis?",
      content: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.space16),
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(hintText: "Nama"),
              ),
              TextFormField(
                controller: age,
                decoration: const InputDecoration(hintText: "Umur"),
              ),
              TextFormField(
                controller: desc,
                decoration: const InputDecoration(hintText: "Deskripsi"),
              )
            ],
          )),
      confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: () {
            
            startTimer();
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

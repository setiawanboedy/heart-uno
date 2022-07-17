import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heart_usb/app/modules/utils/constants.dart';

class StorageManager {
  String kPort = 'port';

  final box = GetStorage();

  set port(int? value) => box.write(kPort, value ?? Constants.port);
  int? get port => box.read(kPort);
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heart_usb/app/data/datasource/local/storage_manager.dart';

Future<void> dependencyInjection() async {
  await GetStorage.init();
  Get.put<StorageManager>(StorageManager());
}

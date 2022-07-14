import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker = Get.put(DataConnectionChecker());

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

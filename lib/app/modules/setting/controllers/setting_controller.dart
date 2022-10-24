import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../../utils/strings.dart';

class SettingController extends GetxController {
  final HomeController home = Get.find<HomeController>();
  RxList<String> ports = [
    'Pilih Port',
    '9600',
    '38400',
    '57600',
    '115200',
  ].obs;

  RxString selected = Strings.defaultValue.obs;

  @override
  void onInit() {
    selected(home.portUsb);
    super.onInit();
  }


}

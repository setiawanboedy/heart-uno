import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/pages/splash_screen.dart';
import '../modules/receive_data/bindings/receive_data_binding.dart';
import '../modules/receive_data/views/receive_data_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.RECEIVE_DATA,
      page: () => const ReceiveDataView(),
      binding: ReceiveDataBinding(),
    ),
  ];
}

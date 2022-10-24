import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'di/dependency_injection.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await dependencyInjection();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Heart Uno",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(),
    ),
  );
}

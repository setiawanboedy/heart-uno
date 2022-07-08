import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/core.dart';

import 'app/routes/app_pages.dart';

void main() {
  SyncfusionLicense.registerLicense("@32302e322e30OWgPv4rxjXrxLVdW/Aa7d2A3D9f6+4btyXzA1LCn99Q=");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Heart Rate USB",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

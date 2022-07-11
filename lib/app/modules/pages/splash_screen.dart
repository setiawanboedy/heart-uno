import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/modules/pages/parent.dart';
import 'package:heart_usb/app/modules/resources/palette.dart';
import 'package:heart_usb/app/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _goToMain() {
    Future.delayed(
      const Duration(seconds: 2),
      () => Get.offAndToNamed(Routes.HOME),
    );
  }

  @override
  void initState() {
    _goToMain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      backgroundColor: Palette.bgColor,
      child: Center(
        child: SizedBox(
          width: Get.size.width * 0.3,
          height: Get.size.height * 0.3,
          child: Image.asset("assets/images/splash_icon.png"),
        ),
      ),
    );
  }
}

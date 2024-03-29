import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../resources/palette.dart';
import 'parent.dart';

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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardGraph extends StatelessWidget {
  final Widget? image;
  const CardGraph({
    Key? key, this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Container(
          height: Get.size.height * 0.35,
          width: Get.size.width,
          color: Colors.white,
          child: image,
        ),
      ),
    );
  }
}

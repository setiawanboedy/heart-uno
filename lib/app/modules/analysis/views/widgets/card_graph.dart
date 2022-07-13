import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardGraph extends StatelessWidget {
  const CardGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Container(
          height: Get.size.height * 0.3,
          color: Colors.white,
        ),
      ),
    );
  }
}

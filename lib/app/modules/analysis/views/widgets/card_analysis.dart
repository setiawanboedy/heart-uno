import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/domain/entities/heart.dart';

class CardAnalysis extends StatelessWidget {
  final int? value;
  final Heart? heart;
  const CardAnalysis({
    Key? key,
    this.value,
    this.heart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: false,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text(
                  "IBI",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("543")
              ],
            ),
          ),
        ),
        Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text(
                  "IBI",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("543")
              ],
            ),
          ),
        )
      ],
    );
  }
}

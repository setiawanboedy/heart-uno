import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardAnalysis extends StatelessWidget {
  final int? value;
  const CardAnalysis({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: false,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: value,
        itemBuilder: (BuildContext ctx, index) {
          return Card(
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
          );
        });
  }
}

import 'package:flutter/material.dart';

class CardAnalysis extends StatelessWidget {
  final String? value;
  final String? title;
  const CardAnalysis({
    Key? key,
    this.value,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "$title",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text("$value")
          ],
        ),
      ),
    );
  }
}

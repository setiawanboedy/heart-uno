import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class SpacerV extends StatelessWidget {
  const SpacerV({Key? key, this.value}) : super(key: key);
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: value ?? Dimens.space8,
    );
  }
}
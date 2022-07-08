import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class SpacerH extends StatelessWidget {
  const SpacerH({Key? key, this.value}) : super(key: key);
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: value ?? Dimens.space8,
    );
  }
}
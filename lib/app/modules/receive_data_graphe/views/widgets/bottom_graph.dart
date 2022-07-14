import 'package:flutter/material.dart';

import '../../../resources/dimens.dart';
import '../../../resources/palette.dart';
import '../../../widgets/spacer_v.dart';

class BottomGraph extends StatelessWidget {
  final int? bpm;
  final VoidCallback? func;
  final Widget? textButton;
  const BottomGraph({
    Key? key,
    this.bpm,
    this.func,
    this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Palette.bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.cornerRadius),
            topRight: Radius.circular(Dimens.cornerRadius),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "$bpm BPM",
                    style:
                        TextStyle(fontSize: Dimens.h6, color: Colors.white),
                  ),
                  const SpacerV(
                  ),
                  ElevatedButton(
                    onPressed: func,
                    child: SizedBox(
                      width: Dimens.space50 * 2,
                      height: Dimens.buttonH,
                      child: Center(child: textButton),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

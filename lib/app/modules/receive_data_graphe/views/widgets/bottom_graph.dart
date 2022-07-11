import 'package:flutter/material.dart';
import 'package:heart_usb/app/modules/widgets/spacer_v.dart';

import '../../../resources/dimens.dart';
import '../../../resources/palette.dart';

class BottomGraph extends StatelessWidget {
  final int? bpm;
  const BottomGraph({
    Key? key, this.bpm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
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
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "0.281",
                              style: TextStyle(
                                  color: Colors.white, fontSize: Dimens.h6),
                            ),
                            const Text(
                              "HF",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "0.281",
                              style: TextStyle(
                                  color: Colors.white, fontSize: Dimens.h6),
                            ),
                            const Text(
                              "LF",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "0.281",
                              style: TextStyle(
                                  color: Colors.white, fontSize: Dimens.h6),
                            ),
                            const Text(
                              "LF/HF",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "$bpm bpm",
                    style: TextStyle(fontSize: Dimens.h6, color: Colors.white),
                  ),
                  SpacerV(
                    value: Dimens.h6,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.all(Dimens.button),
                      child: const Text("Analisis Sinyal"),
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

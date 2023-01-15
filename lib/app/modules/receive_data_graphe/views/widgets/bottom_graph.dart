import 'package:flutter/material.dart';

import '../../../resources/dimens.dart';
import '../../../resources/palette.dart';
import '../../../widgets/spacer_v.dart';

class BottomGraph extends StatelessWidget {
  final VoidCallback? func;
  final VoidCallback? startPressed;
  final Widget? textButton;
  final Duration duration;
  const BottomGraph({
    Key? key,
    this.func,
    this.textButton,
    this.startPressed,
    required this.duration,
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
                  buildTime(),
                  const SpacerV(),
                  buildButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: func,
            child: SizedBox(
              width: Dimens.space50 * 2,
              height: Dimens.buttonH,
              child: Center(child: textButton),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
            onPressed: startPressed,
            child: SizedBox(
              width: Dimens.space50 * 2,
              height: Dimens.buttonH,
              child: Center(child: Text("Mulai")),
            ),
          ),
        ],
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours),
      const Text(
        ":",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      buildTimeCard(time: minutes),
      const Text(
        ":",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      buildTimeCard(time: seconds),
    ]);
  }

  Widget buildTimeCard({required String time}) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " $time ",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
        ],
      );
}

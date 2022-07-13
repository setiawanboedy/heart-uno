import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../data/domain/entities/heart.dart';
import '../../pages/parent.dart';
import '../../resources/dimens.dart';
import '../../resources/palette.dart';
import '../../widgets/spacer_v.dart';

import '../controllers/analysis_controller.dart';
import 'widgets/card_analysis.dart';
import 'widgets/card_graph.dart';

class AnalysisView extends GetView<AnalysisController> {
  final Heart heart = Get.arguments as Heart;
  AnalysisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.bgColor,
        title: Text("Analisis Sinyal Jantung | ${heart.data?.bpm}"),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Sinyal jantung",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            const SpacerV(),
            const CardGraph(),
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Time Domain Analysis",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            const SpacerV(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: Get.size.width,
                height: Get.size.height * 0.35,
                child: const CardAnalysis(),
              ),
            ),
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Frequency Domain Analysis",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            const SpacerV(),
            const CardGraph(),
            SpacerV(
              value: Dimens.space16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Frequency",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.body1,
                  color: Palette.text,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: Get.size.width,
                height: Get.size.height * 0.2,
                child: const CardAnalysis(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

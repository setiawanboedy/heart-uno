import 'package:get/get.dart';

class GenericState<T1, T2, T3> {
  T1? original;
  T2? spectrum;
  T3? interpolate;

  GenericState({this.original, this.spectrum, this.interpolate});
}

abstract class AnalysisTwoController<T1, T2, T3> extends GetxController
    with StateMixin<GenericState<T1, T2, T3>> {}

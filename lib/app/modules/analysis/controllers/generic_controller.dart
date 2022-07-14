import 'package:get/get.dart';

class GenericState<T1, T2> {
  T1? state1;
  T2? state2;

  GenericState({this.state1, this.state2});
}

abstract class AnalysisTwoController<T1, T2> extends GetxController with StateMixin<GenericState<T1, T2>>{}
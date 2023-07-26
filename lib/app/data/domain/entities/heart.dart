import 'package:equatable/equatable.dart';

class Heart extends Equatable {
  final double? ibi;
  final double? bpm;
  final double? sdnn;
  final double? rmssd;

  const Heart({this.ibi, this.bpm, this.sdnn, this.rmssd});
  
  @override
  List<Object?> get props => [ibi, bpm, sdnn, rmssd];
}

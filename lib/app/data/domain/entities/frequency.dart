import 'package:equatable/equatable.dart';

class Frequency extends Equatable {
  final double? vlf;
  final double? hf;
  final double? lf;

  const Frequency({this.vlf, this.lf, this.hf});
  
  @override
  List<Object?> get props => [vlf,hf,lf];
}

import 'package:equatable/equatable.dart';

import '../../datasource/model/heart_analysis_model.dart';

class Heart extends Equatable {
  final Data? data;

  const Heart(this.data);
  
  @override
  List<Object?> get props => [data];
}

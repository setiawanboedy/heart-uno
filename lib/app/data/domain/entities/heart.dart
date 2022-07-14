import 'package:equatable/equatable.dart';
import '../../datasource/model/heart_analysis_response.dart';

class Heart extends Equatable {
  final Data? data;

  const Heart(this.data);
  
  @override
  List<Object?> get props => [data];
}

class Original extends Equatable {
  final String? oriUrl;

  const Original(this.oriUrl);
  
  @override
  List<Object?> get props => [oriUrl];
}

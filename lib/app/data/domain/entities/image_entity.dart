import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String? image;

  const ImageEntity({this.image});
  
  @override
  List<Object?> get props => [image];
}

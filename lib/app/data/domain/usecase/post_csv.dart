import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repository/heart_repository.dart';

class PostCsv extends UseCase<String, HeartParams> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, String>> call(HeartParams params) {
    return repository.uploadCsv(params);
  }
}

class HeartParams extends Equatable {
  final File file;

  const HeartParams(this.file);

  File toJson() => file;

  @override
  List<Object?> get props => [file];
}

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../datasource/heart_datasource.dart';
import '../domain/entities/heart.dart';
import '../../../core/error/exceptions.dart';

import '../../../core/failure/failure.dart';
import '../domain/usecase/post_csv.dart';

abstract class HeartRepository {
  Future<Either<Failure, Heart>> uploadCsv(HeartParams params);
}

class HeartRepositoryImpl implements HeartRepository {
  final HeartDatasource heartDatasource = Get.put(HeartDatasourceImpl());

  @override
  Future<Either<Failure, Heart>> uploadCsv(HeartParams params) async {
    try {
      final response = await heartDatasource.uploadCSV(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

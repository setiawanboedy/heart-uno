import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../datasource/heart_datasource.dart';
import '../domain/entities/heart.dart';
import '../domain/usecase/post_csv.dart';

abstract class HeartRepository {
  Future<Either<Failure, Heart>> uploadCsv(HeartParams params);
  Future<Either<Failure, String>> getOriginal(NoParams params);
  Future<Either<Failure, String>> getSpectrum(NoParams params);
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
  
  @override
  Future<Either<Failure, String>> getOriginal(NoParams params) async{
    try {
      final response = await heartDatasource.getOriginal(params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, String>> getSpectrum(NoParams params) async {
   try {
      final response = await heartDatasource.getSpectrum(params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

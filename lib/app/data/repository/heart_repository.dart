import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../datasource/model/detail_model.dart';
import '../datasource/model/heart_item_model.dart';
import '../datasource/model/original_model.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../datasource/heart_datasource.dart';
import '../domain/entities/heart.dart';
import '../domain/usecase/post_csv.dart';

abstract class HeartRepository {
  Future<Either<Failure, String>> uploadCsv(HeartParams params);
  Future<Either<Failure, Heart>> getAnalysis(NoParams params);
  Future<Either<Failure, OriginalModel>> getOriginal(NoParams params);
  Future<Either<Failure, String>> getSpectrum(NoParams params);

  Future<Either<Failure, int>> saveHeartItem(HeartItemModel params);
  Future<Either<Failure, HeartListModel>> getHeartItems();
  Future<Either<Failure, HeartItemModel>> getHeartItem(int id);
  Future<void> deleteHeartItem(int id);

  Future<Either<Failure, int>> saveHeartDetail(DetailModel analis);
  Future<Either<Failure, DetailModel>> getHeartDetail(int id);
  Future<void> deleteHeartDetail(int id);
}

class HeartRepositoryImpl implements HeartRepository {
  final HeartDatasource heartDatasource = Get.put(HeartDatasourceImpl());

  @override
  Future<Either<Failure, String>> uploadCsv(HeartParams params) async {
    try {
      final response = await heartDatasource.uploadCSV(params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Heart>> getAnalysis(NoParams params) async {
    try {
      final response = await heartDatasource.getAnalysis(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, OriginalModel>> getOriginal(NoParams params) async {
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

  @override
  Future<void> deleteHeartItem(int id) async {
    try {
      await heartDatasource.deleteHeartItem(id);
    } on LocalException catch (e) {
      throw Left(LocalFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HeartItemModel>> getHeartItem(int id) async {
    try {
      final response = await heartDatasource.getHeartItem(id);
      return Right(HeartItemModel.fromMap(response));
    } on LocalException catch (e) {
      return Left(LocalFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HeartListModel>> getHeartItems() async {
    try {
      final response = await heartDatasource.getHeartItems();

      return Right(HeartListModel.fromMap(response));
    } on LocalException catch (e) {
      return Left(LocalFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> saveHeartItem(HeartItemModel params) async {
    try {
      final response = await heartDatasource.saveHeartItem(params);
      return Right(response);
    } on LocalException catch (e) {
      return Left(LocalFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> saveHeartDetail(DetailModel analis) async {
    try {
      final response = await heartDatasource.saveHeartDetail(analis);
      return Right(response);
    } on LocalException catch (e) {
      return Left(LocalFailure(e.message));
    }
  }

  @override
  Future<void> deleteHeartDetail(int id) async {
    try {
      await heartDatasource.deleteHeartDetail(id);
    } on LocalException catch (e) {
      throw Left(LocalFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, DetailModel>> getHeartDetail(int id) async {
    try {
      final response = await heartDatasource.getHeartDetail(id);
      if (response != null) {
        return Right(DetailModel.fromMap(response));
      } else {
        return Right(DetailModel());
      }
    } on LocalException catch (e) {
      return Left(LocalFailure(e.message));
    }
  }
}

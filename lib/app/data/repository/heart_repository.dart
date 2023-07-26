import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/domain/entities/image_entity.dart';
import '../datasource/model/heart_item_model.dart';
import '../datasource/model/original_model.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/failure/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../datasource/heart_datasource.dart';
import '../domain/entities/frequency.dart';
import '../domain/entities/heart.dart';
import '../domain/usecase/post_csv.dart';

abstract class HeartRepository {
  Future<Either<Failure, String>> uploadCsv(HeartParams params);
  Future<Either<Failure, Heart>> getAnalysis(NoParams params);
  Future<Either<Failure, Frequency>> getFrequency(NoParams params);
  Future<Either<Failure, OriginalModel>> getOriginal(NoParams params);
  Future<Either<Failure, ImageEntity>> getSpectrum(NoParams params);
  Future<Either<Failure, ImageEntity>> getDeteksi(NoParams params);
  Future<Either<Failure, ImageEntity>> getKoreksi(NoParams params);

  Future<Either<Failure, int>> saveHeartItem(HeartItemModel params);
  Future<Either<Failure, HeartListModel>> getHeartItems();
  Future<Either<Failure, HeartItemModel>> getHeartItem(int id);
  Future<void> deleteHeartItem(int id);

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
  Future<Either<Failure, ImageEntity>> getSpectrum(NoParams params) async {
    try {
      final response = await heartDatasource.getSpectrum(params);
      return Right(response.toEntity());
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
  Future<Either<Failure, ImageEntity>> getDeteksi(NoParams params) async {
      try {
      final response = await heartDatasource.getDeteksi(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, Frequency>> getFrequency(NoParams params) async {
        try {
      final response = await heartDatasource.getFrequecy(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, ImageEntity>> getKoreksi(NoParams params) async {
       try {
      final response = await heartDatasource.getKoreksi(params);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

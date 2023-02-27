import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../datasource/model/original_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repository/heart_repository.dart';

class GetOriginal extends UseCase<OriginalModel, NoParams> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, OriginalModel>> call(NoParams params) {
    return repository.getOriginal(params);
  }
}



import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/datasource/model/detail_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repository/heart_repository.dart';

class SaveDetail extends UseCase<int, DetailModel> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, int>> call(DetailModel params) {
    return repository.saveHeartDetail(params);
  }
}

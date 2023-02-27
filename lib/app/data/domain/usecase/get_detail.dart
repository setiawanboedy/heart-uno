import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/datasource/model/detail_model.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';

import '../../repository/heart_repository.dart';

class GetHeartDetail extends UseCase<DetailModel, int> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, DetailModel>> call(int params) {
    return repository.getHeartDetail(params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:heart_usb/app/data/datasource/model/heart_item_model.dart';
import 'package:heart_usb/core/failure/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repository/heart_repository.dart';

class SaveHeart extends UseCase<int, HeartItemModel> {
  final HeartRepository repository = Get.put(HeartRepositoryImpl());

  @override
  Future<Either<Failure, int>> call(HeartItemModel params) {
    return repository.saveHeartItem(params);
  }
}
